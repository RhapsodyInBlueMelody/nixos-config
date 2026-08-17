{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    # Utilities & CLI Tools
    p7zip
    zip
    pulseaudio
    keymapper
    wget
    git
    gh
    tree
    bitwarden-cli
    fastfetch
    ffmpeg-full
    frei0r
    btop
    psmisc
    jan
    oterm

    # Shell tools
    zoxide
    jq
    atuin
    lsd
    fzf
    cava

  ];

  fonts.packages = with pkgs; [
    departure-mono
    nerd-fonts.departure-mono
  ];
}
