{
  settings,
  system,
  pkgs,
  ayugram-desktop,
  mangowm,
  ...
}: {
  imports = [mangowm.hmModules.mango];
  wayland.windowManager.mango = {
    enable = true;
    settings = {
      monitorrule = [
        "name:DP-1,width:1920,height:1080,refresh:165,x:0,y:0,vrr:1"
        "name:DP-4,width:1920,height:1080,refresh:165,x:0,y:0,vrr:1"
        "name:DVI-D-1,width:1920,height:1080,refresh:60,x:1920,y:0,vrr:1"
      ];

      repeat_delay = 300;

      xkb_rules_layout = settings.xkb.layout;
      xkb_rules_variant = settings.xkb.variant;
      xkb_rules_options = settings.xkb.options;

      mouse_accel_profile = 0;

      syncobj_enable = 1;

      focus_on_activate = 1;
      allow_tearing = 0;
      blur_optimized = 1;
      drag_tile_to_tile = 1;

      animations = 0;

      gappih = 6;
      gappiv = 6;
      gappoh = 6;
      gappov = 6;

      borderpx = 2;
      border_radius = 4;

      blur = 1;
      blur_layer = 0;
      blur_params_radius = 12;
      blur_params_num_passes = 3;
      blur_params_noise = 0.05;
      blur_params_brightness = 0.9;
      blur_params_contrast = 1.1;

      shadows = 0;
      layer_shadows = 0;
      shadows_size = 12;
      shadows_blur = 20;
      shadows_position_x = 0;
      shadows_position_y = 12;
      shadow_only_floating = 0;

      focused_opacity = 1.0;
      unfocused_opacity = 0.92;

      cursor_size = 12;
      cursor_theme = "GoogleDot-Black";

      env = [
        "NIXOS_OZONE_WL,1"

        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_ENABLE_HIGHDPI_SCALING,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,0"
        "QT_SCALE_FACTOR,1.2"

        "GDK_SCALE,1"
        "GDK_DPI_SCALE,1.2"
        "GDK_BACKEND,wayland"

        "XCURSOR_SIZE,32"

        "__GL_SHADER_DISK_CACHE,1"
        "__GL_SHADER_DISK_CACHE_PATH,$HOME/.nv/GLCache"
        "__GL_SHADER_DISK_CACHE_SKIP_CLEANUP,1"
      ];

      exec-once = [
        "pkill -9 .quickshell-wra; noctalia-shell"
        "${pkgs.throne}/bin/Throne"
        "${ayugram-desktop.packages.${system}.default}/bin/AyuGram -autostart"
      ];

      bind = [
        "SUPER,Return,spawn,${pkgs.alacritty}/bin/alacritty"
        "SUPER,Space,spawn_shell,noctalia-shell ipc call launcher toggle"
        "SUPER+ALT,Space,spawn_shell,noctalia-shell ipc call launcher command"
        "SUPER,code:60,spawn_shell,noctalia-shell ipc call launcher emoji"

        "SUPER,Q,killclient"
        "SUPER+SHIFT,R,reload_config"
        "SUPER+SHIFT,W,spawn_shell,pkill -9 .quickshell-wra ; noctalia-shell"

        "SUPER,L,spawn,noctalia-shell ipc call lockScreen lock"

        "SUPER,Print,spawn,${pkgs.hyprshot}/bin/hyprshot --freeze --clipboard-only --mode region --silent"

        "SUPER,1,view,1"
        "SUPER,2,view,2"
        "SUPER,3,view,3"
        "SUPER,4,view,4"
        "SUPER,5,view,5"
        "SUPER,6,view,6"
        "SUPER,7,view,7"
        "SUPER,8,view,8"
        "SUPER,9,view,9"
        "SUPER,0,view,10"

        "SUPER+SHIFT,1,tag,1"
        "SUPER+SHIFT,2,tag,2"
        "SUPER+SHIFT,3,tag,3"
        "SUPER+SHIFT,4,tag,4"
        "SUPER+SHIFT,5,tag,5"
        "SUPER+SHIFT,6,tag,6"
        "SUPER+SHIFT,7,tag,7"
        "SUPER+SHIFT,8,tag,8"
        "SUPER+SHIFT,9,tag,9"
        "SUPER+SHIFT,0,tag,10"

        "SUPER,Left,resizewin,-20,0"
        "SUPER,Right,resizewin,20,0"
        "SUPER,Up,resizewin,0,-20"
        "SUPER,Down,resizewin,0,20"

        "SUPER+SHIFT,Left,tagmon,DP-1"
        "SUPER+SHIFT,Right,tagmon,DVI-D-1"

        "SUPER,V,togglefloating"
        "SUPER,F,togglefullscreen"

        "NONE,XF86AudioMute,spawn_shell,noctalia-shell ipc call media playPause"
        "NONE,XF86AudioRaiseVolume,spawn_shell,bash ~/Scripts/mediaWheel.sh up"
        "NONE,XF86AudioLowerVolume,spawn_shell,bash ~/Scripts/mediaWheel.sh down"
        "SUPER,XF86AudioMute,spawn_shell,noctalia-shell ipc call volume muteOutput"
        "SUPER,XF86AudioRaiseVolume,spawn_shell,noctalia-shell ipc call volume increase"
        "SUPER,XF86AudioLowerVolume,spawn_shell,noctalia-shell ipc call volume decrease"
        "SUPER+SHIFT,XF86AudioRaiseVolume,spawn_shell,noctalia-shell ipc call brightness increase"
        "SUPER+SHIFT,XF86AudioLowerVolume,spawn_shell,noctalia-shell ipc call brightness decrease"
      ];

      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
      ];
    };
    extraConfig = "source-optional=\"~/.config/mango/noctalia.conf\"";
  };
}
