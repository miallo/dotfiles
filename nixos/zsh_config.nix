{ pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

    # Customize your oh-my-zsh options here
    ZSH_DISABLE_COMPFIX=true
    # Path to your oh-my-zsh installation.
    #export ZSH="$HOME/.oh-my-zsh"
    
    # Set name of the theme to load. Optionally, if you set this to "random"
    # it'll load a random theme each time that oh-my-zsh is loaded.
    # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
    ZSH_THEME="robbyrussell"
    
    # Uncomment the following line to use case-sensitive completion.
    # CASE_SENSITIVE="true"
    
    # Uncomment the following line to use hyphen-insensitive completion. Case
    # sensitive completion must be off. _ and - will be interchangeable.
    # HYPHEN_INSENSITIVE="true"
    
    # Uncomment the following line to automatically update without prompting.
    DISABLE_UPDATE_PROMPT="true"
    
    # Uncomment the following line to enable command auto-correction.
    # ENABLE_CORRECTION="true"
    
    # Uncomment the following line if you want to change the command execution time
    # stamp shown in the history command output.
    # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
    HIST_STAMPS="yyyy-mm-dd"
    
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
    export EDITOR='vim'
    
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
    
    # cd does not automatically push to pushd/popd/dirs stack
    unsetopt autopushd
    function cdl () { cd $@; ls }
    function cdla () { cd $@; la }
    #export PATH="/usr/local/sbin:$PATH"
    
    
    # Autocomplete ignore some filetypes for vim
    zstyle ':completion:*:*:vim:*' file-patterns '^*(.(png|aux|log|pdf|bbl|blg|out|toc|run.xml|synctex.gz)|-blx.bib):source-files' '*:all-files'
    zstyle ':completion:*:*:nvim:*' file-patterns '^*(.(png|aux|log|pdf|bbl|blg|out|toc|run.xml|synctex.gz)|-blx.bib):source-files' '*:all-files'
  '';
}
