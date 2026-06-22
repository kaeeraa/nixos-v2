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
    ./cpu.nix
    ./virtualisation.nix

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
      serif = ["Inter"];
      sansSerif = ["Inter"];
      monospace = ["Maple Mono Normal NF"];
    };
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
    ACTION=="add", SUBSYSTEM=="usb", TEST=="power/wakeup", ATTR{power/wakeup}="disabled"
  '';
  services.udev.packages = with pkgs; [
    platformio-core.udev
    openocd
  ];
  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
    HandleSuspendKey = "suspend";
    HandleHibernateKey = "suspend";
  };
  systemd.sleep.settings.Sleep = {
    suspendState = "mem";
  };
  services.flatpak.enable = true;
  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };
}
