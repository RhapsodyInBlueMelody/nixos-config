{ ... }:

{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/hardware.nix
    ./modules/network.nix
    ./modules/desktop.nix
    ./modules/packages.nix
    ./modules/security.nix
    ./modules/gaming.nix
    ./modules/user.nix
  ];
}
