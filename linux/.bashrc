# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#proxy setup
export http_proxy="http://10.158.100.2:8080/"
export https_proxy="http://10.158.100.2:8080/"
export ftp_proxy="http://10.158.100.2:8080/"
export no_proxy=no_proxy=localhost,siemens.com,nsn.com,nsn-intra.net,nsn-net.net,nokia.com,alcatel-lucent.com,alcatel.com,lucent.com,127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16

export GOPATH=/home/prem/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export GOPROXY=https://repo.lab.pl.alcatel-lucent.com/gocenter-remote
export GOPRIVATE=gerrit.ext.net.nokia.com
export GOPRIVATE="gerrit.ext.net.nokia.com/AANM/go.git"
export GO111MODULE=on

export PATH=$PATH:$GOBIN
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:/opt/pact/bin:/opt/sublime_text
export PATH=$PATH:/usr/local/lib/nodejs/node-v12.18.3-linux-x64/bin
export PATH=$PATH:/opt/idea-IC-221.5080.210/bin

export JAVA8_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA8_PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin
export JAVA11_PATH=/usr/lib/jvm/java-11-openjdk-amd64/bin

export JAVA11_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export JAVA_HOME=$JAVA11_HOME

# custom functions

alias top='top -d 5'

# go related
#alias goimports='/home/prem/go/src/gerrit.ext.net.nokia.com/AANM/go/tools/golang.org/x/tools/cmd/goimports@v0.0.0-20200624060801-dcbf2a9ed15d'
alias modgotest='go test -v -count=1 -race -mod=vendor'
alias cdmonorepo='cd /home/prem/go/src/gerrit.ext.net.nokia.com/AANM/go/'
export LABINV='/home/prem/go/src/gerrit.ext.net.nokia.com/AANM/environment/inventory/'
# for coverage in mono repo
alias start_cover='export JOB_BASE_NAME="test"'
alias merge_cover='echo "mode: atomic" > /var/tmp/test.out; cat target/pkg/awss3/test/*coverage.txt | grep -P -v  "^mode:" >> /var/tmp/test.out'
alias find_cover='go tool cover -html=/var/tmp/test.out -o /media/winc/cover.html'


# git related
alias gitnoedit='git commit --amend --no-edit'
alias gitnoeditreview='git commit --amend --no-edit && git review'
alias gitstatlog='git log --stat --summary'
alias gitnorebasereview='git review --no-rebase'

alias java8='export PATH="$JAVA8_PATH:$PATH"; export JAVA_HOME=$JAVA8_HOME'
alias java11='export PATH="$JAVA11_PATH:$PATH"; export JAVA_HOME=$JAVA11_HOME'

# openapi
alias openapiui='docker run -p 8080:8080 -e SWAGGER_JSON=/openapi.yaml -v /tmp/openapi.yaml:/openapi.yaml swaggerapi/swagger-ui'

# simple PS1
PS1='\u@\W \$ '

complete -C /usr/local/bin/minio-mc mc

alias cdgoprac='cd /home/prem/go/src/github.com/prembhaskal/go_practice/'

alias ocm='oc -nnom-apps'
alias ocn='oc -nopenshift-storage'
alias ocb='oc -nnom-backend'
#export KUBECONFIG="~/.kubeconfig"

alias helmm='helm -nnom-apps'

function unsetproxies {
  unset http_proxy
  unset https_proxy
}

function formatnewline {
  sed -e 's/\\n/\n/g' -e 's/\\t/\t/g' 
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
