alias ll='/bin/ls -lFGh'
alias lla='/bin/ls -lFGha'
alias la='/bin/ls -aFG'
alias ls='/bin/ls -FG'
alias sl='ls'
alias anzeigen='defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder'
alias ausblenden='defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder'


alias vim='nvim'

alias vimp='vimn Prohaupt.tex'
alias cdd='cd ~/Uni/Master/Thesis/DeepLearning'
alias cdda='cd ~/Uni/Master/Thesis_Data'
alias cdm='cd ~/Uni/Master/Thesis/'
alias cdr='cd ~/Uni/Master/Thesis/reconstructions'
alias cdO='cd ~/tempODL/src/odl/odl'
alias lstex='ls *.tex'
alias vimm='nvim Master.tex'
alias vimM='nvim Master.tex'
alias pull='git pull'
alias push='git push'
alias matlab='/Applications/MATLAB_R2017a.app/bin/matlab'

alias sshpigeist='ssh pi@10.10.182.103'
alias sshpiethernet='ssh pi@192.168.2.2'
alias sshpiheist='ssh pi@192.168.1.5'
#alias sshcip='ssh -Y  m.lohmann@login.cip.physik.uni-goettingen.de'
alias sshcip='ssh -X -J m.lohmann@login.cip.physik.uni-goettingen.de c079'




alias finalcutextend='rm ~/Library/Application\ Support/.ffuserdata'
#alias pixelextend='rm -rf ~/Library/Containers/com.pixelmatorteam.pixelmator.x.trial/'
alias pixelextend='rm -rf ~/Library/Group\ Containers/4R6749AYRE.com.pixelmator/'
alias cim='vimn'

alias vimtorstate='vimn /Users/Michael/Library/Application Support/TorBrowser-Data/Tor/state'
alias updateodl='source activate odlenv && pip install git+git://github.com/odlgroup/odl@master && source deactivate'
