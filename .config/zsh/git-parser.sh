#!/usr/bin/env zsh

# All zsh version of https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-prompt @ 47c04d9
autoload -U colors && colors

workingtree_path="$(git rev-parse --show-toplevel 2>/dev/null)"
if ! [ $? -eq 0 ]; then
    # not a git repo
    exit
fi
: "${ZSH_THEME_GIT_PROMPT_IGNORED_WORKSPACE:="${XDG_CONFIG_HOME-"$HOME/.config"}/zsh/git-ignored-workspaces"}"
# mkdir -p "$(dirname "$ZSH_THEME_GIT_PROMPT_IGNORED_WORKSPACE")"
grep -q "^$workingtree_path\$" "$ZSH_THEME_GIT_PROMPT_IGNORED_WORKSPACE" 2>/dev/null && exit
: "${ZSH_THEME_GIT_PROMPT_TRUSTED_WORKSPACE:="${XDG_CONFIG_HOME-"$HOME/.config"}/zsh/git-trusted-workspaces"}"
# mkdir -p "$(dirname "$ZSH_THEME_GIT_PROMPT_TRUSTED_WORKSPACE")"
if ! grep -q "^$workingtree_path\$" "$ZSH_THEME_GIT_PROMPT_TRUSTED_WORKSPACE" 2>/dev/null; then
    echo -n "%{$fg_bold[red]%}untrusted repo!%{${reset_color}%} %{$fg_bold[green]%}git-deny%{${reset_color}%} or %{$fg[red]%}git-trust%{${reset_color}%}"
    exit
fi

: "${ZSH_THEME_GIT_PROMPT_PREFIX:="("}"
: "${ZSH_THEME_GIT_PROMPT_SUFFIX:=")"}"
: "${ZSH_THEME_GIT_PROMPT_SEPARATOR:="|"}"
: "${ZSH_THEME_GIT_PROMPT_BRANCH:="%{$fg_bold[magenta]%}"}"
: "${ZSH_THEME_GIT_PROMPT_STAGED:="%{$fg[green]%}%{●%G%}"}"
: "${ZSH_THEME_GIT_PROMPT_CONFLICTS:="%{$fg[red]%}%{✖%G%}"}"
: "${ZSH_THEME_GIT_PROMPT_RENAMED_OR_MOVED:="%{$fg[cyan]%}%{·%G%}"}"
: "${ZSH_THEME_GIT_PROMPT_DELETED:="%{$fg[red]%}%{-%G%}"}"
: "${ZSH_THEME_GIT_PROMPT_CHANGED:="%{$fg[blue]%}%{✚%G%}"}"
: "${ZSH_THEME_GIT_PROMPT_ADDED:="%{$fg[yellow]%}%{+%G%}"}"
: "${ZSH_THEME_GIT_PROMPT_BEHIND:="%{↓%G%}"}"
: "${ZSH_THEME_GIT_PROMPT_AHEAD:="%{↑%G%}"}"
: "${ZSH_THEME_GIT_PROMPT_UNTRACKED:="%{…%G%}"}"
: "${ZSH_THEME_GIT_PROMPT_CLEAN:="%{$fg_bold[green]%}%{✔%G%}"}"
: "${ZSH_THEME_GIT_PROMPT_STASHES="%{$fg_bold[blue]%}%{⚑%G%}"}"

get_tagname_or_hash() {
    # get tagname
    tags=($(git for-each-ref --points-at=HEAD --count=2 --sort=-version:refname --format='%(refname:short)' refs/tags))

    if [ ${#tags[@]} -gt 0 ]; then
        if [ ${#tags[@]} -gt 1 ]; then
            echo "${tags:0} 🏷️ +"
        else
            echo "${tags:0} 🏷️ "
        fi
    else
        # get hash
        hash_=$(git rev-parse --short HEAD 2> /dev/null)
        hash_="${hash_# +}" # trim
        echo "${hash_% +}"
    fi
}

parse_git() {
    GIT_ADDED=0
    GIT_AHEAD=0
    GIT_BEHIND=0
    GIT_MODIFIED=0
    GIT_CONFLICTS=0
    GIT_DELETED=0
    GIT_RENAMED_OR_COPIED=0
    GIT_STAGED=0
    GIT_UNTRACKED=0
    for line (${(f)git_status}); do
        case "$line" in
            "##"*)
                st0="${line:0:1}"
                st1="${line:1:1}"
                st2="${line:2}"
                branchrest=("${(s/.../)st2}")
                case $st2 in
                    ' No commits yet on'*)
                        GIT_BRANCH="${st2##* }"
                        ;;
                    ' HEAD (no branch)'):  # detached status
                        GIT_BRANCH="$(get_tagname_or_hash)"
                        ;;
                    *)
                        if [ ${#branchrest[@]} -eq 1 ]; then
                            GIT_BRANCH="${st2# }"
                        else
                            # current and remote branch info
                            # branch, rest = st[2].strip().split('...')
                            GIT_BRANCH="${branchrest[1]# }"
                            rest="${branchrest[2]}"
                            restsplit=("${(s/ /)rest}")
                            if [ ${#restsplit} -eq 1 ]; then
                                # remote_branch = rest.split(' ')[0]
                            else
                                # ahead or behind
                                divergence="${restsplit[@]:1}"
                                divergence="${divergence#*\[}"
                                divergence="${divergence%\]*}"
                                for div in ${(s/, /)divergence} ; do
                                    case $div in
                                        *ahead*)
                                            GIT_AHEAD="${${(s/ /)div}[2]}"
                                            ;;
                                        *behind*)
                                            GIT_BEHIND="${${(s/ /)div}[2]}"
                                            ;;
                                        *)  ;;
                                    esac
                                done
                            fi
                        fi
                        ;;
                esac
                ;;
            "??"*)
                ((GIT_UNTRACKED++))
                ;;
            ?"M"*)
                ((GIT_MODIFIED++))
                ;|
            ?"D"*)
                ((GIT_DELETED++))
                ;;
            "U"?*)
                ((GIT_CONFLICTS++))
                ;;
            ?"R"*|"R"?*|?"C"*|"C"?*)
                ((GIT_RENAMED_OR_COPIED++))
                ;;
            "A"?*)
                ((GIT_ADDED++))
                ;;
            [MD]*)
                ((GIT_STAGED++))
                ;;
        esac
        GIT_STASHES="$(git rev-list --walk-reflogs --count refs/stash -- 2> /dev/null)"
    done
}


git_super_status() {
    parse_git
    STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"
    if [ "$GIT_BEHIND" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND$GIT_BEHIND%{${reset_color}%}"
    fi
    if [ "$GIT_AHEAD" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD$GIT_AHEAD%{${reset_color}%}"
    fi
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"
    if [ "$GIT_STAGED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
    fi
    if [ "$GIT_CONFLICTS" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
    fi
    if [ "$GIT_RENAMED_OR_COPIED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_RENAMED_OR_MOVED$GIT_RENAMED_OR_COPIED%{${reset_color}%}"
    fi
    if [ "$GIT_DELETED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_DELETED$GIT_DELETED%{${reset_color}%}"
    fi
    if [ "$GIT_MODIFIED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_MODIFIED%{${reset_color}%}"
    fi
    if [ "$GIT_ADDED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_ADDED$GIT_ADDED%{${reset_color}%}"
    fi
    if [ "$GIT_UNTRACKED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED$GIT_UNTRACKED%{${reset_color}%}"
    fi
    if [ "$GIT_STASHES" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STASHES$GIT_STASHES%{${reset_color}%}"
    fi
    if [ "$GIT_ADDED" -eq "0" ] && [ "$GIT_MODIFIED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_DELETED" -eq "0" ] && [ "$GIT_RENAMED_OR_COPIED" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
    STATUS="$STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    echo "$STATUS"
}

git_status="$(git status --porcelain --branch 2> /dev/null)"

if [ $? -eq 0 ]; then
    # is git repo
    git_super_status
fi

