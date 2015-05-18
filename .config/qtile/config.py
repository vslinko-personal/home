import subprocess
import os

from libqtile import layout, bar, widget, hook
from libqtile.command import lazy
from libqtile.config import Key, Group, Match, Screen


keys = [
    Key(['mod4', 'control'], 'w', lazy.shutdown()),
    Key(['mod4', 'control'], 'r', lazy.restart()),

    Key(['mod4'], 'Right', lazy.screen.nextgroup()),
    Key(['mod4'], 'Left', lazy.screen.prevgroup()),

    Key(['mod4'], 'apostrophe', lazy.nextlayout()),

    Key(['mod4'], 'Tab', lazy.layout.next()),
    Key(['mod4'], 'Down', lazy.layout.down()),
    Key(['mod4'], 'Up', lazy.layout.up()),

    Key(['mod4'], 'bracketleft', lazy.layout.normalize()),
    Key(['mod4'], 'bracketright', lazy.layout.maximize()),

    Key(['mod4'], 'equal', lazy.layout.grow()),
    Key(['mod4'], 'minus', lazy.layout.shrink()),

    Key(['mod4'], 'w', lazy.window.kill()),
    Key(['mod4'], 'r', lazy.spawncmd()),
    Key(['mod4'], 'Return', lazy.spawn('lxterminal')),
    Key(['mod4', 'shift'], 'c', lazy.spawn('google-chrome-stable')),

    Key(['mod4', 'shift'], 'Escape', lazy.spawn('systemctl poweroff')),
]


groups = [
    Group('Terminals'),
    Group(
        name='Editor',
        matches=[Match(wm_class=['Emacs'])],
    ),
    Group(
        name='Browser',
        matches=[Match(wm_class=['Google-chrome-stable'])],
    ),
    Group('O1'),
    Group('O2'),
    Group('O3'),
]

for i, group in enumerate(groups):
    no = str(i + 1)
    keys.append(Key(['mod4'], no, lazy.group[group.name].toscreen()))
    keys.append(Key(['mod4', 'shift'], no, lazy.window.togroup(group.name)))


layouts = [
    layout.MonadTall(),
    layout.Max(),
    layout.TreeTab(
        bg_color='cccccc',
        active_bg='505050',
        inactive_bg='909090',
        font='Droid Sans Mono',
        section_fg='000000',
    ),
]


screens = [
    Screen(
        bottom=bar.Bar(
            widgets=[
                widget.GroupBox(
                    active='000000',
                    inactive='000000',
                    borderwidth=1,
                    rounded=False,
                    this_current_screen_border='000000',
                    padding=2,
                ),
                widget.Sep(),
                widget.WindowName(),
                widget.Prompt(),
                widget.Systray(),
                widget.Notify(),
                widget.Sep(),
                widget.CurrentLayout(),
                widget.Sep(),
                widget.Pacman(unavailable='000000'),
                widget.Sep(),
                widget.KeyboardLayout(
                    configured_keyboards=['us', 'ru'],
                ),
                widget.Sep(),
                widget.Clock(
                    format='%Y-%m-%d %H:%M:%S',
                ),
                widget.Sep(),
                widget.Battery(
                    format='{char}{percent:2.0%}',
                    charge_char='+',
                    discharge_char='-',
                ),
            ],
            size=27,
            background='cccccc',
        ),
    ),
]


widget_defaults = dict(
    font='Droid Sans',
    fontsize=14,
    foreground='000000',
    padding=3,
)


@hook.subscribe.startup
def vboxclient():
    if os.path.isfile('/usr/bin/VBoxClient-all'):
        subprocess.Popen(['/usr/bin/VBoxClient-all'])
