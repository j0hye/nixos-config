{
  pkgs,
  inputs,
  ...
}:
{
  home.username = "johye";
  home.homeDirectory = "/home/johye";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.xclip
    pkgs.nvim-fhs
  ];

  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.neovim;
  # };
  
  # Default editor
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
