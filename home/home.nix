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

  # Shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableLsColors = true;
    enableBashCompletion = true;
  };
  users.defaultUserShell = pkgs.zsh;

  # Prompt
  #programs.starship = {
  #  enable = true;
  #  presets = ["pure-preset"];
  #  settings = {
  #    nix_shell = {
  #      format = "via [$symbol(\($name\))]($style) ";
  #      symbol = " ";
  #    };
  #  };
  #  # TODO: fix colors
  #};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
