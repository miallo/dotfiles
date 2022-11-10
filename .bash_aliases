autoload -U +X compinit && compinit

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
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
which nvim > /dev/null && alias vim='nvim'
alias cds='cd ~/src/Salus/citizen-app/'
alias cdp='cd ~/src/Salus/psap-app/'
alias cdl='cd ~/src/Salus/sms-location-app'


# git
alias g='git'
alias ga='git add'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcps='git cherry-pick --skip'

gd() {
    if [[ $# = 1 ]] && [[ $1 = *'...'* ]]; then # if only one parameter and that contains at least three dots
        git diff "${1%%.*}" "${1##*.}" # split up at the dots
    else
        git diff "$@" # just pass all parameters to diff
    fi
}
compdef '_dispatch _git-diff git' gd

alias gds='git diff --staged'
alias gdu='git diff @{u}'
alias gf='git fetch --no-recurse-submodules'
alias glg='git log --stat'
alias gpsup='git push --set-upstream origin HEAD'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'

grd() {
    leftrev="${1=@{u\}}" # default first argument to the upstream branch
    rightrev="${2=@}" # default second argument to HEAD
    git range-diff "$(git merge-base "$leftrev" "$rightrev")" "$leftrev" "$rightrev"
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


# Android emulator
alias tbe='adb shell settings put secure enabled_accessibility_services com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService'
alias tbd='adb shell settings put secure enabled_accessibility_services com.android.talkback/com.google.android.marvin.talkback.TalkBackService'
