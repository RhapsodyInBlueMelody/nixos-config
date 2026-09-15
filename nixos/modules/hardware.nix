{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  # Nvidia Configuration
  services.xserver.videoDrivers = [ "nvidia" ];
  services.input-remapper.enable = true;

  systemd.services.input-remapper = {
    wantedBy = [ "multi-user.target" ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # Correct for Turing GTX 1650
    package = config.boot.kernelPackages.nvidiaPackages.stable; # "latest" can occasionally introduce regression stutters in Proton

    # Fix GPU clock dropping mid-game
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Ensure dynamic power management isn't throttling performance
    dynamicBoost.enable = false;
  };

  hardware.uinput.enable = true;

  # Enable Hardware Acceleration APIs
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # VA-API translation layer for NVDEC
      libvdpau-va-gl # VDPAU backend wrapper
    ];
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 180; # Recommended for ZRAM to handle peak memory spikes smoothly
    "vm.max_map_count" = 2147483642; # CRITICAL for modern games/Proton to prevent memory allocation hitches
  };

  # Custom Storage Mounts
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/fe107073-93f6-407f-b87f-c201af6ddfc6";
    fsType = "ext4";
    options = [
      "defaults"
      "noatime"
    ];
  };

  # fileSystems."/mnt/games" = {
  #   device = "/dev/disk/by-uuid/85a59a2c-d245-49d4-ba01-b7fe7f0cbac6";
  #   fsType = "ext4";
  #   options = [
  #     "defaults"
  #     "noatime"
  #   ];
  # };
}
