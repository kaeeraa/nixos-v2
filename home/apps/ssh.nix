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
        hostname = "xray.nebula-nook.ru";
        user = "kaeeraa";
        identityFile = "~/.ssh/alpha-vds.ed25519";
        identitiesOnly = true;
      };
      router = {
        hostname = "192.168.1.1";
        user = "root";
        identityFile = "~/.ssh/router.ed25519";
        identitiesOnly = true;
      };
    };
  };
}
