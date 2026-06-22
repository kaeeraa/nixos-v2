{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    disko.url = "github:nix-community/disko";
    impermanence.url = "github:nix-community/impermanence";

    mangowm.url = "github:mangowm/mango";
    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";
    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    ayugram-desktop.url = "github:ndfined-crp/ayugram-desktop";
    freesmlauncher.url = "github:kaeeraa/FreesmLauncher";

    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";

    nixvim.url = "github:nix-community/nixvim";
    nix-index-database.url = "github:nix-community/nix-index-database";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";

    pterodactyl = {
      url = "git+https://codeberg.org/Poellebob/pterodactyl-flake.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    mangowm,
    noctalia-shell,
    nixvim,
    zen-browser,
    firefox-addons,
    nix-index-database,
    disko,
    impermanence,
    ayugram-desktop,
    freesmlauncher,
    nix-flatpak,
    zapret-discord-youtube,
    millennium,
    pterodactyl,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    settings = import ./settings.nix;
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit settings inputs system;};

      modules = [
        inputs.sops-nix.nixosModules.sops
        inputs.mangowm.nixosModules.mango
        inputs.home-manager.nixosModules.home-manager
        inputs.nix-index-database.nixosModules.default
        inputs.disko.nixosModules.disko
        inputs.impermanence.nixosModules.default
        inputs.zapret-discord-youtube.nixosModules.withTestTools

        ./custom
        ./hosts/desktop/default.nix
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.kaeeraa = import ./home/default.nix;
            extraSpecialArgs = {inherit inputs system settings;};
          };
        }
      ];
    };
    nixosConfigurations.hostiq-uni = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        inputs.sops-nix.nixosModules.sops
        inputs.disko.nixosModules.disko
        pterodactyl.nixosModules.pterodactyl

        ./hosts/hostiq-uni
      ];
    };
  };
}
