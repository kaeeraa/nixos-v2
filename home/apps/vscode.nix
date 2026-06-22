{
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;

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
        yzhang.markdown-all-in-one
        ms-vscode.cmake-tools
        ms-vscode.cpptools
        platformio.platformio-vscode-ide
        ms-vscode.remote-explorer
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit

        llvm-vs-code-extensions.vscode-clangd
        ms-vscode.cpptools-extension-pack
        github.vscode-github-actions
        nefrob.vscode-just-syntax
      ];

      userSettings = {
        "window.zoomLevel" = 0;
        "workbench.colorTheme" = "Gruvbox Dark Hard";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
        "window.titleBarStyle" = "custom";
        "window.commandCenter" = false;

        "editor.fontFamily" = "Maple Mono Normal NF";
        "editor.fontSize" = lib.mkForce 16;
        "editor.lineHeight" = 1.2;
        "editor.fontWeight" = 500;
        "editor.fontLigatures" = true;
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.minimap.enabled" = true;
        "editor.wordWrap" = "bounded";
        "editor.wrapOnEscapedLineFeeds" = true;
        "editor.wrappingStrategy" = "advanced";
        "editor.wordWrapColumn" = 140;
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 500;
        "editor.cursorBlinking" = "phase";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.accessibilitySupport" = "off";
        "editor.renderWhitespace" = "selection";
        "editor.suggest.preview" = true;
        "editor.minimap.autohide" = "mouseover";
        "editor.smoothScrolling" = true;
        "terminal.integrated.smoothScrolling" = true;

        "cmake.configureOnOpen" = true;
        "cmake.buildDirectory" = "\${workspaceFolder}/build";
        "cmake.generator" = "Ninja";
        "cmake.exportCompileCommandsFile" = true;
        "clangd.arguments" = [
          "--compile-commands-dir=build"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
        ];
        "C_Cpp.intelliSenseEngine" = "disabled";

        "chat.disableAIFeatures" = true;

        "terminal.integrated.defaultProfile.linux" = "zsh";

        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "git.alwaysSignOff" = true;
        "git.autoStash" = true;
        "git.enableCommitSigning" = true;
        "git.ignoreSubmodules" = true;
        "git.rebaseWhenSync" = true;
        "github.gitProtocol" = "ssh";

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
        "[toml]"."editor.defaultFormatter" = "tamasfe.even-better-toml";
        "[shellscript]"."editor.defaultFormatter" = "foxundermoon.shell-format";
        "[gitignore]"."editor.defaultFormatter" = "foxundermoon.shell-format";
        "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "[cpp]"."editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";
        "[ignore]"."editor.defaultFormatter" = "foxundermoon.shell-format";
        "[just]"."editor.defaultFormatter" = "nefrob.vscode-just-syntax";
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
  home.packages = with pkgs; [
    platformio
    avrdude
    cmake
    ninja
    gdb
    clang
    llvmPackages.clang-tools
    just-lsp
    just-formatter
  ];
}
