self: super: {
  pcmanfm = super.pcmanfm.overrideAttrs (oldAttrs: {
    patches = [ ./pcmanfm-0201-main-set-the-GIOChannel-encoding-to-binary.patch ];
  });
}

