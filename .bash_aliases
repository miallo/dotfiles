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

alias upo='nmcli connection up bevuta'
alias downo='nmcli connection down bevuta'
alias up='nmcli connection up michael_new'
alias down='nmcli connection down michael_new'

alias python=python3

# alias sshcip='ssh -Y  m.lohmann@login.cip.physik.uni-goettingen.de'
alias finalcutextend='rm ~/Library/Application\ Support/.ffuserdata'
which nvim > /dev/null && alias vim='nvim'
alias cim='vim'
alias cds='cd ~/src/Salus/citizen-app/'
alias cdg='cd ~/src/Salus/google-workspace-migration-script'
alias cdp='cd ~/src/Salus/psap-app/'
alias cdl='cd ~/src/Salus/sms-location-app'
alias cdo='cd ~/src/Salus/ops'
alias cdw='cd ~/src/website'
alias cdm='cd ~/src/semantic_search/frontend'


# git
alias g='git'
alias ga='git add'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias grhu='git reset --hard @{u}'
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

tigb() {
    tig "$(git merge-base origin/main "$1")".."$1"
}


nix-git-sha() {
    nix-prefetch-url --unpack https://github.com/"$1"/archive/"${2=master}".tar.gz
}

nsp() {
    nix-shell -p "$1" --run "$1"
}

alias nix-update-mac="sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'"

# Android emulator
alias tbe='adb shell settings put secure enabled_accessibility_services com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService'
alias tbd='adb shell settings put secure enabled_accessibility_services com.android.talkback/com.google.android.marvin.talkback.TalkBackService'

rebuild() {
    beforeRebuildGeneration="$(nixos-rebuild list-generations --json | jq 'map(select(.current))[0].generation')"
    sudo nixos-rebuild switch --update-input nixpkgs --update-input nixos-hardware --commit-lock-file
    nix store diff-closures /run/current-system "/nix/var/nix/profiles/system-$beforeRebuildGeneration-link"
}

git-trust() {
    if [ "$1" = "-e" ]; then
        sort < "$ZSH_THEME_GIT_PROMPT_TRUSTED_WORKSPACE" > "$ZSH_THEME_GIT_PROMPT_TRUSTED_WORKSPACE.bak"
        mv "$ZSH_THEME_GIT_PROMPT_TRUSTED_WORKSPACE.bak" "$ZSH_THEME_GIT_PROMPT_TRUSTED_WORKSPACE"
        "$EDITOR" "$ZSH_THEME_GIT_PROMPT_TRUSTED_WORKSPACE"
        return
    fi
    git rev-parse --show-toplevel >> "$ZSH_THEME_GIT_PROMPT_TRUSTED_WORKSPACE"
}
git-deny() {
    if [ "$1" = "-e" ]; then
        sort < "$ZSH_THEME_GIT_PROMPT_IGNORED_WORKSPACE" > "$ZSH_THEME_GIT_PROMPT_IGNORED_WORKSPACE.bak"
        mv "$ZSH_THEME_GIT_PROMPT_IGNORED_WORKSPACE.bak" "$ZSH_THEME_GIT_PROMPT_IGNORED_WORKSPACE"
        "$EDITOR" "$ZSH_THEME_GIT_PROMPT_IGNORED_WORKSPACE"
        return
    fi
    git rev-parse --show-toplevel >> "$ZSH_THEME_GIT_PROMPT_IGNORED_WORKSPACE"
}
