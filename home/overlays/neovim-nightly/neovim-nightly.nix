{ inputs, pkgs, system, lib, ... }:
let
  neovim-nightly-unwrapped = inputs.neovim-nightly-overlay.packages.${system}.default;
in
{
  # Add a package named `nvim-fhs` to nixpkgs
  nvim-fhs = let
    nvim = let
      config = let
        extraPackages = [
          pkgs.lua5_1
          pkgs.luarocks
          pkgs.clang
          pkgs.pkg-config
          pkgs.cargo
        ];
      in
        pkgs.neovimUtils.makeNeovimConfig
        {
          withPython3 = false;
          withRuby = false;
          withNodeJs = false;

          extraLuaPackages = p:
            with p; [
              p.magick
            ];

          inherit extraPackages;

          customRC =
            ''
              set runtimepath^=${../../configs/nvim/.}
              source ${../../configs/nvim/.}/init.lua
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
      pkgs.wrapNeovimUnstable neovim-nightly-unwrapped config;
  in
    pkgs.buildFHSEnv {
      name = "nvim";
      targetPkgs = pkgs: [
        nvim
      ];

      runScript = pkgs.writeShellScript "nvim-fhs.sh" ''
        exec ${nvim}/bin/nvim "$@"
      '';
    };
}
