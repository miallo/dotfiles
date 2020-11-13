self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
    version = "2020-11-11";
    # src = builtins.fetchGit {
    #   url = https://github.com/neovim/neovim.git;
    # };
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "0a95549d66df63c06d775fcc329f7b63cbb46b2f";
      sha256 = "0a54xjd31dvz32hkzc8qhjnnp6g7v3npk5a5bdnlzh2mhxjnqyl4";
    };
    patches = [ ./system_rplugin_manifest.patch ];
    buildInputs = oldAttrs.buildInputs ++ [ super.pkgs.tree-sitter ];
  });
}
