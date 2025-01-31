# when HISTTIMEFORMAT is set;
# save timestamp (unix epoch) in history file;
# and display history in this format when $(history) is invoked
export HISTTIMEFORMAT="%m-%dT%H:%M "
# longer shell history than default (500)
export HISTFILESIZE=10000
export HISTSIZE=10000
# safe shell options
# see bash man page for details
set -o posix
set -o noglob
set -o nounset
set -o noclobber

e () {
    emacsclient --alternate-editor='' --create-frame  "${@}"
}

gitpullall () {
    git -C ~ pull
    git -C ~/user-docs pull
}

gitstatusall () {
    git -C ~ status
    git -C ~/user-docs status
}

gitpushall () {
    git -C ~ push
    git -C ~/user-docs push
}
