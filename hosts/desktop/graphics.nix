{config, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;

    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

    prime = {
      sync.enable = true;

      amdgpuBusId = "PCI:15:0:0";
      nvidiaBusId = "PCI:01:0:0";
    };
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
