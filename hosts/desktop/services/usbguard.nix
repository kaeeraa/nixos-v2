{...}: {
  services.usbguard = {
    enable = true;
    IPCAllowedUsers = ["root" "kaeeraa"];
    # presentDevicePolicy refers to how to treat USB devices that are already connected when the daemon starts
    presentDevicePolicy = "block";

    rules = ''
      allow with-interface 09:*:*
      allow with-interface 08:*:*
      allow with-interface 03:*:*

      reject all
    '';
  };
}
