{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # programs.gamescope = {
  #   enable = true;
  #   capSysNice = true;
  # };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  services.earlyoom.enable = true;
}
