{
  description = "Nixos config flake";

  inputs = {

    # Unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim
    nvim-nix = {
      url = "github:pierrot-lc/nvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux"; # Adjust the system architecture if needed
      pkgs = import nixpkgs {
        inherit system;
        config = {
            allowUnfree = true;
        };
        overlays = [
          # Neovim overlay
          inputs.nvim-nix.overlays.${system}.default
        ];

      };
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
