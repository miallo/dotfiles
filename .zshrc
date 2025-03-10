ZSH_DISABLE_COMPFIX=true
export ZSH_THEME_GIT_PROMPT_TRUSTED_WORKSPACE="$HOME/.config/zsh/git-trusted-workspaces"
export ZSH_THEME_GIT_PROMPT_IGNORED_WORKSPACE="$HOME/.config/zsh/git-ignored-workspaces"
source ~/.config/zsh/history.sh
source ~/.config/zsh/bindkeys.sh
source ~/.config/zsh/completion.sh
source ~/.bash_aliases
source ~/.config/zsh/zsh_aliases
source ~/.config/zsh/shrink_path.sh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='nvim'

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Use VIM-like movement commands
# bindkey -v

#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#AAAAAA"

# Path in prompt shortened
setopt prompt_subst
# allow '#' as comment character
setopt interactive_comments

#PS1='%n $(shrink_path -f) $(git_super_status)> '
PS1='$(shrink_path -f) $($HOME/.config/zsh/git-parser.sh)%(?..%F{red})%(!.#.>)%f '
unset RPS1 # shows path again, but is already included in PS1


function cdl () { cd $@; ls }
function cdla () { cd $@; la }

typeset -A __WINCENT

fpath=($HOME/.config/zsh $fpath)
source $HOME/.config/zsh/colors

zstyle ':completion:*:*:vim:*' file-patterns '^*(.(o|png|aux|log|pdf|bbl|blg|out|toc|run.xml|synctex.gz)|-blx.bib):source-files' '*:all-files'
zstyle ':completion:*:*:nvim:*' file-patterns '^*(.(o|png|aux|log|pdf|bbl|blg|out|toc|run.xml|synctex.gz)|-blx.bib):source-files' '*:all-files'

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Home Manager
if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi
# End Nix

command -v direnv >& /dev/null && eval "$(direnv hook zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || :
