{ inputs }:
final: prev:  {
  nvim-fhs = let
    neovim-nightly-unwrapped = inputs.neovim-nightly-overlay.packages."x86_64-linux".default;
    nvim = let
      config = let
        extraPackages = [
          final.lua5_1
          final.luarocks
          final.clang
          final.pkg-config
          final.cargo
        ];
      in
        final.neovimUtils.makeNeovimConfig
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
            "${final.lib.makeBinPath extraPackages}"
          ];
        };
    in
      final.wrapNeovimUnstable neovim-nightly-unwrapped config;
  in
    final.buildFHSEnv {
      name = "nvim";
      targetPkgs = pkgs: [
        nvim
      ];

      runScript = final.writeShellScript "nvim-fhs.sh" ''
        exec ${nvim}/bin/nvim "$@"
      '';
    };
}
