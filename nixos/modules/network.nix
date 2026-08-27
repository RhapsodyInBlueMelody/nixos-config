{ ... }:

{
  networking = {
    hostName = "pudding";
    networkmanager.enable = true;
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
    ];
  };

  # Enable systemd-resolved with Strict DNS-over-TLS
  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
  };

}
