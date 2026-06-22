{...}: {
  networking = {
    networkmanager.enable = false;
    useNetworkd = true;
    useDHCP = false;

    nameservers = [
      "192.168.1.1"
      "::1"
      "9.9.9.9"
      "9.9.9.11"
      "2620:fe::fe"
      "2620:fe::9"
    ];

    interfaces.enp11s0 = {
      wakeOnLan.enable = true;

      ipv4.addresses = [
        {
          address = "192.168.1.2";
          prefixLength = 24;
        }
      ];

      ipv4.routes = [
        {
          address = "0.0.0.0";
          prefixLength = 0;
          via = "192.168.1.1";
        }
      ];

      ipv6 = {
        addresses = [
          {
            address = "2a02:2698:7c2b:4cbe::2";
            prefixLength = 64;
          }
        ];
      };
    };

    defaultGateway = {
      address = "192.168.1.1";
      interface = "enp11s0";
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [130];
      allowedUDPPorts = [9];
      allowedUDPPortRanges = [
        {
          from = 50000;
          to = 65535;
        }
      ];
    };
  };
}
