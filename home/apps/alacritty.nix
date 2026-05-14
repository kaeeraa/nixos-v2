{
  programs.alacritty = {
    enable = true;

    settings = {
      general = {
        import = ["~/.config/alacritty/themes/noctalia.toml"];
        live_config_reload = true;
      };

      env = {
        TERM = "xterm-256color";
      };

      window = {
        padding = {
          x = 12;
          y = 12;
        };

        dynamic_padding = true;

        decorations = "None";

        opacity = 0.92;

        blur = true;

        startup_mode = "Windowed";

        dynamic_title = true;

        resize_increments = true;
      };

      scrolling = {
        history = 100000;
        multiplier = 5;
      };

      font = {
        normal = {
          family = "Iosevka NFM";
          style = "Medium";
        };

        bold.style = "Bold";
        italic.style = "Italic";
        bold_italic.style = "Bold Italic";
        size = 12.5;

        offset = {
          x = 0;
          y = 2;
        };

        glyph_offset = {
          x = 0;
          y = 1;
        };

        builtin_box_drawing = true;
      };

      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };

        blink_interval = 500;

        unfocused_hollow = true;

        thickness = 0.18;
      };

      selection = {
        save_to_clipboard = true;
      };

      mouse = {
        hide_when_typing = true;
      };

      terminal = {
        osc52 = "CopyPaste";
      };

      keyboard.bindings = [
        {
          key = "Return";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }

        {
          key = "Equals";
          mods = "Control";
          action = "IncreaseFontSize";
        }

        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }

        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }

        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }

        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }

        {
          key = "F";
          mods = "Control|Shift";
          action = "SearchForward";
        }

        {
          key = "Space";
          mods = "Control";
          action = "ToggleViMode";
        }
      ];
    };
  };
}
