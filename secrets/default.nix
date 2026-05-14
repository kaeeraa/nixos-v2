{pkgs, ...}: let
  keyFile = "/var/lib/sops-nix/age.key";
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
      github = {
        path = "/home/kaeeraa/.ssh/github.ed25519";
        owner = "kaeeraa";
        mode = "0600";
      };
      git-signing = {
        path = "/home/kaeeraa/.ssh/git-signing.ed25519";
        owner = "kaeeraa";
        mode = "0600";
      };
    };
  };
}
