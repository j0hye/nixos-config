{ inputs }:
final: prev:  {
  nvim-fhs = let
    neovim-nightly-unwrapped = inputs.neovim-nightly-overlay.packages."x86_64-linux".default;
    nvim = let
      config = let
        extraPackages = with prev; [
          lua5_1
          luarocks
          clang
          pkg-config
          cargo
        ];
      in
        prev.neovimUtils.makeNeovimConfig
        {
          withPython3 = false;
          withRuby = false;
          withNodeJs = false;

          extraLuaPackages = p:
            with p; [
              magick
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
            "${prev.lib.makeBinPath extraPackages}"
          ];
        };
    in
      prev.wrapNeovimUnstable neovim-nightly-unwrapped config;
  in
    prev.buildFHSEnv {
      name = "nvim";
      targetPkgs = pkgs: [
        nvim
      ];

      runScript = prev.writeShellScript "nvim-fhs.sh" ''
        exec ${nvim}/bin/nvim "$@"
      '';
    };
}
