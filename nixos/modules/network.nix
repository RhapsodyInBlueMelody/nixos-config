{ ... }:

{
  networking = {
    hostName = "pudding";
    networkmanager.enable = true;
    # Appending #hostname provides the SNI required for strict TLS certificate validation
    nameservers = [
      "1.1.1.2#security.cloudflare-dns.com"
      "1.0.0.2#security.cloudflare-dns.com"
      "2606:4700:4700::1112#security.cloudflare-dns.com"
      "2606:4700:4700::1002#security.cloudflare-dns.com"
    ];
  };

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNSSEC = "allow-downgrade"; # Prevents connection drops when filtering alters signatures
        DNSOverTLS = "true";        # Enforces strict TLS encryption now that SNI is provided
      };
    };
  };
}
