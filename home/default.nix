{
  ayugram-desktop,
  freesmlauncher,
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
    ayugram-desktop.packages.${system}.default
    freesmlauncher.packages.${system}.default

    yandex-music
    (pkgs.writeShellScriptBin "muffon" ''
    exec ${pkgs.muffon}/bin/muffon --ozone-platform=x11 "$@"
  '') 

    nixd

    nerd-fonts.iosevka
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen";
    TERMINAL = "alacritty";
  };
}
