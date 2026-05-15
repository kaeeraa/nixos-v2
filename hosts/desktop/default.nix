{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./cli.nix
    ./graphic-session.nix
    ./graphics.nix
    ./locale.nix
    ./network.nix
    ./package-manager.nix
    ./users.nix
    ./impermanence.nix
    ./openssh.nix
    ./tpm.nix
    ./hardening.nix
    ./disko.nix

    ./apps
    ./services
  ];
  networking.hostName = "desktop";
  system.stateVersion = "26.05";

  programs.mango.enable = true;
  programs.nix-index-database.comma.enable = true;

  environment.systemPackages = [pkgs.nerd-fonts.iosevka];
  fonts.fontDir.enable = true;
  fonts.fontconfig = {
    enable = true;
    cache32Bit = true;
    defaultFonts = {
      serif = ["Iosevka NF"];
      sansSerif = ["Iosevka NF"];
      monospace = ["Iosevka NF Mono"];
    };
  };

  services.logind.settings.Login = {
    HandlePowerKey = "hibernate";
    HandleSuspendKey = "hibernate";
    HandleHibernateKey = "hibernate";
  };
}
