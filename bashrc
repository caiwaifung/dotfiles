[[ ${TERM} == "xterm-256color" ]] || return 1

export PATH="/usr/local/opt/llvm/bin:$PATH"

export CLICOLOR=1
export PS1="\[$(tput bold)\]\[\033[38;5;242m\]\t\[$(tput sgr0)\]\[\033[38;5;6m\]:\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;214m\]\w\[\033[38;5;9m\] > \[$(tput sgr0)\]"
function printcolors {
    for i in `seq 1 256`; do
        printf "\033[38;5;${i}m$i ";
    done
    echo
    printf "$(tput bold)"
    for i in `seq 1 256`; do
        printf "\033[38;5;${i}m$i ";
    done
    echo
}

alias o="open"
alias l="ls"
alias ll="ls -l"
alias la="ls -la"
alias c="cd"
alias v="vim"
alias vi="vim"
alias t="tree"
alias g="git"
alias ga="git add"
alias gs="git status"
alias gcm="git commit -m"
alias gp="git push"
alias gd="git diff"
alias gpull="git pull"
set -o vi

function go() { [ -e $1.cc ] || cat ~/algo/template/base/{header.h,main-empty.h} >$1.cc; vim $1.cc; }
function goc() { [ -e $1.cc ] || cat ~/algo/template/base/{header.h,main-cases.h} >$1.cc; vim $1.cc; }
#function goc { cat ~/algo/template/base/{header.h,main-cases.h} $1.cc }

function hlrun {
    if [[ $# != 2 && $# != 3 ]]; then
        echo 'usage: hlrun [pattern] [command] [[color]]'
    else
        local c=31
        if [[ $# == 3 ]]; then
            c=$3
        fi
        script -q /dev/null ${2} | sed ''s/$1/`printf "\e[${c}m$1\e[0m"`/g''
    fi
}
