{lib, ...}: {
  systemd.coredump.enable = false;
  # ➡️ Sets the kernel's resource limit (ulimit -c 0)
  security.pam.loginLimits = [
    {
      domain = "*"; # Applies to all users/sessions
      type = "-"; # Set both soft and hard limits
      item = "core"; # The soft/hard limit item
      value = "0"; # Core dumps size is limited to 0 (effectively disabled)
    }
  ];

  users.groups.netdev = {};
  services = {
    dbus.implementation = "broker";
    logrotate.enable = true;
    journald = {
      storage = "volatile"; # Store logs in memory
      upload.enable = false; # Disable remote log upload (the default)
      extraConfig = ''
        SystemMaxUse=500M
        SystemMaxFileSize=50M
      '';
    };
  };

  services = {
    # mDNS/DNS-SD
    avahi.enable = false;
    # Geoclue (location services)
    geoclue2.enable = false;
    udisks2.enable = false;
    accounts-daemon.enable = false;
  };
  # Only needed for WWAN/3G/4G modems, otherwise it runs `mmcli` unnecessarily
  networking.modemmanager.enable = false;
  # Prefer manual upgrades on a hardened system
  system.autoUpgrade.enable = false;

  systemd.services = {
    bluetooth.serviceConfig = {
      ProtectKernelTunables = lib.mkDefault true;
      ProtectKernelModules = lib.mkDefault true;
      ProtectKernelLogs = lib.mkDefault true;
      ProtectHostname = true;
      ProtectControlGroups = true;
      ProtectProc = "invisible";
      SystemCallFilter = [
        "~@obsolete"
        "~@cpu-emulation"
        "~@swap"
        "~@reboot"
        "~@mount"
      ];
      SystemCallArchitectures = "native";
    };
  };

  systemd.services.NetworkManager-dispatcher.serviceConfig = {
    NoNewPrivileges = true;
    ProtectSystem = "strict";
    ProtectHome = true;
    ProtectKernelModules = true;
    ProtectKernelLogs = true;
    ProtectControlGroups = true;
    ProtectClock = true;
    ProtectHostname = true;
    ProtectProc = "invisible";
    PrivateTmp = true;
    PrivateMounts = true;
    RestrictRealtime = true;
    RestrictAddressFamilies = [
      "AF_UNIX"
      "AF_NETLINK"
      "AF_INET"
      "AF_INET6"
      "AF_PACKET"
    ];
    RestrictNamespaces = true;
    RestrictSUIDSGID = true;
    MemoryDenyWriteExecute = true;
    SystemCallFilter = [
      "~@mount"
      "~@module"
      "~@swap"
      "~@obsolete"
      "~@cpu-emulation"
      "ptrace"
    ];
    SystemCallArchitectures = "native";
    LockPersonality = true;
    CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_RAW";
  };

  systemd.services.NetworkManager.serviceConfig = {
    NoNewPrivileges = true;
    ProtectHome = true;
    ProtectKernelModules = true;
    ProtectKernelLogs = true;
    ProtectControlGroups = true;
    ProtectClock = true;
    ProtectHostname = true;
    ProtectProc = "invisible";
    PrivateTmp = true;
    RestrictRealtime = true;
    RestrictAddressFamilies = [
      "AF_UNIX"
      "AF_NETLINK"
      "AF_INET"
      "AF_INET6"
      "AF_PACKET"
    ];
    RestrictNamespaces = true;
    RestrictSUIDSGID = true;
    MemoryDenyWriteExecute = true;
    SystemCallFilter = [
      "~@mount"
      "~@module"
      "~@swap"
      "~@obsolete"
      "~@cpu-emulation"
      "ptrace"
    ];
    SystemCallArchitectures = "native";
    LockPersonality = true;
  };

  systemd.services.acpid.serviceConfig = {
    NoNewPrivileges = true;
    ProtectSystem = "strict";
    ProtectHome = true;
    ProtectHostname = true;
    ProtectKernelTunables = true;
    ProtectKernelModules = true;
    ProtectKernelLogs = true;
    ProtectControlGroups = true;
    ProtectProc = "invisible";
    PrivateTmp = true;
    PrivateNetwork = true;
    PrivateMounts = true;
    RestrictNamespaces = true;
    RestrictRealtime = true;
    RestrictSUIDSGID = true;
    RestrictAddressFamilies = [
      "~AF_INET6"
      "~AF_INET"
      "~AF_PACKET"
    ];
    MemoryDenyWriteExecute = true;
    LockPersonality = true;
    SystemCallFilter = [
      "~@mount"
      "~@swap"
      "~@obsolete"
      "~@cpu-emulation"
    ];
    SystemCallArchitectures = "native";
    CapabilityBoundingSet = [
      "~CAP_CHOWN"
      "~CAP_FSETID"
      "~CAP_SETFCAP"
    ];
  };

  systemd.services.dbus-broker.serviceConfig = {
    NoNewPrivileges = true;
    ProtectSystem = "strict";
    ProtectControlGroups = true;
    ProtectHome = true;
    ProtectHostname = true;
    ProtectKernelTunables = true;
    ProtectKernelModules = true;
    ProtectKernelLogs = true;
    PrivateMounts = true;
    PrivateDevices = true;
    PrivateTmp = true;
    RestrictSUIDSGID = true;
    RestrictRealtime = true;
    RestrictAddressFamilies = [
      "AF_UNIX"
    ];
    RestrictNamespaces = true;
    SystemCallErrorNumber = "EPERM";
    SystemCallArchitectures = "native";
    SystemCallFilter = [
      "~@obsolete"
      "~@resources"
      "~@debug"
      "~@mount"
      "~@reboot"
      "~@swap"
      "~@cpu-emulation"
    ];
    LockPersonality = true;
    IPAddressDeny = [
      "0.0.0.0/0"
      "::/0"
    ];
    MemoryDenyWriteExecute = true;
    DevicePolicy = "closed";
    UMask = 0077;
  };

  systemd.services.display-manager.serviceConfig = {
    ProtectSystem = "full";
    ProtectControlGroups = true;
    ProtectClock = true;
    ProtectKernelModules = true;
    PrivateMounts = true;
    PrivateIPC = true;
    RestrictSUIDSGID = true;
    RestrictRealtime = true;
    RestrictNamespaces = [
      "~cgroup"
    ];
    RestrictAddressFamilies = [
      "AF_UNIX"
      "AF_NETLINK"
      "AF_INET"
      "AF_INET6"
    ];
    SystemCallErrorNumber = "EPERM";
    SystemCallFilter = [
      "~@obsolete"
      "~@cpu-emulation"
      "~@clock"
      "~@swap"
      "~@module"
      "~@reboot"
      "~@raw-io"
      "~@debug"
    ];
    SystemCallArchitectures = "native";
    LockPersonality = true;
    IPAddressDeny = ["0.0.0.0/0" "::/0"];
    CapabilityBoundingSet = [
      "CAP_SYS_ADMIN"
      "CAP_SETUID"
      "CAP_SETGID"
      "CAP_SETPCAP"
      "CAP_KILL"
      "CAP_SYS_TTY_CONFIG"
      "CAP_DAC_OVERRIDE"
      "CAP_DAC_READ_SEARCH"
      "CAP_FOWNER"
      "CAP_IPC_OWNER"
      "CAP_FSETID"
      "CAP_SETFCAP"
      "CAP_CHOWN"
    ];
    DeviceAllow = "/dev/tty7 rw";
    DevicePolicy = "closed";
    UMask = 0077;
    LogLevelMax = "debug";
    KeyringMode = lib.mkForce "private";
  };

  systemd.services.sshd.serviceConfig = {
    NoNewPrivileges = true;
    ProtectSystem = "strict";
    ProtectHome = "read-only";
    ProtectClock = true;
    ProtectHostname = true;
    ProtectKernelTunables = true;
    ProtectKernelModules = true;
    ProtectKernelLogs = true;
    ProtectControlGroups = true;
    ProtectProc = "invisible";
    PrivateTmp = true;
    PrivateMounts = true;
    PrivateDevices = true;
    RestrictNamespaces = true;
    RestrictRealtime = true;
    RestrictSUIDSGID = true;
    MemoryDenyWriteExecute = true;
    LockPersonality = true;
    DevicePolicy = "closed";
    SystemCallFilter = [
      "~@keyring"
      "~@swap"
      "~@clock"
      "~@module"
      "~@obsolete"
      "~@cpu-emulation"
    ];
    SystemCallArchitectures = "native";
  };
  systemd.services.nix-daemon.serviceConfig = {
    NoNewPrivileges = true;
    ProtectControlGroups = true;
    ProtectKernelModules = true;
    PrivateMounts = true;
    PrivateTmp = true;
    PrivateDevices = true;
    RestrictSUIDSGID = true;
    RestrictRealtime = true;
    RestrictNamespaces = ["~cgroup"];
    RestrictAddressFamilies = [
      "AF_UNIX"
      "AF_NETLINK"
      "AF_INET6"
      "AF_INET"
    ];
    CapabilityBoundingSet = [
      "~CAP_SYS_CHROOT"
      "~CAP_BPF"
      "~CAP_AUDIT_WRITE"
      "~CAP_AUDIT_CONTROL"
      "~CAP_AUDIT_READ"
      "~CAP_SYS_PTRACE"
      "~CAP_SYS_NICE"
      "~CAP_SYS_RESOURCE"
      "~CAP_SYS_RAWIO"
      "~CAP_SYS_TIME"
      "~CAP_SYS_PACCT"
      "~CAP_LINUX_IMMUTABLE"
      "~CAP_IPC_LOCK"
      "~CAP_WAKE_ALARM"
      "~CAP_SYS_TTY_CONFIG"
      "~CAP_SYS_BOOT"
      "~CAP_LEASE"
      "~CAP_BLOCK_SUSPEND"
      "~CAP_MAC_ADMIN"
      "~CAP_MAC_OVERRIDE"
    ];
    SystemCallErrorNumber = "EPERM";
    SystemCallArchitectures = "native";
    SystemCallFilter = [
      "~@resources"
      "~@module"
      "~@obsolete"
      "~@debug"
      "~@reboot"
      "~@swap"
      "~@cpu-emulation"
      "~@clock"
      "~@raw-io"
    ];
    LockPersonality = true;
    MemoryDenyWriteExecute = true;
    DevicePolicy = "closed";
    UMask = 0077;
  };

  boot.kernelParams = ["audit=1"];
  security.auditd.enable = true;
  security.audit.enable = true;
  security.audit.rules = [
    # Log all program executions on 64-bit architecture
    "-a exit,always -F arch=b64 -S execve"
  ];
}
