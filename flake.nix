{
  description = "Nixos config flake";

  inputs = {

    # Unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

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
            inputs.home-manager.nixosModules.default
            inputs.nixos-wsl.nixosModules.default
            ./hosts/wsl/configuration.nix 
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
