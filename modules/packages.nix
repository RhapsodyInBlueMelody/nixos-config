{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Utilities & CLI Tools
    wget
    git
    tree
    bitwarden-cli
    fastfetch
    kitty
    ffmpeg-full      
    frei0r

    # Shell tools
    starship
    zoxide
    atuin
    lsd
    fzf
    cava

    # Media & Applications
    krita
    gimp
    inkscape
    vlc
    mpv
    yt-dlp
    vesktop
    onlyoffice-desktopeditors
    kdePackages.kdenlive


    # Gaming utilities
    mangohud
    protonup-qt
    lutris
    wineWow64Packages.stable
  ];

    fonts.packages = with pkgs; [
        departure-mono
        nerd-fonts.departure-mono
    ];
}
