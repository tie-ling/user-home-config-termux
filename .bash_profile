export LANG="en_US.UTF-8"
# copied directly from NixOS default
# Provide a nice prompt if the terminal supports it.
if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
  PROMPT_COLOR="1;31m"
  ((UID)) && PROMPT_COLOR="1;32m"
  if [ -n "$INSIDE_EMACS" ]; then
    # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
    PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
  else
    PS1="\n\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
  fi
  if test "$TERM" = "xterm"; then
    PS1="\[\033]2;\h:\u:\w\007\]$PS1"
  fi
fi

    # Use longer shell history
export HISTFILESIZE=10000
export HISTSIZE=10000


# save timestamp (unix epoch) in history file
export HISTTIMEFORMAT="%m-%dT%H:%M "

# safe shell options
# see bash man page for details
set -o posix
set -o noglob
set -o nounset
set -o noclobber

e () {
    emacsclient --alternate-editor='' --create-frame  "${@}"
}

gitpushall () {
    find ~ -maxdepth 2 -name '.git' -type d -print0 | xargs --verbose -0I{} git -C {}/.. push
}

gitpullall () {
    find ~ -maxdepth 2 -name '.git' -type d -print0 | xargs --verbose -0I{} git -C {}/.. pull
}

gitstatusall () {
    find ~ -maxdepth 2 -name '.git' -type d -print0 | xargs --verbose -0I{} git -C {}/.. status
}

export LEDGER_FILE=$HOME/Documents/hledger/yc.hledger

# w3m needs history file to exist to save browsing history
if ! [ -e $HOME/.w3m/history ]; then touch $HOME/.w3m/history; fi
