if [ "x$USER" = "xvslinko" ]; then
  VSLINKO_USER="%{$fg[green]%}-"
else
  VSLINKO_USER="%{$fg[red]%}%n"
fi

VSLINKO_AT="%{$fg[white]%}@"

if [ "x$HOST" = "xvslinko-macbook" ]; then
  VSLINKO_HOST="%{$fg[green]%}-"
elif [ "x$HOST" = "xvslinko-workspace" ]; then
  VSLINKO_HOST="%{$fg[green]%}workspace"
else
  VSLINKO_HOST="%{$fg[red]%}%m"
fi

VSLINKO_COLON="%{$fg[white]%}:"

VSLINKO_PATH="%{$fg[green]%}%~"

local vslinko_propmt_char="%(?.%{$fg[white]%}.%{$fg[red]%})%(!.#.$)%{$reset_color%}"

PROMPT='$VSLINKO_USER$VSLINKO_AT$VSLINKO_HOST$VSLINKO_COLON$VSLINKO_PATH$(git_prompt_info) ${vslinko_propmt_char} '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*"
