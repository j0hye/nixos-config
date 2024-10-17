final: prev: {
  neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "nightly";

    src = prev.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "nightly";
      sha256 = "sha256-RB7vPyiJIjTiKpeeI9wsi2o1H5jsMtWn8Iq1KtjJeDw=";
    };
  });
}
