{
  inputs = {
    nixpkgs.url = "github:miallo/nixpkgs/my-nixos";
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
