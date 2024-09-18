parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Find file
f() {
    find -name "*$1*"
}

# Grep history
gh() {
    history | grep "$1"
}


# This requires the following VSCode extension: moshfeu.compare-folders
compare-folder(){
    COMPARE_FOLDERS=DIFF code $1 $2
}

compare-file(){
    code --diff $1 $2
}

n() {
    "$@" && notify-send "Command Completed: $*"
}

export PS1="\[\033[32m\]\w:\$(parse_git_branch)\[\033[00m\]\n$ "
