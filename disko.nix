{
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/ata-WALRAM_512GB_AA000000000000002946";

      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          cryptroot = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd:1" "noatime" "space_cache=v2"];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["compress=zstd:1" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd:1" "noatime"];
                  };
                  "/var" = {
                    mountpoint = "/var";
                    mountOptions = ["noatime"];
                  };
                  "/log" = {
                    mountpoint = "/var/log";
                    mountOptions = ["noatime" "compress=no"];
                  };
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    mountOptions = ["nodatacow" "noatime"];
                    swap.swapfile.size = "40G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
