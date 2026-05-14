{pkgs, ...}: {
  environment.systemPackages = with pkgs; [sops age-plugin-tpm age];
  sops = {
    defaultSopsFile = ./secrets.yaml;

    age = {
      plugins = [pkgs.age-plugin-tpm];
      keyFile = "/var/lib/sops-nix/age.key";
    };

    secrets = {
      github = {
        path = "/home/kaeeraa/.ssh/github.ed25519";
        owner = "kaeeraa";
        mode = "0600";
      };
    };
  };
}
