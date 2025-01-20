# Use seperate line for new terminal sessions. 
PS1="$PS1\n! "

# https://support.apple.com/en-us/102360
# In Terminal, enter $ chsh -s path, where path is one of the shell paths listed in /etc/shells, such as /bin/zsh, /bin/bash, /bin/csh, /bin/dash, /bin/ksh, /bin/sh, or /bin/tcsh.
export BASH_SILENCE_DEPRECATION_WARNING=1

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Get the aliases and functions
if [ -f ~/.bash_secrets ]; then
	. ~/.bash_secrets
fi

# Get the aliases and functions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
