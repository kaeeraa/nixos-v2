{pkgs, ...}: {
  programs.zsh.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      command_timeout = 1000;

      format = "$username$hostname $directory$git_branch$git_status$nix_shell\n$character";

      username = {
        show_always = true;
        format = "[$user](bold blue)";
      };

      hostname = {
        ssh_only = true;
        format = "[@$hostname](bold dimmed white)";
      };

      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        home_symbol = "~";
        read_only = " 󰌾";
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
      };

      git_branch = {
        symbol = " ";
        format = "[$symbol$branch]($style) ";
        style = "bold purple";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style)) ";
        style = "bold red";
        conflicted = "=";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "?";
        stashed = "$";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };

      nix_shell = {
        format = "[󱄅 $name](bold blue) ";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
    };
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    jq
    yq-go

    eza
    bat
    fd
    ripgrep
    zoxide
    fzf
    tmux
    aria2

    bottom
    btop-cuda
    httpie
    man-pages
    man-pages-posix
    fastfetch
    just
  ];

  environment.shellAliases = {
    ls = "eza --icons --group-directories-first";
    ll = "eza -lah --icons --group-directories-first";
    lt = "eza --tree --icons";
    cat = "bat -p";
    grep = "rg";
    find = "fd";
    j = "just";
    ff = "fastfetch";
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };
}
