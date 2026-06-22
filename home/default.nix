{
  inputs,
  system,
  pkgs,
  ...
}: {
  imports = [
    ./wm.nix
    ./cli.nix
    ./apps
    ./services
  ];

  home.username = "kaeeraa";
  home.homeDirectory = "/home/kaeeraa";
  home.stateVersion = "26.05";

  fonts.fontconfig.enable = true;
  services.gnome-keyring.enable = true;

  home.packages = with pkgs; [
    inputs.ayugram-desktop.packages.${system}.default
    inputs.freesmlauncher.packages.${system}.default

    yandex-music
    kicad
    obsidian
    postman

    maple-mono.Normal-NF
    nerd-fonts.iosevka
    inter

    libqalculate
    codex
    gpu-screen-recorder
    devenv
    element-desktop

    nixd
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen";
    TERMINAL = "alacritty";
  };
}
