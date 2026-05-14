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
    ];

    hashedPassword = "$y$j9T$jPj9ABaZtzpnuWhTNF62O.$znOwZYYvs0otGcIHXrujM54XND7/f2Z4zxm3ahQo/Z7";
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
