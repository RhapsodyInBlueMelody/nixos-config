{ config, pkgs, ... }:

{
  networking.hostName = "pudding";
  networking.networkmanager.enable = true;
}
