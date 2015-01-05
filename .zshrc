export TERM=xterm-256color

ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="essembeh"
if [[ "$OSTYPE" != "darwin"* ]]; then DISABLE_AUTO_UPDATE="true"; fi
plugins=(atom brew coffee composer gem git knife npm sublime sudo symfony2 vagrant)

source "$ZSH/oh-my-zsh.sh"

unsetopt correct_all

alias -r gaa="git add ."
alias -r gdh="git diff HEAD --"
hash -d qwe="$HOME/workspace"

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ -d "$HOME/workspace/_bin" ]; then
  export PATH="$HOME/workspace/_bin:$PATH"
fi

npmv() {
  npm view $1 version
}
