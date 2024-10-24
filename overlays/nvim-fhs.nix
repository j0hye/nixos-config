final: prev: {
  nvim-fhs = let
    nvim = let
      neovim-nightly-unwrapped = final.neovim.overrideAttrs {
        treesitter-parsers = {};
      };
      config = let
        extraPackages = with prev; [
          lua5_1
          luarocks
          gcc
          fd
          ripgrep
          unzip
          gnumake
          pkg-config
          cargo
          wget
        ];
      in
        prev.neovimUtils.makeNeovimConfig
        {
          withPython3 = false;
          withRuby = false;
          withNodeJs = false;

          extraLuaPackages = p:
            with p; [
              pathlib-nvim
              luautf8 # nvim-spider dep
            ];

          inherit extraPackages;

          # plugins = with prev.vimPlugins; [
          #   nvim-treesitter.withAllGrammars
          # ];

          customRC = ''
            set runtimepath^=${../configs/nvim/.}
            source ${../configs/nvim/.}/init.lua
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
