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
    # pkgs.clang
    pkgs.xclip
  ];
  
  programs.neovim = {   
    # Enable and use custom package
    enable = true;
    package = pkgs.neovim-unwrapped-nightly;
    # package = pkgs.callPackage ./programs/neovim/neovim.nix { 
    #   bundled = true; 
    # };
  };

  # Default editor
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
