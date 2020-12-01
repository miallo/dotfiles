{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?rev=4dd5da0ad0efec7e140f77b2d8988a84f5d72f14";
    nixos-unstable.url = "github:NixOS/nixpkgs?rev=4dd5da0ad0efec7e140f77b2d8988a84f5d72f14";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-20.03";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, ... }@inputs: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ (import ./configuration.nix) ];
      specialArgs = { inherit inputs; };
    };

    nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;

  };
}
