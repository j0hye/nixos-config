{pkgs, ...}: {
  # Shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableLsColors = true;
    enableBashCompletion = true;
  };
  users.defaultUserShell = pkgs.zsh;

  # Prompt
  programs.starship = {
    enable = true;
    presets = ["pure-preset"];
    settings = {
      nix_shell = {
        format = "via [$symbol(\($name\))]($style) ";
        symbol = " ";
      };
    };
    # TODO: fix colors
  };
}
