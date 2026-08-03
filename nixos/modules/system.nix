{ config, pkgs, ... }:

{
  # Bootloader configuration
  boot.loader.systemd-boot.enable = false; # Disable systemd-boot

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Add your user to the libvirtd group
  users.users.pudding.extraGroups = [ "libvirtd" ];

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot"; # Matches nvme0n1p2 mounted at /boot
  };

  # Enable the modern nix command and Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.ollama = {
    enable = true;

    # ACCELERATION CONFIGURATION (Choose ONE based on your hardware):
    # For AMD GPUs:
    # acceleration = "rocm";

    # For Nvidia GPUs:
    package = pkgs.ollama-cuda;
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Maps 'docker' CLI commands directly to podman transparently
  };

  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers.open-webui = {
    image = "ghcr.io/open-webui/open-webui:main";
    environment = {
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
    };
    volumes = [
      "open-webui-data:/app/backend/data"
      "/home/pudding/Documents/Obsidian/FaizCan Curiosity/:/data/obsidian-vault:ro"
    ];
    extraOptions = [ "--network=host" ];
  };

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;

    gfxmodeEfi = "1366x768";

    # Point to the directory containing theme.txt and its assets
    theme = /home/pudding/.config/Grub/Kafka-Grub-Theme/Kafka;
  };

  # Time zone
  time.timeZone = "Asia/Jakarta";

  # State version
  system.stateVersion = "26.05";
}
