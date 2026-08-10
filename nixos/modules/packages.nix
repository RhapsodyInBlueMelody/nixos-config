{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Utilities & CLI Tools
    zip
    pulseaudio
    keymapper
    wget
    git
    tree
    bitwarden-cli
    fastfetch
    ffmpeg-full
    frei0r
    qalculate-gtk
    flameshot
    btop
    psmisc
    obsidian
    jan
    oterm

    # Shell tools
    zoxide
    jq
    atuin
    lsd
    fzf
    cava

    # Media & Applications
    audacity
    tor-browser
    gimp
    inkscape
    mpv
    yt-dlp
    onlyoffice-desktopeditors
    kdePackages.kdenlive

    # Gaming utilities
    dolphin-emu
    mangohud
    protonup-qt
    lutris
  ];

  fonts.packages = with pkgs; [
    departure-mono
    nerd-fonts.departure-mono
  ];
}
