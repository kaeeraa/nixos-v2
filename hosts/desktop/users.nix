{pkgs, ...}: {
  users.users.kaeeraa = {
    isNormalUser = true;
    description = "kaeeraa";
    shell = pkgs.zsh;

    extraGroups = [
      "wheel"
      "video"
      "audio"
      "input"
      "tss"
      "dialout"
    ];

    hashedPassword = "$y$j9T$jPj9ABaZtzpnuWhTNF62O.$znOwZYYvs0otGcIHXrujM54XND7/f2Z4zxm3ahQo/Z7";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHWBzjU2qTNlQo4mR0gjQ8mtM0zNZWy2vnW2zkTFam5q kaeeraa@desktop"];
  };

  security.doas.enable = true;
  security.doas.extraRules = [
    {
      users = ["kaeeraa"];
      keepEnv = true;
      noPass = true;
    }
  ];
}
