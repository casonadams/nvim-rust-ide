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

export NOTES_DIR=~/Dropbox/notes/
export EDITOR=nvim
source $HOME/.key-bindings.bash
export HISTSIZE=100000

PATH="~/.cargo/bin:$PATH"
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
git_stuff() {
  git_branch=$(git status --ignore-submodules -sb 2> /dev/null | head -n1 | tr -d '# ' | cut -f1 -d'.')
  if [[ $git_branch == "" ]];then
    echo -e ""
  elif [[ $git_branch == *"Nocommit"* ]];then
    echo -e "No commits"
  else
    git_remote=`git config --get remote.origin.url`
    git_icon=`if [[ $git_remote == *'gitlab'* ]]; then \
      echo -e "\e[38;5;214m \033[0m"; \
    elif [[ $git_remote == *'github'* ]]; then \
      echo -e "\033[0m "; \
    elif [[ $git_remote == *'bitbucket'* ]]; then \
      echo -e "\e[38;5;26m \033[0m"; \
    else \
      echo ''; \
      fi`
          echo -e "$git_icon$git_branch"
  fi
}
prompt() {
  PS1="\e[2m$(date +%H:%M:%S.%3N)\033[0m $(git_stuff)\n\w$ "
}
PROMPT_COMMAND=prompt

source <(kubectl completion bash)
