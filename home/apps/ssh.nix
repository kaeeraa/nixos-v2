{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      github = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github.ed25519";
        identitiesOnly = true;
      };
      alpha-vds = {
        user = "kaeeraa";
        identityFile = "~/.ssh/alpha-vds.ed25519";
        identitiesOnly = true;
        include = "~/.ssh/alpha-vds-hostname";
      };
      router = {
        hostname = "192.168.1.1";
        port = "228";
        user = "root";
        identityFile = "~/.ssh/router.ed25519";
        identitiesOnly = true;
      };
      belarus_bn = {
        hostname = "153.80.244.202";
        port = "2222";
        user = "root";
        identityFile = "~/.ssh/belarus_bn.ed25519";
        identitiesOnly = true;
      };
      poland1_bn = {
        hostname = "185.16.38.120";
        user = "root";
        identityFile = "~/.ssh/poland1_bn.ed25519";
        identitiesOnly = true;
      };
      poland2_bn = {
        hostname = "185.16.38.121";
        user = "root";
        identityFile = "~/.ssh/poland2_bn.ed25519";
        identitiesOnly = true;
      };
      pterodactyl_bn = {
        user = "root";
        identityFile = "~/.ssh/pterodactyl_bn.ed25519";
        identitiesOnly = true;
        include = "~/.ssh/pterodactyl_bn-hostname";
      };
      hostiq-uni = {
        user = "root";
        identityFile = "~/.ssh/hostiq-uni.ed25519";
        identitiesOnly = true;
        include = "~/.ssh/hostiq-uni-hostname";
      };
    };
  };
}
