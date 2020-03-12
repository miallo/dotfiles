# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/Michael/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# globalias
plugins=(
  shrink-path zsh-autosuggestions git python zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source ~/.bash_aliases

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Use VIM-like movement commands
# bindkey -v


#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#AAAAAA"

# Git not on the right but on the left
#unset RPROMPT
export ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}("
export ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
export ZSH_THEME_GIT_PROMPT_DIRTY="*%{$reset_color%}"
export ZSH_THEME_GIT_PROMPT_CLEAN=""

parse_git_branch() {
  (command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
}

parse_git_dirty() {
  if command git diff-index --quiet HEAD 2> /dev/null; then
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  else
    local number_files=$(git status -s -uno | wc -l | sed 's/^ *//')
    echo "%{$fg[red]%}$number_files$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi
 }

git_custom_status() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX${git_where#(refs/heads/|tags/)}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}





# Path in prompt shortened
setopt prompt_subst

#PS1='%n $(shrink_path -f) $(git_super_status)> '
PS1='$(shrink_path -f) $(git_custom_status)> '

#export PATH="/Users/Michael/anaconda2/bin:$PATH"






# cd does not automatically push to pushd/popd/dirs stack
unsetopt autopushd
function cdl () { cd $@; ls }
function cdla () { cd $@; la }
export PATH="/usr/local/sbin:$PATH"



zstyle ':completion:*:*:vim:*' file-patterns '^*(.(png|aux|log|pdf|bbl|blg|out|toc|run.xml|synctex.gz)|-blx.bib):source-files' '*:all-files'
zstyle ':completion:*:*:nvim:*' file-patterns '^*(.(png|aux|log|pdf|bbl|blg|out|toc|run.xml|synctex.gz)|-blx.bib):source-files' '*:all-files'

export PATH="/usr/local/opt/python@3.8/bin:$PATH"
