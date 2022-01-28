alias ll='ls -lFGh'
alias lla='ls -lFGhA'
alias la='ls -AFG'
alias ls='ls -FG --color'
alias sl='ls'
alias anzeigen='defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder'
alias ausblenden='defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder'

alias up='nmcli connection up bevuta-vpn'
alias down='nmcli connection down bevuta-vpn'

alias python=python3

# alias sshcip='ssh -Y  m.lohmann@login.cip.physik.uni-goettingen.de'
alias finalcutextend='rm ~/Library/Application\ Support/.ffuserdata'
alias sshcip='ssh -X -J m.lohmann@login.cip.physik.uni-goettingen.de c079'
alias sshpiethernet='ssh pi@192.168.2.2'
alias sshpigeist='ssh pi@10.10.182.103'
alias sshpiheist='ssh pi@192.168.1.5'
which nvim > /dev/null && alias vim='nvim'
alias cds='cd ~/src/Salus/citizen-app/ && ANDROID_HOME="$HOME/Android/Sdk" nix-shell --run zsh'


# git
alias g='git'
alias ga='git add'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcps='git cherry-pick --skip'
alias gd='git diff'
alias gds='git diff --staged'
alias gdu='git diff @{u}'
alias gf='git fetch'
alias glg='git log --stat'
alias gpsup='git push --set-upstream origin HEAD'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
grd() {
    leftrev="${1=HEAD}"
    rightrev="${2=@{u\}}"
    git range-diff $(git merge-base "$leftrev" "$rightrev") "$leftrev" "$rightrev"
}
alias grhh='git reset --hard'
alias grhs='git reset'
alias grm='git rm'
alias grs='git restore'
alias grss='git restore --staged'
alias gst='git status'
alias gsta='git stash'
alias gstp='git stash pop'
alias gsw='git switch'
alias gswc='git switch -c'



nix-git-sha() {
    nix-prefetch-url --unpack https://github.com/"$1"/archive/"${2=master}".tar.gz
}

nsp() {
    nix-shell -p "$1" --run "$1"
}
