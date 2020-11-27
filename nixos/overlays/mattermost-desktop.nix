self: super: {
  mattermost-desktop = super.mattermost-desktop.overrideAttrs (oldAttrs: {
    version = "4.6.1";

    src =
      if super.stdenv.hostPlatform.system == "x86_64-linux" then
      builtins.fetchurl {
          url = "https://releases.mattermost.com/desktop/4.6.1/${oldAttrs.pname}-4.6.1-linux-x64.tar.gz";
          sha256 = "0pxvlh68mynjnbcnvspndg86p4ajbhbw83fz4mx3lnfz6b4jsvcj";
          }
      else
        throw "Mattermost-Desktop is not currently supported on ${super.stdenv.hostPlatform.system}";
    });
  }
