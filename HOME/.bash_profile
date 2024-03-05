parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

f() {
    find -name "*$1*" 
}

compare(){
    COMPARE_FOLDERS=DIFF code $1 $2 
}

n() {
    "$@" && notify-send "Command Completed: $*"
}

export PS1="\[\033[32m\]\w:\$(parse_git_branch)\[\033[00m\]\n$ "
