{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux"; # Adjust the system architecture if needed
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = { 
        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ 
            ./hosts/wsl/configuration.nix 
            inputs.home-manager.nixosModules.default
          ];
        };
      };
      homeConfigurations = {
        johye = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;  # Reference pkgs from nixpkgs
          system = system;  # Specify the system architecture
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/home.nix ];
        };
      };
    };
}
