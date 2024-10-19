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

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-wsl,
    neovim-nightly-overlay,
    ...
  } @ inputs: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlays.default ];
      config = {
        allowUnfree = true;
      };
    };
  in {
    overlays.default = [
      neovim-nightly-overlay.overlays.default
      # (import ./overlays/neovim-nightly-unwrapped.nix {inherit inputs;})
   ];

    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {inherit inputs;};
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.default
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	  }
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
