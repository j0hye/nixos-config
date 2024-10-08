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
      url = "github:j0hye/nvim-nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-wsl,
    nvim-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux"; # Adjust the system architecture if needed
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        # Neovim overlay
        nvim-nix.overlays.default
      ];
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
        pkgs = pkgs; # Reference pkgs from nixpkgs
        extraSpecialArgs = {inherit inputs;};
        modules = [./home/home.nix];
      };
    };
  };
}
