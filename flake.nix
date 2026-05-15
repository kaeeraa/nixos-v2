{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ayugram-desktop = {
      url = "github:ndfined-crp/ayugram-desktop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    freesmlauncher = {
      url = "github:kaeeraa/FreesmLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    mangowm,
    noctalia,
    nixvim,
    zen-browser,
    firefox-addons,
    nix-index-database,
    disko,
    impermanence,
    ayugram-desktop,
    freesmlauncher,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    settings = import ./settings.nix;
  in {
    formatter.${system} = pkgs.alejandra;
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit settings;};

      modules = [
        sops-nix.nixosModules.sops
        mangowm.nixosModules.mango
        home-manager.nixosModules.home-manager
        nix-index-database.nixosModules.default
        disko.nixosModules.disko
        impermanence.nixosModules.default

        ./packages
        ./secrets
        ./hosts/desktop/default.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit
              settings
              system
              noctalia
              nixvim
              zen-browser
              firefox-addons
              mangowm
              ayugram-desktop
              freesmlauncher
              ;
          };
          home-manager.users.kaeeraa = import ./home/default.nix;
        }
      ];
    };
  };
}
