{ config, pkgs, ... }:

{
  # Nvidia Configuration
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true;
  };

  # Enable Hardware Acceleration APIs
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # VA-API translation layer for NVDEC
      libvdpau-va-gl      # VDPAU backend wrapper
    ];
  };

  # Custom Storage Mounts
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/fe107073-93f6-407f-b87f-c201af6ddfc6";
    fsType = "ext4";
    options = [ "defaults" "noatime" ];
  };
}

