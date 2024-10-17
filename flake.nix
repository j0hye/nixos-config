{
  description = "OI";

  inputs = {
    # Unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim-nightly-overlay
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake-utils
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-wsl,
    neovim-nightly-overlay,
    flake-utils,
    ...
  } @ inputs: 
  let
    system = "x86_64-linux";
    overlays = [
      neovim-nightly-overlay.overlays.default  # Load the neovim overlay
    ];
    pkgs = import nixpkgs {
      inherit system;
      inherit overlays;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {inherit inputs;};
        modules = [
          nixos-wsl.nixosModules.default
          inputs.home-manager.nixosModules.default
          ./hosts/wsl/configuration.nix
          ./modules/shell.nix
        ];
      };
    };
    homeConfigurations = {
      johye = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = [./home/home.nix];
      };
    };
  };
}
