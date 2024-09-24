{
  config,
  pkgs,
  ...
}: {
  home.username = "johye";
  home.homeDirectory = "/home/johye";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.clang
    pkgs.xclip
  ];

  imports = [
    ./nvim.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
