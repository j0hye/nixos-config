self: super: {
  # Rename the package from the neovim-nightly overlay to neovim-nightly
  availablePackages = builtins.attrNames super;
  neovim-nightly = super.neovim-nightly-overlay.default;
}
