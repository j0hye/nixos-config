{
  pkgs,
  inputs,
  ...
}: {
  home.username = "johye";
  home.homeDirectory = "/home/johye";
  home.stateVersion = "24.05";

  # home.packages = [
  #   pkgs.ripgrep
  #   pkgs.fd
  #   pkgs.clang
  #   pkgs.xclip
  # ];

  # imports = [
  #   ./nvim.nix
  # ];

  programs.neovim = {
    # Enable and use nightly
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    # For node/py plugins
    withNodeJs = true;
    withPython3 = true;

    # Aliases
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Packages for editing configs
    extraPackages = with pkgs; [
      # Lua
      lua-language-server
      stylua

      # Nix
      nixd
      nil
      alejandra

      # Bash
      bash-language-server
      shfmt

      # Neovim utils
      ripgrep
      fd
      xclip #  TODO: Move to WSL
    ];

    # Load init.lua
    extraConfig = builtins.readFile ../configs/nvim/init.lua;

    # Plugins handled by nix
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
  };

  # Default editor
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
