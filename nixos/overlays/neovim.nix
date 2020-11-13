self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
    version = "master";
    # src = builtins.fetchTarball {
      # url = https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz;
    src = builtins.fetchGit {
      url = https://github.com/neovim/neovim.git;
    #   owner = "neovim";
    #   repo = "neovim";
    #   rev = "nightly";
    #   fetchSubmodules = true;
    };
    patches = [ ./system_rplugin_manifest.patch ];
    buildInputs = oldAttrs.buildInputs ++ [ super.pkgs.tree-sitter ];
  });
}
