{ pkgs, ... }:

{

  environment.systemPackages = [

    #CyberSecurity
    pkgs.nmap
    pkgs.wireshark
    pkgs.tcpdump
    pkgs.burpsuite
    pkgs.metasploit
    pkgs.aircrack-ng
    pkgs.hashcat
    pkgs.john
    pkgs.lynis
    pkgs.clamav

  ];

  networking.firewall = {
    enable = true;
    allowPing = false; # Drop ICMP ping requests
  };

  # 2. Mandatory Access Control
  security.apparmor.enable = true;

  # 3. Kernel Hardening parameters
  boot.kernel.sysctl = {
    # Restrict kernel pointer exposure to non-root users
    "kernel.kptr_restrict" = 2;
    # Block dmesg access for unprivileged users
    "kernel.dmesg_restrict" = 1;
  };

}
