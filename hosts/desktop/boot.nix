{
  lib,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = [pkgs.sbctl];
  boot = {
    plymouth = {
      enable = true;
      extraConfig = ''
        ShowDelay=0
        DeviceTimeout=8
      '';
    };

    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = lib.mkForce false;

    loader.limine = {
      enable = true;
      efiSupport = true;
      secureBoot.enable = true;
      maxGenerations = 10;
      enableEditor = false;
      panicOnChecksumMismatch = true;

      style = {
        wallpapers = [../../static/wallpaper.jpg];
        wallpaperStyle = "stretched";
        backdrop = "3c3836";

        interface = {
          branding = "kaeeraa desktop";
          brandingColor = "6";
          helpHidden = false;
          resolution = null;
        };

        graphicalTerminal = {
          palette = "282828;cc241d;98971a;d79921;458588;b16286;689d6a;ebdbb2";

          brightPalette = "928374;fb4934;b8bb26;fabd2f;83a598;d3869b;8ec07c;f9f5d7";

          foreground = "ebdbb2";
          background = "282828";
          brightForeground = "f9f5d7";
          brightBackground = "1d1d1d";

          font = {
            scale = null;
            spacing = null;
          };

          margin = null;
          marginGradient = null;
        };
      };
    };

    extraModprobeConfig = ''
       # firewire and thunderbolt
      install firewire-core /bin/false
      install firewire_core /bin/false
      install firewire-ohci /bin/false
      install firewire_ohci /bin/false
      install firewire_sbp2 /bin/false
      install firewire-sbp2 /bin/false
      install firewire-net /bin/false
      install thunderbolt /bin/false
      install ohci1394 /bin/false
      install sbp2 /bin/false
      install dv1394 /bin/false
      install raw1394 /bin/false
      install video1394 /bin/false
    '';

    kernelPackages = pkgs.linuxPackages_zen;
    blacklistedKernelModules = [
      # Obscure networking protocols
      "dccp" # Datagram Congestion Control Protocol
      "sctp" # Stream Control Transmission Protocol
      "rds" # Reliable Datagram Sockets
      "tipc" # Transparent Inter-Process Communication
      "n-hdlc" # High-level Data Link Control
      "ax25" # Amateur X.25
      "netrom" # NetRom
      "x25" # X.25
      "rose"
      "decnet"
      "econet"
      "af_802154" # IEEE 802.15.4
      "ipx" # Internetwork Packet Exchange
      "appletalk"
      "psnap" # SubnetworkAccess Protocol
      "p8023" # Novell raw IEE 802.3
      "p8022" # IEE 802.3
      "can" # Controller Area Network
      "atm"
      # Various rare filesystems
      "cramfs"
      "freevxfs"
      "jffs2"
      "hfs"
      "hfsplus"
      "udf"

      "squashfs" # compressed read-only file system used for Live CDs
      "cifs" # cmb (Common Internet File System)
      "nfs" # Network File System
      "nfsv3"
      "nfsv4"
      "ksmbd" # SMB3 Kernel Server
      "gfs2" # Global File System 2
      # vivid driver is only useful for testing purposes and has been the
      # cause of privilege escalation vulnerabilities
      "vivid"
    ];
    kernelParams = [
      "usbcore.quirks=5566:0008:gki"
      "vt.global_cursor_default=0"
      "quiet"
      "splash"
      "loglevel=3"
      "nvidia-drm.modeset=1"
      "nvidia.NVreg_TemporaryFilePath=/var/tmp"
      # make it harder to influence slab cache layout
      "slab_nomerge"
      # enables zeroing of memory during allocation and free time
      # helps mitigate use-after-free vulnerabilaties
      "init_on_alloc=1"
      "init_on_free=1"
      # randomizes page allocator freelist, improving security by
      # making page allocations less predictable
      "page_alloc.shuffel=1"
      # enables Kernel Page Table Isolation, which mitigates Meltdown and
      # prevents some KASLR bypasses
      "pti=on"
      # randomizes the kernel stack offset on each syscall
      # making attacks that rely on a deterministic stack layout difficult
      "randomize_kstack_offset=on"
      # disables vsyscalls, they've been replaced with vDSO
      "vsyscall=none"
      # disables debugfs, which exposes sensitive info about the kernel
      "debugfs=off"
      # certain exploits cause an "oops", this makes the kernel panic if an "oops" occurs
      "oops=panic"
      # only alows kernel modules that have been signed with a valid key to be loaded
      # making it harder to load malicious kernel modules
      # can make VirtualBox or Nvidia drivers unusable
      "module.sig_enforce=1"
      # prevents user space code excalation
      "lockdown=confidentiality"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    kernelModules = [
      "kvm-amd"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "sdhci_pci"];
      kernelModules = ["kvm-amd"];
    };

    kernel.sysctl = {
      "fs.suid_dumpable" = 0;
      # prevent pointer leaks
      "kernel.kptr_restrict" = 2;
      # restrict kernel log to CAP_SYSLOG capability
      "kernel.dmesg_restrict" = 1;
      # Note: certian container runtimes or browser sandboxes might rely on the following
      # restrict eBPF to the CAP_BPF capability
      "kernel.unprivileged_bpf_disabled" = 1;
      # should be enabled along with bpf above
      # "net.core.bpf_jit_harden" = 2;
      # restrict loading TTY line disciplines to the CAP_SYS_MODULE
      "dev.tty.ldisk_autoload" = 0;
      # prevent exploit of use-after-free flaws
      "vm.unprivileged_userfaultfd" = 0;
      # kexec is used to boot another kernel during runtime and can be abused
      "kernel.kexec_load_disabled" = 1;
      # Kernel self-protection
      # SysRq exposes a lot of potentially dangerous debugging functionality to unprivileged users
      # 4 makes it so a user can only use the secure attention key. A value of 0 would disable completely
      "kernel.sysrq" = 4;
      # disable unprivileged user namespaces, Note: Docker, NH, and other apps may need this
      # "kernel.unprivileged_userns_clone" = 0; # Set to 1 because it makes NH and other programs fail
      # This should be set to 0 if you don't rely on flatpak, NH, Docker, etc.
      "kernel.unprivileged_userns_clone" = 1;
      # restrict all usage of performance events to the CAP_PERFMON capability
      "kernel.perf_event_paranoid" = 3;

      # Network
      # protect against SYN flood attacks (denial of service attack)
      "net.ipv4.tcp_syncookies" = 1;
      # protection against TIME-WAIT assassination
      "net.ipv4.tcp_rfc1337" = 1;
      # enable source validation of packets received (prevents IP spoofing)
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;

      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      # Protect against IP spoofing
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;

      # prevent man-in-the-middle attacks
      "net.ipv4.icmp_echo_ignore_all" = 1;

      # ignore ICMP request, helps avoid Smurf attacks
      "net.ipv4.conf.all.forwarding" = 0;
      "net.ipv4.conf.default.accept_source_route" = 0;
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.default.accept_source_route" = 0;
      # Reverse path filtering causes the kernel to do source validation of
      "net.ipv6.conf.all.forwarding" = 0;
      "net.ipv6.conf.all.accept_ra" = 0;
      "net.ipv6.conf.default.accept_ra" = 0;

      ## TCP hardening
      # Prevent bogus ICMP errors from filling up logs.
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

      # Userspace
      # restrict usage of ptrace
      "kernel.yama.ptrace_scope" = 2;

      # ASLR memory protection (64-bit systems)
      "vm.mmap_rnd_bits" = 32;
      "vm.mmap_rnd_compat_bits" = 16;

      # only permit symlinks to be followed when outside of a world-writable sticky directory
      "fs.protected_symlinks" = 1;
      "fs.protected_hardlinks" = 1;
      # Prevent creating files in potentially attacker-controlled environments
      "fs.protected_fifos" = 2;
      "fs.protected_regular" = 2;

      # Randomize memory
      "kernel.randomize_va_space" = 2;
      # Exec Shield (Stack protection)
      "kernel.exec-shield" = 1;

      ## TCP optimization
      # TCP Fast Open is a TCP extension that reduces network latency by packing
      # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
      # both incoming and outgoing connections:
      "net.ipv4.tcp_fastopen" = 3;
      # Bufferbloat mitigations + slight improvement in throughput & latency
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";
    };
  };

  hardware.enableRedistributableFirmware = true;
}
