HISTCONTROL=ignoreboth
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export PATH="$PATH:/Users/michael/Library/Python/3.7/bin"


# Schedule sleep in X minutes, use like: sleep-in 60
function sleep-in-minutes() {
  local seconds=$(($1*60))
  sleep ${seconds}; osascript -e 'tell application "System Events" to sleep'
}
