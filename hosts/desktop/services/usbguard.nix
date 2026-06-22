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
      allow id 174c:2074 serial "" name "ASM107x" hash "3diggCc+UIkz1I9skI/9PxceyT0kr5r7GL5FqNeqFZg=" parent-hash "4JN/q7j8G1v5ObPqMaeG524CpKYR/flBUJppBD9zoks=" with-interface { 09:00:01 09:00:02 } with-connect-type "not used"
      allow id 0db0:0076 serial "7E2624102205" name "MYSTIC LIGHT " hash "d0Bs8cRYYwqJIj7UthRfPNzzrEJyKe5XFNpWlNgHmK0=" parent-hash "4JN/q7j8G1v5ObPqMaeG524CpKYR/flBUJppBD9zoks=" with-interface 03:00:00 with-connect-type "not used"
      allow id 0e8d:0616 serial "000000000" name "Wireless_Device" hash "eM73IFKY9T4ydP+CKuo6KEp/Fhrl72VFzccohhOSiRg=" parent-hash "4JN/q7j8G1v5ObPqMaeG524CpKYR/flBUJppBD9zoks=" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "not used"
      allow id 174c:3074 serial "" name "ASM107x" hash "u+NgVC10sqnPD0Rf2fZCa9joVQ4VZhizQq2ArhktmFg=" parent-hash "zQtx6bk+Pe8IDQ9L8L4F7ZbEQRXXEVagGlvtWF+PxMg=" with-interface 09:00:00 with-connect-type "not used"
      allow id 09da:9090 serial "" name "USB Device" hash "pDJbRUao7Yipt00nn5kQI5o1Uoo1kVE+8pkLhBfsGw4=" parent-hash "3diggCc+UIkz1I9skI/9PxceyT0kr5r7GL5FqNeqFZg=" with-interface { 03:01:01 03:01:02 }
      allow id 04d9:1203 serial "" name "" hash "SYKKpWCTQYSIfF4sI0u0kIk3tQRpY6P7c7P9SsSbcjg=" parent-hash "3diggCc+UIkz1I9skI/9PxceyT0kr5r7GL5FqNeqFZg=" with-interface { 03:01:01 03:00:00 }
      allow id 1a86:7523 serial "" name "USB Serial" hash "Y4crZ93bH5ULGhbzur95S8NvmqO0Ir3Altz0ZLZ1dO4=" parent-hash "5Ab7xmb4dhkTvl5F82TpmJ/SjPC0gQJE3U3C1N9NBgM=" with-interface ff:01:02
      allow id 339b:107d serial "A4UF6R6312006326" name "AAK-AN00"
      allow id 18d1:d00d serial "" name "Android" hash "q+GXPUySAMpAVN6uMdQum+GYUUzLuSqxx6cr9xWx1Hw=" parent-hash "3diggCc+UIkz1I9skI/9PxceyT0kr5r7GL5FqNeqFZg=" via-port "1-5.2" with-interface ff:42:03
      allow id 0951:1665 serial "408D5CE4BBC5B471D98A5118" name "DataTraveler 2.0" hash "TcUSjbctmyXxYhSEKPgnF4YbnVKLIcxPzb84U9TPwdU=" parent-hash "FGuVbl7eGM2kGxiOo6leosLNLxYDVZ3qmzymndTLoEQ=" via-port "3-2" with-interface 08:06:50
      allow id 2d99:e055 serial "USBCompositeDevice" name "EDIFIER W830NB" hash "eTzQjmvGWueAODl3BEHiqYkXVrFZDKaBuSSmtemUV6c=" parent-hash "3diggCc+UIkz1I9skI/9PxceyT0kr5r7GL5FqNeqFZg=" via-port "1-5.2" with-interface { 01:01:00 01:02:00 01:02:00 01:02:00 01:02:00 01:02:00 01:02:00 03:00:00 } with-connect-type "unknown"
      reject
    '';
  };
}
