{...}: {
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/bluetooth"
      "/var/lib/sops-nix"
      {
        directory = "/var/log/journal";
        mode = "0755";
      }
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];

    users.kaeeraa = {
      directories = [
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
        "Projects"
        "Games"
        ".ssh"
        ".gnupg"
        ".local/share"
        ".steam"
        ".config"
      ];
      files = [
        ".zsh_history"
      ];
    };
  };

  boot.initrd.systemd.services.impermanence-btrfs = {
    description = "reset btrfs root subvolume";
    wantedBy = ["initrd.target"];
    after = ["systemd-cryptsetup@cryptroot.service" "resume.target"];
    before = ["sysroot.mount"];

    unitConfig.DefaultDependencies = false;
    serviceConfig.Type = "oneshot";

    script = builtins.readFile ./scripts/impermanence-btrfs.sh;
  };
}
