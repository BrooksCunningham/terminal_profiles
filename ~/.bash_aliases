# Use seperate line for new terminal sessions. This should probably go in .bash_profile instead of aliases.
PS1="$PS1\n"

# Aliases

# Functions
function ipinfo {
  curl https://ipinfo.com/$1
}
