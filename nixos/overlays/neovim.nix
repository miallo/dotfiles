self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
    version = "master";
    # src = builtins.fetchTarball {
    #   url = https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz;
    src = builtins.fetchFromGithub {
      url = https://github.com/neovim/neovim.git;
      rev = "nightly";
      fetchSubmodules = true;
    };
  });
}
