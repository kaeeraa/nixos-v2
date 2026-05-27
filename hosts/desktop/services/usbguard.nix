{...}: {
  services.usbguard = {
    enable = true;
    IPCAllowedUsers = ["root" "kaeeraa"];
    presentDevicePolicy = "allow";

    rules = ''
      allow id 1d6b:0002 serial "0000:0d:00.0" name "xHCI Host Controller" hash "4JN/q7j8G1v5ObPqMaeG524CpKYR/flBUJppBD9zoks=" parent-hash "JktIQZT5h1WVA1ImPk935Rb9WMBU64TkPvxYIUIj2eA=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0003 serial "0000:0d:00.0" name "xHCI Host Controller" hash "zQtx6bk+Pe8IDQ9L8L4F7ZbEQRXXEVagGlvtWF+PxMg=" parent-hash "JktIQZT5h1WVA1ImPk935Rb9WMBU64TkPvxYIUIj2eA=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0002 serial "0000:0f:00.3" name "xHCI Host Controller" hash "FGuVbl7eGM2kGxiOo6leosLNLxYDVZ3qmzymndTLoEQ=" parent-hash "iKZiEHprWkcpBTjILdVwipzKnlBDuEheM7ArHM/JBho=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0003 serial "0000:0f:00.3" name "xHCI Host Controller" hash "ssMo3rQndF+eEePv7sjoqhKfHzWPnE+23qPQ9DWd8eM=" parent-hash "iKZiEHprWkcpBTjILdVwipzKnlBDuEheM7ArHM/JBho=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0002 serial "0000:0f:00.4" name "xHCI Host Controller" hash "5Ab7xmb4dhkTvl5F82TpmJ/SjPC0gQJE3U3C1N9NBgM=" parent-hash "J+DjjcWsq8SFCYi2ozFe0RL6inygRgy3wSKCSD6JTho=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0003 serial "0000:0f:00.4" name "xHCI Host Controller" hash "s5hhpEW8IUpVDYpKAPgHbnO7q4WWwqIBsq+z5bJOXvI=" parent-hash "J+DjjcWsq8SFCYi2ozFe0RL6inygRgy3wSKCSD6JTho=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0002 serial "0000:10:00.0" name "xHCI Host Controller" hash "wvrAhzCU9e70sT6fMM0V67MGfVyJgKNsoZg+d7A5Lgs=" parent-hash "yaVwLccQ5hxfN23fjutFy8+xV6cK4W3B7hfJ5Skrr9o=" with-interface 09:00:00 with-connect-type ""
      allow id 174c:2074 serial "" name "ASM107x" hash "3diggCc+UIkz1I9skI/9PxceyT0kr5r7GL5FqNeqFZg=" parent-hash "4JN/q7j8G1v5ObPqMaeG524CpKYR/flBUJppBD9zoks=" via-port "1-5" with-interface { 09:00:01 09:00:02 } with-connect-type "not used"
      allow id 0db0:0076 serial "7E2624102205" name "MYSTIC LIGHT " hash "d0Bs8cRYYwqJIj7UthRfPNzzrEJyKe5XFNpWlNgHmK0=" parent-hash "4JN/q7j8G1v5ObPqMaeG524CpKYR/flBUJppBD9zoks=" with-interface 03:00:00 with-connect-type "not used"
      allow id 0e8d:0616 serial "000000000" name "Wireless_Device" hash "eM73IFKY9T4ydP+CKuo6KEp/Fhrl72VFzccohhOSiRg=" parent-hash "4JN/q7j8G1v5ObPqMaeG524CpKYR/flBUJppBD9zoks=" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "not used"
      allow id 174c:3074 serial "" name "ASM107x" hash "u+NgVC10sqnPD0Rf2fZCa9joVQ4VZhizQq2ArhktmFg=" parent-hash "zQtx6bk+Pe8IDQ9L8L4F7ZbEQRXXEVagGlvtWF+PxMg=" via-port "2-5" with-interface 09:00:00 with-connect-type "not used"
      allow id 09da:9090 serial "" name "USB Device" hash "pDJbRUao7Yipt00nn5kQI5o1Uoo1kVE+8pkLhBfsGw4=" parent-hash "3diggCc+UIkz1I9skI/9PxceyT0kr5r7GL5FqNeqFZg=" via-port "1-5.2" with-interface { 03:01:01 03:01:02 } with-connect-type "unknown"
      allow id 04d9:1203 serial "" name "" hash "SYKKpWCTQYSIfF4sI0u0kIk3tQRpY6P7c7P9SsSbcjg=" parent-hash "3diggCc+UIkz1I9skI/9PxceyT0kr5r7GL5FqNeqFZg=" via-port "1-5.3" with-interface { 03:01:01 03:00:00 } with-connect-type "unknown"
      reject
    '';
  };
}
