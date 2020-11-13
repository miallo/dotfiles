self: super:

{
  i3 = super.i3.overrideAttrs (old: {
    version = "4.18.3";

    src = super.fetchurl {
      url = "https://i3wm.org/downloads/${old.pname}-${self.version}.tar.bz2";
      sha256 = "03dijnwv2n8ak9jq59fhq0rc80m5wjc9d54fslqaivnnz81pkbjk";
    };
  });
}

