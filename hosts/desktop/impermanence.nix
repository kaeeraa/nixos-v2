{pkgs, ...}: {
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/lib/nixos"
      "/var/lib/bluetooth"
      "/var/lib/sops-nix"
      "/var/log/journal"
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
        "Scripts"
        ".ssh"
        ".gnupg"
        ".local/share"
        ".steam"
        ".config"
        ".cache/noctalia"
        ".local/state/noctalia"
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

    path = with pkgs; [
      busybox
      btrfs-progs
    ];

    unitConfig.DefaultDependencies = false;
    serviceConfig.Type = "oneshot";

    script = builtins.readFile ./scripts/impermanence-btrfs.sh;
  };
}
