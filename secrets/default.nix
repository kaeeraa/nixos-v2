{pkgs, ...}: let
  keyFile = "/var/lib/sops-nix/age.key";
  mkUserKey = name: {
    path = "/home/kaeeraa/.ssh/${name}";
    owner = "kaeeraa";
    mode = "0600";
  };
in {
  environment.variables = {"SOPS_AGE_KEY_FILE" = keyFile;};
  environment.systemPackages = with pkgs; [sops age-plugin-tpm age];
  sops = {
    defaultSopsFile = ./secrets.yaml;

    age = {
      plugins = [pkgs.age-plugin-tpm];
      keyFile = keyFile;
    };

    secrets = {
      github = mkUserKey "github.ed25519";
      git-signing = mkUserKey "git-signing.ed25519";
      alpha-vds = mkUserKey "alpha-vds.ed25519";
      router = mkUserKey "router";
    };
  };
}
