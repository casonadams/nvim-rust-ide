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

export NOTES_DIR=~/Dropbox/notes/
export EDITOR=nvim
source $HOME/.key-bindings.bash
export HISTSIZE=100000

PATH="~/.cargo/bin:$PATH"
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
git_stuff() {
  # git_branch=$(git status --ignore-submodules -sb 2> /dev/null | head -n1 | tr -d '# ' | cut -f1 -d'.')
  git_branch=$(git branch --show-current 2> /dev/null)
  if [[ $git_branch == "" ]];then
    echo -e ""
  elif [[ $git_branch == *"Nocommit"* ]];then
    echo -e "No commits"
  else
    echo -e "$git_branch"
  fi
}
prompt() {
  PS1="\e[2m$(date +%H:%M:%S.%3N) \e[4m$(git_stuff)\033[0m\n\w$ "
}
PROMPT_COMMAND=prompt
export MAKEFLAGS="-j8"

