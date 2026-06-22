{pkgs, ...}: {
  services.xserver.enable = true;
  services.dbus.enable = true;
  security.polkit.enable = true;
  programs.dconf.enable = true;
  services.displayManager.gdm.enable = false;

  environment.systemPackages = [pkgs.sddm-gruvbox];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
        FastConnectable = true;
      };
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    wireplumber.extraConfig.bluetooth = {
      "51-disable-hfp" = {
        "monitor.bluez.properties" = {
          "bluez5.enable-hfp" = false;
          "bluez5.enable-sco" = false;
          "bluez5.enable-ldac" = true;
        };
      };
      extraConfig.pipewire = {
        "99-custom-config" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 1024;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 2048;

            # CPU optimization
            "default.clock.power-of-two-quantum" = false;

            # Memory settings
            "mem.warn-mlock" = false;
            "mem.allow-mlock" = true;
          };
        };
      };
      extraConfig.jack."99-buffer-size"."jack.properties"."default.buffer-size" = 1024;
      extraConfig.pipewire-pulse = {
        "99-pulse-config" = {
          "pulse.properties" = {
            "pulse.min.req" = "1024/48000";
            "pulse.default.req" = "2048/48000";
            "pulse.max.req" = "4048/48000";
            "pulse.min.frag" = "1024/48000";
            "pulse.default.frag" = "2048/48000";
            "pulse.max.frag" = "4048/48000";
            "pulse.default.tlength" = "4048/48000";
            "pulse.min.quantum" = "1024/48000";
            "pulse.max.quantum" = "2048/48000";
          };
          "stream.properties" = {
            "node.latency" = "1024/48000";
            "resample.quality" = 4;
          };
        };
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_DRM_NO_ATOMIC = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
