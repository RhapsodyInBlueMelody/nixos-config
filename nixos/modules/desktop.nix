{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager.lightdm = {
      enable = true;
      background = pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath;

      greeters.gtk = {
        enable = true;
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

    # Normal XFCE (xfwm4 + desktop icons) for the brother's session
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        i3status
        i3lock
        picom
        feh
        unclutter
        gruvbox-gtk-theme
        gruvbox-plus-icons
        lxappearance
        polybar
        xwinwrap
      ];
    };
  };

  # Your session: i3 only. The brother picks "Xfce Session" at the login screen.
  services.displayManager.defaultSession = "none+i3";

  services.flatpak.enable = true;
}
