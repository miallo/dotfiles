{ pkgs, ... }:

let
  vim-latex = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-latex";
    version = "2020-07-30";
    src = pkgs.fetchFromGitHub {
      owner = "vim-latex";
      repo = "vim-latex";
      rev = "d97bbf333453b793ab0916265c900299934723e2";
      sha256 = "1hzcsfq2zb091v4yy1jr10pi1yc3max1jlj8k5rr0gxvsy0rxzkw";
    };
    meta = {
      description = "This vim plugin provides a rich tool of features for editing latex files";
      license = pkgs.lib.licenses.cc0;
    };
  };
  loupe = pkgs.vimUtils.buildVimPlugin {
    pname = "loupe";
    version = "2020-10-12";
    src = pkgs.fetchFromGitHub {
      owner = "wincent";
      repo = "loupe";
      rev = "fdbfee0cffe094f0aa7e9039760633380fdb55f8";
      sha256 = "1mam21z6gbzfsx764mjcdbkbm7043jb8mpph9q7n3f32w351igjs";
    };
    meta = {
      description = "Make search/regex work bit more sensible";
      license = pkgs.lib.licenses.bsd2;
    };
  };
  terminus = pkgs.vimUtils.buildVimPlugin {
    pname = "terminus";
    version = "2020-10-04";
    src = pkgs.fetchFromGitHub {
      owner = "wincent";
      repo = "terminus";
      rev = "51c9bf43427af5ddff7352707a2bdab58cac9593";
      sha256 = "158adcq4hfv80qpkqdz555dqs45ahjnkggdzliqygpa8m9qjzmiq";
    };
    meta = {
      description = "Improve Terminal support: Cursor-Shape in insert, mouse support, focus reporting, bracketed paste";
      license = pkgs.lib.licenses.bsd2;
    };
  };

in {
  nixpkgs.overlays = [
    ( import ../overlays/neovim.nix )
  ];
  environment.variables = { EDITOR = "nvim"; };

  environment.systemPackages = with pkgs; [
    (neovim.override {
    #(vim_configurable.override {
      vimAlias = true;
      withPython3 = true;
      #python = python3;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [
            vim-rooter      # make folder of .git/ to vim path
            vim-lastplace   # Open file at last known cursor position
            vim-nix         # Nix-syntax highlighting
            vim-fugitive    # Git wrapper
            gitgutter       # Show which lines changed

            vim-eunuch      # Rename/move files
            vim-surround    # Change surrounding paranths/quotes with :cs"'
            matchit-zip     # `%` includes if/else, tags, ...
            # auto-pairs      # Add closing parantheses...
            # rainbow         # Color parantheses in pairs
            fzf-vim         # fuzzy file finder
            loupe           # Search magically
            terminus        # Make terminal vim behave a bit more graphical
            #YouCompleteMe
            #ctrlp.vim'
            vim-latex
            vim-css-color
            vim-javascript
            #vim-js-file-import
            vim-jsx-pretty
            vim-test        # Run tests from inside vim

            vim-which-key   # Show which keys correspond to which keybindings

            indentLine      # Show indentation levels
            ale             # Linting
            deoplete-nvim   # Code completion
            base16-vim      # Colors
            #nerdtree        # Filefinder
            #vim-gutentags
            #vim-fireplace   # Clojure
            vim-commentary  # Comment/uncomment with gcc
            vimwiki         # Have markdown-wiki at ~/.vimwiki
          ];
          opt = [];
        };
        customRC = (builtins.readFile ./init.vim);
      };
    })
    # .overrideAttrs (attrs: {
    # postInstall = (attrs.postInstall or "") + ''
    #   cp -r vim $out/share/applications/emacs.desktop
    # '';
  # });
  ];
}
