{ config, pkgs, ... }:

{
  # Bootloader configuration
  boot.loader.systemd-boot.enable = false; # Disable systemd-boot

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot"; # Matches nvme0n1p2 mounted at /boot
  };

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;

    gfxmodeEfi = "1920x1080";

    # Point to the directory containing theme.txt and its assets
    theme = /home/pudding/.config/Grub/Kafka-Grub-Theme/Kafka;
  };

  # Time zone
  time.timeZone = "Asia/Jakarta";

  # State version
  system.stateVersion = "26.05";
}
