export TERM=xterm-256color
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=vim

ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.oh-my-custom-zsh"
ZSH_THEME="vslinko"
DISABLE_AUTO_UPDATE="true"
plugins=(atom brew composer docker emacs git history node npm osx rsync sublime sudo symfony2 systemd)

source "$ZSH/oh-my-zsh.sh"

WORKSPACE="$HOME/.workspace"
hash -d qwe="$WORKSPACE"

if [ -d "$WORKSPACE/_bin" ]; then
  export PATH="$WORKSPACE/_bin:$PATH"
fi
