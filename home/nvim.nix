{pkgs, ...}:
{
  home.packages = with pkgs; [

    # Neovim
    nvim-pkg

    # lua
    lua-language-server
    stylua

    # nix
    nixd
    nil
    alejandra

    # bash
    bash-language-server
    shfmt
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
