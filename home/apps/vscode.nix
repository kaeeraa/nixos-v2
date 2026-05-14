{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jdinhlife.gruvbox
        pkief.material-icon-theme

        jnoortheen.nix-ide
        sumneko.lua
        ms-python.python
        ms-python.vscode-pylance
        mads-hartmann.bash-ide-vscode
        esbenp.prettier-vscode

        editorconfig.editorconfig
        foxundermoon.shell-format
        mkhl.direnv
        kamadorueda.alejandra

        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        charliermarsh.ruff
        usernamehw.errorlens
        christian-kohler.path-intellisense
      ];

      userSettings = {
        "window.zoomLevel" = 1;
        "workbench.colorTheme" = "Gruvbox Dark Hard";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
        "window.titleBarStyle" = "custom";
        "window.commandCenter" = false;

        "editor.fontFamily" = "Iosevka NFM";
        "editor.fontSize" = lib.mkForce 18;
        "editor.lineHeight" = 1.6;
        "editor.fontWeight" = 500;
        "editor.fontLigatures" = true;
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.minimap.enabled" = true;
        "editor.wordWrap" = "on";
        "files.autoSave" = "onFocusChange";
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.accessibilitySupport" = "off";
        "editor.renderWhitespace" = "selection";
        "editor.suggest.preview" = true;
        "editor.minimap.autohide" = "mouseover";

        "chat.disableAIFeatures" = true;

        "terminal.integrated.defaultProfile.linux" = "zsh";
        "terminal.integrated.profiles.linux" = {
          "zsh" = {
            path = "${pkgs.zsh}/bin/zsh";
            args = ["-l"];
            icon = "vm";
          };
        };
        "terminal.integrated.cwd" = config.home.homeDirectory;

        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.formatterPath" = "nixfmt";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {"command" = ["nixfmt"];};
            "options" = {"nixos" = {"expr" = "import <nixpkgs/nixos> {}";};};
          };
        };

        "python.analysis.languageServerMode" = "full";
        "python.analysis.typeCheckingMode" = "standard";
        "python.analysis.diagnosticMode" = "workspace";
        "python.analysis.fixAll" = ["source.unusedImports" "source.convertImportFormat" "source.convertImportStar" "source.addTypeAnnotation"];

        "bashIde.shfmt.simplifyCode" = true;
        "shellformat.path" = "${pkgs.shfmt}/bin/shfmt";

        "telemetry.telemetryLevel" = "off";
        "extensions.autoUpdate" = false;
        "update.mode" = "none";
        "workbench.enableExperiments" = false;
        "security.workspace.trust.enabled" = false;
        "breadcrumbs.enabled" = true;
        "explorer.compactFolders" = false;
        "workbench.list.smoothScrolling" = true;
        "keyboard.dispatch" = "keyCode";

        "files.watcherExclude" = {
          "**/node_modules/**" = true;
          "**/.git/**" = true;
          "**/dist/**" = true;
        };

        "[nix]"."editor.defaultFormatter" = "kamadorueda.alejandra";
        "[env]"."editor.defaultFormatter" = "foxundermoon.shell-format";
        "[python]"."editor.defaultFormatter" = "charliermarsh.ruff";
      };
      keybindings = [
        {
          key = "ctrl+h";
          command = "workbench.action.navigateLeft";
        }
        {
          key = "ctrl+j";
          command = "workbench.action.navigateDown";
        }
        {
          key = "ctrl+k";
          command = "workbench.action.navigateUp";
        }
        {
          key = "ctrl+l";
          command = "workbench.action.navigateRight";
        }

        {
          key = "ctrl+shift+[";
          command = "workbench.action.previousEditor";
        }
        {
          key = "ctrl+shift+]";
          command = "workbench.action.nextEditor";
        }

        {
          key = "ctrl+p";
          command = "workbench.action.quickOpen";
        }
        {
          key = "ctrl+shift+p";
          command = "workbench.action.showCommands";
        }
        {
          key = "ctrl+shift+f";
          command = "workbench.action.findInFiles";
        }

        {
          key = "f12";
          command = "editor.action.revealDefinition";
        }
        {
          key = "shift+f12";
          command = "editor.action.goToReferences";
        }
        {
          key = "ctrl+k ctrl+i";
          command = "editor.action.showHover";
        }
        {
          key = "ctrl+.";
          command = "editor.action.codeAction";
        }

        {
          key = "ctrl+`";
          command = "workbench.action.terminal.toggleTerminal";
        }
        {
          key = "ctrl+shift+`";
          command = "workbench.action.terminal.new";
        }

        {
          key = "ctrl+shift+i";
          command = "editor.action.formatDocument";
        }

        {
          key = "ctrl+/";
          command = "editor.action.commentLine";
          when = "editorTextFocus";
        }
      ];

      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
    };
  };
}
