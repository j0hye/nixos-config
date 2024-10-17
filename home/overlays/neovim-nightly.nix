{
  inputs = {
    ...
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, ... }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    in
      homeConfigurations = {
        johye = inputs.home-manager.lib.homeManagerConfiguration {
          modules = [
            {
              nixpkgs.overlays = overlays;
            };
          ];
        };
      };
}
