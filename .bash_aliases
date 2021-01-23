alias ll='ls -lFGh'
alias lla='ls -lFGhA'
alias la='ls -AFG'
alias ls='ls -FG'
alias sl='ls'
alias anzeigen='defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder'
alias ausblenden='defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder'

alias up='nmcli connection up bevuta-vpn'
alias down='nmcli connection down bevuta-vpn'


# alias pixelextend='rm -rf ~/Library/Containers/com.pixelmatorteam.pixelmator.x.trial/'
# alias sshcip='ssh -Y  m.lohmann@login.cip.physik.uni-goettingen.de'
alias finalcutextend='rm ~/Library/Application\ Support/.ffuserdata'
alias pixelextend='rm -rf ~/Library/Group\ Containers/4R6749AYRE.com.pixelmator/'
alias sshcip='ssh -X -J m.lohmann@login.cip.physik.uni-goettingen.de c079'
alias sshpiethernet='ssh pi@192.168.2.2'
alias sshpigeist='ssh pi@10.10.182.103'
alias sshpiheist='ssh pi@192.168.1.5'
which nvim > /dev/null && alias vim='nvim'
alias cds='cd ~/Salus/citizen-app/ && ANDROID_HOME="$HOME/Android/Sdk" nix-shell --run zsh'

nix-git-sha() {
    nix-prefetch-url --unpack https://github.com/"$1"/archive/"${2=master}".tar.gz
}

nsp() {
    nix-shell -p "$1" --run "$1"
}
