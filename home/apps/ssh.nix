{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
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
    };
  };
}
