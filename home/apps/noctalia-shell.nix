{
  config,
  lib,
  pkgs,
  noctalia,
  ...
}: {
  imports = [noctalia.homeModules.default];

  home.file.".cache/noctalia/wallpapers.json".text = builtins.toJSON {defaultWallpaper = ../../static/wallpaper.jpg;};
  programs.noctalia-shell = {
    enable = true;
    settings = {
      dock.enabled = false;
      bar = {
        position = "top";
        density = "compact";
        showCapsule = true;
        enableExclusionZoneInset = true;
        useSeparateOpacity = false;
        backgroundOpacity = 0.6;
        widgets = {
          left = [
            {
              id = "MediaMini";
              enableVisualizer = true;
              visualizerType = "wave";
            }
          ];
          center = [
            {
              id = "Workspace";
              labelMode = "none";
              hideUnoccupied = false;
            }
          ];
          right = [
            {id = "Tray";}
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              useMonospacedFont = true;
            }
          ];
        };
      };

      general = {
        scaleRation = 1.1;
        animationDisabled = true;
        radiusRatio = 0.6;
        enableShadows = false;
        enableBlurBehind = true;
        lockOnSuspend = true;
        showHibernateOnLockScreen = true;
      };

      ui = {
        fontDefault = "Iosevka NF";
        fontFixed = "Iosevka NFM";
        fontDefaultScale = 1.2;
        fontFixedScale = 1.2;
        panelBackgroundOpacity = 0.6;
        tooltipsEnabled = true;
        scrollbarAlwaysVisible = false;
      };

      appLauncher = {
        position = "center";
        sortByMostUsed = true;
        terminalCommand = "${pkgs.alacritty}/bin/alacritty -e";
        enableClipboardHistory = true;
        clipboardWatchTextCommand = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store";
      };

      controlCenter = {
        position = "close_to_bar_button";
        shortcuts = {
          left = [{id = "Network";} {id = "Bluetooth";}];
          right = [{id = "Notifications";} {id = "PowerProfile";}];
        };
      };

      notifications = {
        enabled = true;
        location = "top_center";
        density = "compact";
        enableMarkdown = true;
        backgroundOpacity = 0.6;
        lowUrgencyDuration = 1.5;
        normalUrgencyDuration = 2;
        criticalUrgencyDuration = 3;
        saveToHistory = {
          low = true;
          normal = true;
          critical = true;
        };
        sounds = {
          enabled = true;
          volume = 0.2;
        };
        enableKeyboardLayoutToast = false;
      };

      osd = {
        enabled = true;
        location = "center";
        autoHideMs = 1000;
        backgroundOpacity = 0.6;
      };

      colorSchemes.predefinedScheme = "Gruvbox";
      templates.activeTemplates = ["Alacritty" "btop" "GTK" "Qt" "Telegram" "VSCode" "Zen Browser"];

      brightness.enableDdcSupport = true;

      location = {
        name = "Tula, Russia";
        autoLocate = false;
        weatherEnabled = true;
        useFahrenheit = false;
      };

      nightLight.enabled = true;
    };
  };

  home.packages = with pkgs; [
    cliphist
    wl-clipboard
  ];
}
