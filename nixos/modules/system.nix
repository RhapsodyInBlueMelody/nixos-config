{ config, pkgs, ... }:

{
  # Bootloader configuration
  boot.loader.systemd-boot.enable = false; # Disable systemd-boot
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];

  boot.extraModprobeConfig = ''
  options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
'';

  # virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;
  
  # # Add your user to the libvirtd group
  # users.users.pudding.extraGroups = [ "libvirtd" ];

  services.journald.extraConfig = ''
    SystemMaxUse=100M
  '';

  # Ensure proprietary firmware (Intel/Realtek/Broadcom) is loaded
  hardware.enableRedistributableFirmware = true;

  # Enable Bluetooth stack
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ]; # Matches all keyboards, including your Ajazz AK820
        settings = {
          main = {
            volumedown = "scrolldown";
            volumeup = "scrollup";
          };
        };
      };

      rexus_mouse = {
        ids = [ "05ac:024f" ]; # Matches your Rexus Clif Mouse from journalctl logs
        settings = {
          main = {
            mouse1 = "leftmouse"; # Maps side button 1 (back) to Left Click
            mouse2 = "leftmouse"; # Maps side button 2 (forward) to Left Click
          };
        };
      };
    };
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot"; # Matches nvme0n1p2 mounted at /boot
  };

  # Enable the modern nix command and Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # services.ollama = {
  #   enable = true;

  #   # ACCELERATION CONFIGURATION (Choose ONE based on your hardware):
  #   # For AMD GPUs:
  #   # acceleration = "rocm";

  #   # For Nvidia GPUs:
  #   package = pkgs.ollama-cuda;
  # };

  # systemd.services.ollama.environment = {
  #   OLLAMA_MAX_LOADED_MODELS = "1";
  # };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Maps 'docker' CLI commands directly to podman transparently
  };

  virtualisation.oci-containers.backend = "podman";

  # virtualisation.oci-containers.containers.open-webui = {
  #   image = "ghcr.io/open-webui/open-webui:main";
  #   environment = {
  #     OLLAMA_BASE_URL = "http://127.0.0.1:11434";
  #   };
  #   volumes = [
  #     "open-webui-data:/app/backend/data"
  #     "/home/pudding/Documents/Obsidian/FaizCan Curiosity/:/data/obsidian-vault:ro"
  #   ];
  #   extraOptions = [ "--network=host" ];
  # };

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
