{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "johye";
  wsl.wslConf.interop.appendWindowsPath = false;

  nix.extraOptions = ''experimental-features = nix-command flakes'';
  nix.gc = {
      automatic = true;
      options = "--delete-older-than 7d";
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  system.stateVersion = "24.05";
}
