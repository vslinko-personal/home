from libqtile import layout, bar, widget, hook
from libqtile.command import lazy
from libqtile.config import Key, Group, Match, Screen
import subprocess
import re
import os


def get_screen_resolution(screen_index=0):
  output = subprocess.Popen('xrandr', stdout=subprocess.PIPE).stdout.read().decode('UTF-8')
  output = [row for row in output.splitlines() if 'connected' in row][screen_index]
  output = re.search('\d+x\d+', output).group(0)
  output = tuple(map(int, output.split('x')))
  return output


def move_to_group_and_show(group):
    def _move_to_group_and_show(qtile):
        if not qtile.currentWindow:
            return

        qtile.currentWindow.togroup(group.name)
        qtile.groupMap[group.name].cmd_toscreen()

    return _move_to_group_and_show


def should_be_floating(window):
    if window.get_wm_type() == 'dialog':
        return True

    if bool(window.get_wm_transient_for()):
        return True

    wm_class = window.get_wm_class()

    if wm_class is None:
        return True

    for cls in tuple(wm_class):
        if cls.lower() in float_windows:
            return True

    return False


keys = [
    # Qtile management
    Key(['mod4', 'control'], 'w', lazy.shutdown()),
    Key(['mod4', 'control'], 'r', lazy.restart()),

    # Layout management
    Key(['mod4'], 'Tab', lazy.layout.next()),
    Key(['mod4'], 'p', lazy.nextlayout()),

    Key(['mod4'], 'k', lazy.layout.down()),
    Key(['mod4'], 'j', lazy.layout.up()),
    Key(['mod4'], 'h', lazy.screen.prevgroup()),
    Key(['mod4'], 'l', lazy.screen.nextgroup()),

    Key(['mod4', "shift"], "k", lazy.layout.shuffle_down()),
    Key(['mod4', "shift"], "j", lazy.layout.shuffle_up()),

    Key(['mod4'], "n", lazy.layout.normalize()),
    Key(['mod4'], "o", lazy.layout.maximize()),

    Key(['mod4'], "i", lazy.layout.grow()),
    Key(['mod4'], "m", lazy.layout.shrink()),

    # Window management
    Key(['mod4'], 'w', lazy.window.kill()),
    Key(['mod4'], 'r', lazy.spawncmd()),
    Key(['mod4'], 'Return', lazy.spawn('terminator')),
    Key(['mod4', 'shift'], 'c', lazy.spawn('google-chrome-stable')),
]


groups = [
    Group('Work'),
    Group('Web'),
    Group(
        name='Chat',
        matches=[Match(wm_class=["Skype"])]
    ),
]

for i, group in enumerate(groups):
    keys.append(Key(['mod4'], str(i + 1), lazy.group[group.name].toscreen()))
    keys.append(Key(['mod4', 'control'], str(i + 1), lazy.function(move_to_group_and_show(group))))
    keys.append(Key(['mod4', 'shift'], str(i + 1), lazy.window.togroup(group.name)))


layouts = [
    layout.MonadTall(),
    layout.Max(),
    layout.RatioTile(),
    layout.TreeTab(
        font='Droid Sans Mono'
    ),
]


bottom_bar = bar.Bar(
    widgets=[
        widget.GroupBox(
            borderwidth=1,
            rounded=False,
            fontsize=None,
            inactive='999999',
            this_current_screen_border='ffffff'
        ),
        widget.Sep(),
        widget.WindowName(),
        widget.Prompt(),
        widget.Systray(),
        widget.Notify(),
        widget.Sep(),
        widget.CurrentLayout(),
        widget.Sep(),
        widget.KeyboardLayout(
            configured_keyboards=['us', 'ru']
        ),
        widget.Sep(),
        widget.Clock(
            format='%Y-%m-%d %H:%M:%S'
        ),
        widget.Sep(),
        widget.Battery(
            format="{char}{percent:2.0%}",
            charge_char='+',
            discharge_char='-'
        ),
    ],
    size=27,
    background=['333333', '111111'],
)


screens = [
    Screen(
        bottom=bottom_bar,
    ),
]


widget_defaults = dict(
    font='Droid Sans',
    fontsize=14,
    padding=3
)

follow_mouse_focus = False

float_windows = set([])


@hook.subscribe.client_new
def dialogs(window):
    if should_be_floating(window.window):
        window.floating = True


@hook.subscribe.startup
def wallpaper():
    resolution = 'x'.join(map(str, get_screen_resolution()))
    wallpaper_path = os.path.expanduser(os.path.join('~', '.wallpapers', resolution + '.png'))

    if not os.path.isfile(wallpaper_path):
        return

    subprocess.Popen(['feh', '--bg-fill', wallpaper_path])
