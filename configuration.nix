{ ... }:

{
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = "gamal.kubeyev";
  users.users."gamal.kubeyev" = {
    home = "/Users/gamal.kubeyev";
  };
  system.stateVersion = 6;

  # Draft: bring the Homebrew installs already on this machine under
  # declarative management so `darwin-rebuild switch` reproduces them.
  # Review the lists below against `brew leaves` / `brew list --cask`
  # before enabling — nothing here is applied until `homebrew.enable = true`.
  nix-homebrew = {
    enable = true;
    user = "gamal.kubeyev";
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # "none": leave anything not listed here alone (safe default).
      # "uninstall": remove unlisted formulae/casks. "zap": also remove
      # app data for unlisted casks. Start with "none" and tighten later.
      cleanup = "none";
    };

    taps = [
      "homebrew/services"
    ];

    brews = [
      "cmake"
      "git-lfs"
      "mysql"
      "neovim"
      "swiftlint"
      "xcodegen"
      "zsh"
      "herdr"
    ];

    casks = [
      "font-caskaydia-cove-nerd-font"
      "gstreamer-runtime"
      "utm"
      "wezterm"
      "wine-stable"
      "xquartz"
    ];
  };

  # Draft: mirror the handful of macOS defaults that are actually set away
  # from stock on this machine (checked via `defaults read`). Everything
  # else (Dock autohide, trackpad tap-to-click/drag, etc.) was already at
  # its default, so it's intentionally left undeclared here.
  system.defaults = {
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    finder.CreateDesktop = false;
    finder.FXPreferredViewStyle = "clmv"; # column view
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    trackpad.Clicking = true;
  };
}
