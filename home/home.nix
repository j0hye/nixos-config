{
  pkgs,
  inputs,
  ...
}:
{
  home.username = "johye";
  home.homeDirectory = "/home/johye";
  home.stateVersion = "24.05";

  nixpkgs.overlays = [
    (import ./overlays/neovim-nightly/neovim-nightly.nix)
  ];

  home.packages = [
    # pkgs.clang
    pkgs.xclip
    pkgs.nvim-fhs
  ];
  
  programs.neovim = {   
    # Enable and use custom package
    enable = true;
    package = inputs.neovim-nightly-overlay.packages."x86_64-linux".default;
  };

  # Default editor
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
