{pkgs, ...}: {
  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";
    mouse = true;
    keyMode = "vi";

    escapeTime = 10;
    historyLimit = 50000;

    baseIndex = 1;
    aggressiveResize = true;
    disableConfirmationPrompt = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
      continuum
    ];

    extraConfig = ''
      ### --- core look ---
      set -g status on
      set -g status-interval 2
      set -g status-style bg=default,fg=colour250

      ### --- window style ---
      setw -g window-status-format " #I:#W "
      setw -g window-status-current-format " #[bold]#I:#W "

      ### --- pane borders ---
      set -g pane-border-style fg=colour237
      set -g pane-active-border-style fg=colour39

      ### --- splits (zellij-like UX) ---
      bind | split-window -h
      bind - split-window -v

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      ### --- reload config ---
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "reloaded"

      ### --- clipboard (wayland) ---
      set -s copy-command "wl-copy"

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection

      ### --- status content (clean + useful) ---
      set -g status-left "#[fg=green] #S "
      set -g status-right "#[fg=cyan]%Y-%m-%d #[fg=yellow]%H:%M"

      ### --- better UX ---
      set -g renumber-windows on
      set -g set-clipboard on

      ### --- plugins config ---
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15'
      set -g @resurrect-capture-pane-contents 'on'
    '';
  };
}
