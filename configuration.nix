{ config, lib, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/hardware.nix
    ./modules/network.nix
    ./modules/desktop.nix
    ./modules/packages.nix
    ./modules/gaming.nix
    ./modules/user.nix
  ];
}
