HISTCONTROL=ignoreboth
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export PATH="$PATH:/Users/michael/Library/Python/3.7/bin"

alias cdD='cd ~/Documents/Uni/Master/Thesis/DeepLearning'
alias cdO='cd ~/tempODL/src/odl/odl'
alias sshcip='ssh -Y m.lohmann@login.cip.physik.uni-goettingen.de'
alias anzeigen='defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder'
alias ausblenden='defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder'
alias lstex='ls *.tex'
alias vimm='vim Master.tex'
alias vimM='vim Master.tex'
alias pull='git pull'
alias push='git push'
alias matlab='/Applications/MATLAB_R2017a.app/bin/matlab'
alias sshpigeist='ssh pi@10.10.182.103'
alias sshpiethernet='ssh pi@192.168.2.2'
alias sshpiheist='ssh pi@192.168.1.5'
alias vimtorstate='vim /Users/Michael/Library/Application Support/TorBrowser-Data/Tor/state'
alias updateodl='source activate odlenv && pip install git+git://github.com/odlgroup/odl@master && source deactivate'

# Schedule sleep in X minutes, use like: sleep-in 60
function sleep-in-minutes() {
  local seconds=$(($1*60))
  sleep ${seconds}; osascript -e 'tell application "System Events" to sleep'
}
