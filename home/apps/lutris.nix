{pkgs, ...}: {
  programs.lutris = {
    enable = true;
    steamPackage = pkgs.steam;
  };
}
