{
  inputs,
  config,
  ...
}: {
  imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];

  services.flatpak = {
    enable = config.services.flatpak.packages != [];
    packages = [];
  };
}
