self: super: {
  # Add a package named `nvim-fhs` to nixpkgs
  nvim-fhs = let
    nvim = let
      config = let
        extraPackages = [
          self.lua5_1
          self.luarocks
          self.clang
          self.pkg-config
          self.cargo
        ];
      in
        self.neovimUtils.makeNeovimConfig
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
              set runtimepath^=${../../.}
              source ${../../.}/init.lua
            '';
        }
        // {
          wrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            "${self.lib.makeBinPath extraPackages}"
          ];
        };
    in
      self.wrapNeovimUnstable self.neovim-unwrapped config;
  in
    self.buildFHSEnv {
      name = "nvim";
      targetPkgs = pkgs: [
        nvim
      ];

      runScript = self.writeShellScript "nvim-fhs.sh" ''
        exec ${nvim}/bin/nvim "$@"
      '';
    };
}
