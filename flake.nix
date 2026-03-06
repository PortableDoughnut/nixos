{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
	{
		nixpkgs.config.permittedInsecurePackages = [
			"dotnet-sdk-6.0.428"
		];
	}

          inputs.home-manager.nixosModules.default
          ({ config, pkgs, inputs, ... }: {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = { inherit inputs; };
              users.gwen = import ./modules/home-manager/gwen.nix;
              users.josephine = import ./modules/home-manager/josephine.nix;
            };
          })
          ./hosts/default/configuration.nix
          ./hosts/default/hardware-configuration.nix
        ];
      };
    };
}
