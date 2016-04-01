######################################################################
# .bash_profile 
# Bradley McDuffie
# (c)2013
######################################################################
# Setup an editor, if you don't do this, you might get some weirdness
# from some applications that look for it.
export EDITOR=`which vim`;

# 'FiX' less so it behaves more like the old more did, also, it makes
# it less annoying.
export LESS='FiX'

# Set our path to include bin in our homedir
export PATH=$HOME/bin:/usr/local/bin:$PATH:/usr/local/sbin

# Identify what type of system we're using.  If this is a Mac,
# it will setup some aliases one way, on linux, another.
SYSIDENT=`uname`

# I love colors with grep because it makes it easy to see what
# got matched.  This takes it one step closer to just being 
# crazy because it sets the grep color to a random value
# (ignoring black and green).
GREP_COLOR=3`perl -e "print int(rand(7))"`
if [ "$GREP_COLOR" -eq "32" ]
then
	GREP_COLOR=33
elif [ "$GREP_COLOR" -eq "30" ]
then
	GREP_COLOR=34
fi
export GREP_COLOR

# This sets up our shell options.  
# histappend: append all shells to our history file on exit
# histverify: lets us edit a command we've retrieved from the 
#             shell history before executing it.
shopt -s histappend histverify
export HISTCONTROL=ignoredups

# HISTSIZE: number of lines from the current interactive shell's
#           history that will be appended to the history file on 
#           exit.
# HISTFILESIZE: number of lines in the history file
HISTSIZE=2000
HISTFILESIZE=10000

# Sets up the primary prompts
PS1='\u@\[\e[1;${GREP_COLOR}m\]\h\[\e[0m\]:\W\$ '
PS2='> '

######################################################################
# Aliases - shortcut commands!
######################################################################
# Quick and easy way to source this file
alias S="source ~/.bash_profile"
# grep with colors!
alias grep="grep --color"
alias egrep="egrep --color"

# These give me feedback for the cp, mv, and rm commands
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -v'

# These are the basic options I always use with rsync
alias rsync='rsync -avHhP --progress --stats --partial'

# git shortcuts
alias gc='git commit'
alias gca='git commit -a'
alias gp='git pull'
alias gs='git status'

# Mac OS X specific checks
if [ "$SYSIDENT" == "Darwin" ]
then
    alias flush="sudo dscacheutil -flushcache"
    alias flushMavericks="sudo killall -HUP mDNSResponder"
    alias ls='ls -G'
    # I recompiled gnudate and put it in my bin dir on my mac.
    if [ -e ~/bin/date ]
    then
        alias date='~/bin/date'
    fi
else
    alias ls='ls --color'
fi

# This is the most insane part of my whole setup because it looks
# the craziest.  Just to make it simple, here is an example of what
# it looks like (sans color).  Commands that execute successfully,
# the prompt gets a check mark, for ones that fail, it gives an 
# x.  There is also a lot of coloring involved.  
# {user@breezy.local}{Sun Mar 10 09:11:36}{~}
# √ $
# {user@breezy.local}{Sun Mar 10 09:11:45}{~}
# ∙✘∙ $
if [ -f $HOME/.git_prompt ]
then
    source $HOME/.git_prompt
fi

PROMPT_COMMAND='PS1="\[\e[0;36m\]{\[\e[0;31m\]\u\[\e[0;35m\]@\[\e[${GREP_COLOR}m\]\h\[\e[0;36m\]}{\[\e[0;35m\]\d \t\[\e[0;36m\]}{\[\e[0;35m\\]\w\[\e[0;36m\]}\n\`if [[ \$? = "0" ]]; then echo "\\[\\033[34m\\]✔\\[\\033[0m\\]"; else echo -e "\\[\\033[31m\\]∙✘∙"; fi\` $(__git_ps1) \\$\[\e[0m\] " '

# Finally, just append commands to my history
PROMPT_COMMAND="$PROMPT_COMMAND ; history -a"

# ssh tab complete hostnames that you have known_hosts entries for.
if [ -r ~/.ssh/known_hosts ] || [ -r /etc/ssh/ssh_known_hosts ]
then
	complete -W "$(awk '{print $1}' ~/.ssh/known_hosts | awk -F, '{print $1}' | sort | uniq | grep -v "\[")" ssh 
fi

# Sets up ruby environment if you're using rvm
if [ -f $HOME/.rvm/scripts/rvm ]
then
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

# Sets up git prompt to tell me what my status is of my
# current git branch
if [ -f $HOME/.bash_gitprompt ]
then
    source $HOME/.bash_gitprompt
fi

# One final annoyance for chrome on the Mac
alias fix_chrome='defaults write com.google.Chrome DisablePrintPreview -boolean true'
alias fix_route='sudo route add -net 10.0.0.0/8 10.0.6.5'
alias new_main='echo "int main(int argc, char* argv[]) {\n}" > main.c'

if [ -f .bash_login ]
then
    source ~/.bash_login
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
