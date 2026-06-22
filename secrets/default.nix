{pkgs, ...}: let
  keyFile = "/var/lib/sops-nix/age.key";
  mkUserKeySecret = name: {
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
      github = mkUserKeySecret "github.ed25519";
      git-signing = mkUserKeySecret "git-signing.ed25519";
      alpha-vds = mkUserKeySecret "alpha-vds.ed25519";
      router = mkUserKeySecret "router.ed25519";
      belarus_bn = mkUserKeySecret "belarus_bn.ed25519";
      poland1_bn = mkUserKeySecret "poland1_bn.ed25519";
      poland2_bn = mkUserKeySecret "poland2_bn.ed25519";
      pterodactyl_bn = mkUserKeySecret "pterodactyl_bn.ed25519";
    };
  };
}
