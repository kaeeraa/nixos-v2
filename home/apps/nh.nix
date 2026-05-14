{...}: {
  programs.nh = {
    enable = true;
    flake = /etc/nixos;
    osFlake = /etc/nixos;
    clean = {
      enable = true;
      dates = "weekly";
    };
  };
}
