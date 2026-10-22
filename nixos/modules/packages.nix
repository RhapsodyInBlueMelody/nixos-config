{
  pkgs,
  config,
  lib,
  ...
}:

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

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  environment.systemPackages = [
    # Utilities & CLI Tools
    pkgs.hwinfo
    pkgs.lshw
    pkgs.imagemagick
    pkgs.podman-compose
    pkgs.parted
    pkgs.transmission_4-qt
    pkgs.ff2mpv
    pkgs.librewolf
    pkgs.cmus
    pkgs.unrar-wrapper
    pkgs.p7zip
    pkgs.zip
    pkgs.wget
    pkgs.bat
    pkgs.fd
    pkgs.eza
    pkgs.ripgrep
    pkgs.gh
    pkgs.git-filter-repo
    pkgs.dig
    pkgs.tree
    pkgs.bitwarden-cli
    pkgs.fastfetch
    pkgs.ffmpeg
    pkgs.frei0r
    pkgs.unzip
    pkgs.btop
    pkgs.psmisc
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
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.ubuntu
    pkgs.nerd-fonts.roboto-mono
    pkgs.nerd-fonts.noto
    pkgs.nerd-fonts._3270
    pkgs.noto-fonts-color-emoji
    pkgs.dejavu_fonts
    pkgs.source-sans-pro
    pkgs.vista-fonts
    pkgs.liberation_ttf
    pkgs.carlito
    pkgs.caladea
    pkgs.noto-fonts-cjk-sans
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.mplus-outline-fonts.githubRelease
    pkgs.dina-font
    pkgs.proggyfonts
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Liberation Sans" ];
      monospace = [ "Liberation Mono" ];
    };
    localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <alias binding="same">
          <family>Times New Roman</family>
          <prefer>
            <family>Liberation Serif</family>
          </prefer>
        </alias>
      </fontconfig>
    '';
  };
}
