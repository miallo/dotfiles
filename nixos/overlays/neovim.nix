self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
    version = "2020-11-11";
    # src = builtins.fetchGit {
    #   url = https://github.com/neovim/neovim.git;
    # };
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "ba13b94f5aab734bdb242d515ac43d973ba6c6c5";
      sha256 = "1aawhd6r9ad88rllps8dlj6iivzb0kxmq10311kw8kbzsmi5vlyc";
    };
    patches = [ ./system_rplugin_manifest.patch ];
    buildInputs = oldAttrs.buildInputs ++ [ super.pkgs.tree-sitter ];
  });
}
