{ pkgs, ... }:

{

  environment.systemPackages = [
    # Utilities & CLI Tools
    pkgs.p7zip
    pkgs.zip
    pkgs.pulseaudio
    pkgs.keymapper
    pkgs.wget
    pkgs.git
    pkgs.bat
    pkgs.fd
    pkgs.eza
    pkgs.ripgrep
    pkgs.gh
    pkgs.dig
    pkgs.neo-cowsay
    pkgs.tree
    pkgs.bitwarden-cli
    pkgs.fastfetch
    pkgs.ffmpeg-full
    pkgs.frei0r
    pkgs.btop
    pkgs.atop
    pkgs.htop
    pkgs.psmisc
    pkgs.jan
    pkgs.oterm
    pkgs.jq
    pkgs.cava
    pkgs.duf
    pkgs.procs
    pkgs.tldr
  ];

  fonts.packages = with pkgs; [
    departure-mono
    nerd-fonts.departure-mono
    noto-fonts
    noto-fonts-color-emoji
    dejavu_fonts
    source-sans-pro
  ];
}
