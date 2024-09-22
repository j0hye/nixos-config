{ config, pkgs, ... }:

{
  home.username = "johye";
  home.homeDirectory = "/home/johye";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.clang
  ];

  imports = [ 
    ./nvim.nix 
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
