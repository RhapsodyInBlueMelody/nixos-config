{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    # LightDM Configuration (Correct NixOS xserver hierarchy)
    displayManager.lightdm = {
      enable = true;
      background = pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath;

      greeters.gtk = {
        enable = true;

        # Apply Gruvbox Theme directly to the login screen
        theme = {
          name = "Gruvbox-Dark";
          package = pkgs.gruvbox-gtk-theme;
        };
        iconTheme = {
          name = "Gruvbox-Plus-Dark";
          package = pkgs.gruvbox-plus-icons;
        };
      };
    };

    # 1. Configure Xfce purely as a Desktop Manager (no window manager or desktop icons)
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true; # Disables desktop icons managed by xfdesktop
        enableXfwm = false; # Disables Xfce's default window manager
      };
    };

    # 2. Let i3 handle all window management
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        i3status # Status bar for i3
        i3lock # Screen locker
        picom
        unclutter
        thunar
        gruvbox-gtk-theme
        gruvbox-plus-icons
        lxappearance
        strawberry
        ristretto
        zathura
        polybar
        xwinwrap
      ];
    };
  };

  # 3. Use LightDM as the login manager and set Xfce as default session
  services.displayManager.defaultSession = "xfce+i3";

  services.flatpak.enable = true;
}
