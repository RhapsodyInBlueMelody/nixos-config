{ pkgs, ... }:

{

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "RhapsodyInBlueMelody";
        email = "syeddinulfaiz14@gmail.com";
      };
    };
  };

  environment.systemPackages = [
    # Utilities & CLI Tools
    pkgs.imagemagick
    pkgs.busybox
    pkgs.podman-compose
    pkgs.parted
    pkgs.unrar-wrapper
    pkgs.hdparm
    pkgs.smartmontools
    pkgs.p7zip
    pkgs.zip
    pkgs.pulseaudio
    pkgs.keymapper
    pkgs.wget
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

  fonts.packages = [
    pkgs.departure-mono
    pkgs.nerd-fonts.departure-mono
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
    pkgs.dejavu_fonts
    pkgs.source-sans-pro
    pkgs.corefonts
  ];
}
