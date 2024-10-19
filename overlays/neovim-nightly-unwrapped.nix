{ inputs, ... }: {
neovim-nightly-unwrapped = final: prev: {
  asdf = final.neovim-nightly-overlay.packages."x86_64-linux".default;
};
}
