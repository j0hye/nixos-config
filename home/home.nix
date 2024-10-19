{
  pkgs,
  inputs,
  ...
}:
{
  home.username = "johye";
  home.homeDirectory = "/home/johye";
  home.stateVersion = "24.05";

  home-manager.useUserPkgs = true;
  home-manager.useGlobalPkgs = true;
  # nixpkgs.overlays = [
  #   (import ./overlays/neovim-nightly/neovim-nightly.nix { inherit inputs; })
  # ];

  home.packages = [
    pkgs.xclip
    # pkgs.nvim-fhs
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly-unwrapped;
  };
  
  # Default editor
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
