{
  inputs,
  pkgs,
  lib,
  wrapNeovimUnstable,
  # neovim-unwrapped,
  neovimUtils,
  writeShellScript,
  lua5_1,
  luarocks,
  clang,
  pkg-config,
  cargo,
  statix,
  manix,
  buildFHSEnv,
  bundled ? true,
  ...
}: let
  nvim = let
    config = let
      extraPackages = [
        lua5_1
        luarocks
        clang
        pkg-config
        cargo

        # LSP
        statix
        manix
      ];
    in
      neovimUtils.makeNeovimConfig
      {
        withPython3 = true;
        withRuby = false;
        withNodeJs = true;

        extraLuaPackages = p:
          with p; [
            magick
          ];

        inherit extraPackages;

        customRC =
          if bundled
          then ''
            set runtimepath^=${../../.}
            source ${../../.}/init.lua
          ''
          else ''
            set runtimepath^=~/.nvim
            set runtimepath-=~/.config/nvim
            source ~/.nvim/init.lua
          '';
      }
      // {
        wrapperArgs = [
          "--prefix"
          "PATH"
          ":"
          "${lib.makeBinPath extraPackages}"
        ];
      };
  in
    wrapNeovimUnstable inputs.neovim-nightly-overlay.packages.${pkgs.system}.default config;
in
  buildFHSEnv {
    name = "nvim";
    targetPkgs = pkgs: [
      nvim
    ];

    runScript = writeShellScript "nvim-fhs.sh" ''
      exec ${nvim}/bin/nvim "$@"
    '';
  }
