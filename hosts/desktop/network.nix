{lib, ...}: {
  networking = {
    networkmanager.enable = true;
    #useNetworkd = true;
    #usePredictableInterfaceNames = lib.mkDefault true;

    #defaultGateway = {
    #  address = "192.168.1.1";
    #  interface = "enp11s0";
    #};
    #interfaces.enp11s0 = {
    #  useDHCP = false;
    #  ipv4.addresses = [
    #    {
    #      address = "192.168.1.2";
    #      prefixLength = 24;
    #    }
    #  ];
    #  ipv4.routes = [
    #    { address = "0.0.0.0"; via = "192.168.1.1"; prefixLength = 24; }
    #  ];
    #};

    nameservers = ["192.168.1.1" "9.9.9.11" "9.9.9.9"];

    firewall = {
      enable = true;
      allowedTCPPorts = [130];
      allowedUDPPortRanges = [
        {
          from = 50000;
          to = 65535;
        }
      ];
    };
  };
}
