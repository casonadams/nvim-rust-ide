# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# aliases
alias vi='nvim'
alias vim='nvim'

source $HOME/.key-bindings.bash

PATH="~/.cargo/bin:$PATH"
export EDITOR=nvim
export HISTSIZE=100000
export MAKEFLAGS="-j8"
export FZF_DEFAULT_COMMAND="fd"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type file"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=50%
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --theme=gruvbox --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--bind '?:toggle-preview'
"

prompt() {
  PS1='\e[2m$(date +%H:%M:%S.%3N) \w\e[0m\n# '
}
PROMPT_COMMAND=prompt
