# .bashrc
# shellcheck disable=SC2148
# -----------------------------------------------

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [[ $- == *i* ]]
then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\e[C": forward-char'
    bind '"\e[D": backward-char'
fi

bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'
bind 'set menu-complete-display-prefix on'
bind 'set show-all-if-ambiguous on'

# colors in man
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize
# prevent execution of wrong command from history
shopt -s histverify
# add date and colors to history log
HISTTIMEFORMAT=$(echo -e "\033[0;35m%d/%m \033[0;32m%T \033[0m ")
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth:erasedups
# ignore this commands in history
HISTIGNORE="ls:[bf]g:exit:pwd:clear:history*:h:hl:hedit:hdel*"
# sync history between sessions
#PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

HISTSIZE=10000
HISTFILESIZE=20000

# prompt set
parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'; }
parse_python_venv() { if test -n "${VIRTUAL_ENV}" ; then echo "($(basename "${VIRTUAL_ENV}")) "; fi; }
# shellcheck disable=SC2034
VIRTUAL_ENV_DISABLE_PROMPT=1

# root check
if [[ "$(id -u)" = "0" || $(sfc 2>&1 | tr -d '\0') =~ SCANNOW ]]; then
    # red color for root
    PSCOLOR='\[\e[31m\]'
    PSCHAR='#'
else
    # green color for regular user
    PSCOLOR='\[\e[m\]'
    PSCHAR='$'
fi
PS1="\n\[\e[1;32m\]\`parse_python_venv\`\[\e[m\]"
PS1+="\[\e[31m\][\h] ${PSCOLOR}\u\[\e[m\] \[\e[36m\]\$PWD\[\e[m\]"
PS1+="\[\e[35m\]\`parse_git_branch\`\[\e[m\]\n"
PS1+="${PSCOLOR}${PSCHAR}>\[\e[m\] "
unset PSCOLOR PSCHAR

# MY CONF

export EDITOR="nano"

alias profed='$EDITOR ~/.bashrc'
alias profre='reset && exec "$SHELL"'
alias cls='clear'
alias ex='exit'
alias ..='cd ..'
alias ...='cd ../..'
alias h='history 20'
alias hl='history | less -R +G'
alias hg='history | grep --color=auto'
alias hedit='$(cd $HOME && $VISUAL -g .bash_history:99999)'
alias cdt='cd /tmp'
alias cdw='cd $HOME/work'
alias cdd='cd $HOME/Downloads'
alias cdlast='cd $(ls -t1d */ | head -n1)'
alias rm='rm -v -I --preserve-root'
alias mv='mv -v'
alias cp='cp -v'
alias cpr='cp -R'
alias rmr='command rm -vR'
alias rmrf='command rm -vR -f'
alias mkdir='mkdir -pv'
alias ls='ls --color=auto --group-directories-first'
alias sl='ls'
alias la='ls -A'
alias ll='ls -lhF'
alias lla='ls -lhA'
alias ls.='ls -ld .??*'
alias ls1='ls -1'
alias lm='ls -m'
alias lsh='ls | head'
alias lst='ls | tail'
alias lsg='ls | grep '
alias llg='ls -l | grep '
alias lf='ls -p | grep --color -v /'
alias lfl='ls -pl | grep --color -v /'
alias lfa='ls -pA | grep --color -v /'
alias lfal='ls -pAl | grep --color -v /'
alias lf8='ls -l | grep "^-" | cut -d" " -f9- | xargs -d "\n" stat -c "%a  %n" '
alias ld='ls -d */ 2>/dev/null '
alias ld1='ls -d1 */ 2>/dev/null '
alias lda='ls -d .*/ 2>/dev/null '
alias lad='ls -d .*/ 2>/dev/null '
alias ldl='\ls --color=always -r -p | grep --color=always -v / && ls -1rd */ '
alias lt='\ls -lht | head'
alias lta='\ls -Alht | head'
alias wlt="watch -c '\ls -lht | head'"
alias wlr="watch --color 'ls -shS1'"
alias wls="watch --color 'ls'"
alias wll="watch --color 'ls -l'"
alias wla="watch --color 'ls -A'"
alias wlrt="watch --color 'ls -shS1t'"
alias wcat='watch cat '
alias mount='mount |column -t'
alias grep='grep -i --color=auto'
alias diff='diff --color --suppress-common-lines'
alias du='du -h'
alias df='df -h'
alias policz='ls -1 | wc -l'

# proc
alias procszuk='ps -ef | grep -v grep | grep -i --color=always'
alias wprocszuk='watch -c -n1 "ps -ef | grep -v grep | grep -i --color=auto " '

# python
alias vc='[ ! -d ./venv ] && python -m venv ./venv || echo "venv already exist!"'
alias va='source ./venv/Scripts/activate 2>/dev/null || source ./venv/bin/activate'
alias vd='deactivate'
alias www='python -m http.server 8000'

# apt
alias aptu='sudo apt update'
alias aptl='sudo apt list --upgradable'
alias apti='sudo apt install'
alias apts='apt-cache search --names-only'
alias aptp='sudo apt purge'
alias aptdu='sudo apt dist-upgrade'
alias aptar='sudo apt autoremove'

# nala
if [ "$(command -v nala)" ]; then
alias aptu='sudo nala update'
alias aptl='sudo nala list --upgradable'
alias apts='nala search --names'
alias aptsh='nala show'
alias apti='sudo nala install'
alias aptp='sudo nala purge'
alias aptdu='sudo nala upgrade'
alias aptar='sudo nala autoremove'
fi

# Auto-launching ssh-agent on Git-Bash start
SSH_KEYS=( "$HOME/.ssh/github-dc" "$HOME/.ssh/github-xe")

SSH_ENV="$HOME/.ssh/environment"
function run_ssh_env {
    . "${SSH_ENV}" > /dev/null
}
function start_ssh_agent {
    echo "Initializing new SSH agent..."
    ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo "succeeded"
    chmod 600 "${SSH_ENV}"

    run_ssh_env;

    for SSH_KEY in "${SSH_KEYS[@]}"; do
    	ssh-add $SSH_KEY;
    done
}
if [ -f "${SSH_ENV}" ]; then
    run_ssh_env;
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_ssh_agent;
    }
else
    start_ssh_agent;
fi

# Docker
if [ "$(command -v docker)" ]; then
    alias d='docker'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker image'
    alias dis='docker image ls'
    alias dv='docker volume'
    alias dvs='docker volume ls'
fi

# GIT
if [ "$(command -v git)" ]; then
    # shellcheck disable=SC1090
    if [ -f ~/.git-completion.bash ]; then source ~/.git-completion.bash; else echo "Downloading git-completion"; curl -s "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" -o ~/.git-completion.bash; fi
    _git_branch_completion() { COMPREPLY=($(compgen -W "$(git branch -a --format "%(HEAD) %(refname:short)" | grep -v '*')" -- "${COMP_WORDS[COMP_CWORD]}")); }
    complete -F _git_branch_completion gb gbc gbm gbd grb gm gb-del-origin
    complete -o default -F _git_branch_completion gd gdf gdt gco

    # Git aliases
    # function gproxy-status { if [ -n "$(git config --global --get http.proxy)" ]; then echo "Proxy configured"; echo -e "\nhttp.proxy:  "$(git config --global --get http.proxy); echo -e "https.proxy: "$(git config --global --get https.proxy); else echo "Proxy NOT configured"; echo -e "\nhttp.proxy:  "$(git config --global --get http.proxy); echo "https.proxy: "$(git config --global --get https.proxy); fi; }
    # function gproxy        { PRADDR="$http_proxy"; if [ -n "$(git config --global --get http.proxy)" ]; then echo "Removed the proxy for Git"; git config --global --unset http.proxy; git config --global --unset https.proxy; else echo "Added a proxy for Git"; git config --global http.proxy $PRADDR; git config --global https.proxy $PRADDR; fi; }
    
    function gitconf    { $VISUAL -r "$HOME/.gitconfig"; }
    function gitaliases { awk '/^[[:blank:]]*# Git aliases/,/^[[:blank:]]*# Git aliases END/' ~/.bashrc | grep -v '^\# Git aliases' | awk -F'[ =]' '{out=""; for(i=3;i<=NF;i++){out=out" "$i}; print "\033[32m"$2"\033[0m" out}'; }
    function gitsize    { git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort --numeric-sort --key=2 | cut -c 1-12,41- | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest | tail -n20; }
    function gtest      { [ -n "${1}" ] && TESTCOMMITNO="${1}" || TESTCOMMITNO=${TESTCOMMITNO:-1}; git add . && git commit -m "test${TESTCOMMITNO}" && git push && (( TESTCOMMITNO++ )); }

    function gs         { git status; }
    function gss        { git status  --porcelain; }
    function ga         { git add "$@"; }
    function gaa        { git add .; }
    function gau        { git add -u "$@"; }
    function gb         { git branch "$@"; }
    function gba        { git branch -a "$@"; }
    function gbc        { git checkout -b "$@"; }
    function gbd        { git branch -D "$@"; }
    function gbm        { git branch -m "$@"; }
    function gbpush     { git push -v --set-upstream origin $(git rev-parse --abbrev-ref HEAD); }
    function gb-del-origin { git push origin --delete "$@"; }
    # function gb-show-gone       { git branch -vv | Where-Object {$_ -match '\[origin/.*: gone\]'} }
    # function gb-del-gone   { git branch -vv | Where-Object {$_ -match '\[origin/.*: gone\]'} | ForEach-Object {git branch -D ($_.split(" ", [StringSplitOptions]'RemoveEmptyEntries')[0])} }
    function gb-del-merged { git branch --merged | grep -Ev "(^\*|master|main|develop|dev)" | xargs git branch -d; }
    function gc         { git commit "$@"; }
    function gca        { git commit --amend "$@"; }
    function gcm        { git commit -m "$@"; }
    function gco        { git checkout "$@"; }
    function gcom       { git checkout main || git checkout master; }
    function gcp        { git cherry-pick "$@"; }
    function gcl        { git clean -fd "$@"; }
    function glf        { echo; git log --format="tformat:%C(auto)%h%d %<|($((COLUMNS-27)),trunc)%s %C(cyan)%<(12,trunc)%cr %C(dim green)%<(12,trunc)%aN" "$@"; }
    function glfa       { glf --graph --all; }
    function gl         { glf -n 10; }
    function gll        { echo; git log -n 1; }
    function gd         { git diff --name-status "$@"; }
    function gdl        { git diff HEAD~1 HEAD "$@"; }
    function gdc        { git diff --name-status --cached "$@"; }
    function gdf        { git diff "$@"; }
    function gdfc       { git diff --cached "$@"; }
    function gdfl       { git diff HEAD~1 HEAD "$@"; }
    function gdfo       { git diff main origin/main; }
    function gdo        { git diff --name-status main origin/main; }
    function gdt        { git difftool "$@"; }
    function gdtl       { git difftool HEAD~1 HEAD; }
    function gdtc       { git difftool --cached "$@"; }
    function gdto       { git difftool main origin/main; }
    function grem       { git remote -v "$@"; }
    function gt         { git tag "$@"; }
    function gtl        { git tag -l "$@"; }
    function gst        { git stash "$@"; }
    function gstp       { git stash pop "$@"; }
    function gstl       { git stash list "$@"; }
    function gstb       { git stash branch "$@"; }
    function gshow      { git show "$@"; }
    function grb        { git rebase "$@"; }
    function grbi       { git rebase --interactive "$@"; }
    function grbc       { git rebase --continue "$@"; }
    function grba       { git rebase --abort "$@"; }
    function gm         { git merge "$@"; }
    function gr         { git reset "$@"; }
    function gf         { git fetch -v "$@"; }
    function gpull      { git pull -v "$@"; }
    function gpush      { git push -v "$@"; }
    function gpushb     { gbpush; }
    # Git aliases END
fi

# FUNC

lr() {
    # list file by size
    if [[ $# -eq 0 ]]; then
        du -hs . 2>/dev/null
    else
        du -hs "$@"
    fi
}

lrl() {
    # list files by size - long format
    if [[ $# -eq 0 ]]; then
        du -ha -d1 . 2>/dev/null | sort -h
    else
        du -ha "$@" | sort -h
    fi
}

mkd() {
    # create dir and move into it
    test -d "$1" || mkdir "$1" && cd "$1" || return
}

cdm() {
    # create temp dir and move into it
    cd "$(mktemp -d)" || return
}

bak() {
    # create backup of given file/dir
    local NAME
    NAME=$1
    if [ ! -e "${NAME%/}".bak ]; then
        cp -avr "${NAME%/}"{,.bak};
    else
        echo "File/dir \"${NAME}.bak\" EXIST!"
    fi
}
complete -A file bak

polskiezn() {
    # remove polish diacritics, multiple dots and [ ,()]
    sed_func() { sed 'y/ćńóśźżąęłĆŃÓŚŹŻĄĘŁ/cnoszzaelCNOSZZAEL/' | sed 's/[ ,()]/./g' | sed 's/\.\.*/./g' | sed 's/\.-\./-/g'; }
    ren_func() { mv -v "${file}" "$(echo "${file}" | sed_func)"; }
    
    if ! [ -t 0 ]; then
        read -r
        echo; echo "$REPLY" | sed_func
        return 0
    elif [ "$#" -eq 0 ]; then
        echo -e "Argument needed! Exiting.\n"
        echo -e "Remove polish diacritics, multiple dots and [ ,()] from file/dir names\n\nSYNTAX\n\t${FUNCNAME[0]} <filename> [<filename>] [...]\n\nOPTIONS\n\t-n\t\t- performs dry-run\n" 
        return 22
    fi

    if [ "$1" == "-n" ]; then
        echo -e "Dry-run! NO changes will be performed\n"
        shift 1
        # shellcheck disable=SC2005
        ren_func() { echo "${file}" | sed_func; }
    fi

    local files=("${@}")
    for file in "${files[@]}"; do
        if [ -f "${file}" ] || [ -d "${file}" ]; then
            ren_func
        else
            echo "\"${file}\" does not EXIST!"
        fi
    done
}
