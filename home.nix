{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = "gamal.kubeyev";
  home.homeDirectory = "/Users/gamal.kubeyev";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    jq
    lazygit
    neovim
    nerd-fonts.hack
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables.EDITOR = "nvim";

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      bindKey '^f' autosuggest-accept
    '';
    shellAliases = {
      ".." = "cd ..";
      cc = "claude --dangerously-skip-permissions";
      co = "codex --full-auto";
    };
  };

  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";
}
