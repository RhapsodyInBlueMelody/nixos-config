{
  pkgs,
  lib,
  ...
}:

{

  # System-level user definition
  users.users.pudding = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  users.users.reza = {
    isNormalUser = true;
    description = "Reza";
    extraGroups = [
      "networkmanager"
      "audio"
      "video"
    ];
    packages = with pkgs; [
      zip
      unzip
      xarchiver
      ristretto
    ];
    # no "wheel" = no sudo
  };

  security.pam.services.lightdm.allowNullPassword = true;
  
  security.pam.services.xfce4-screensaver.allowNullPassword = true;

  # Enable Zsh at the system level
  programs.zsh.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true; # Fast caching for nix flakes!
  };

  # Home Manager configuration for 'pudding'
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  programs.obs-studio.enableVirtualCamera = true;

  # programs.firejail = {
  #   enable = true;
  #   wrappedBinaries = {
  #     packettracer = {
  #       executable = lib.getExe pkgs.ciscoPacketTracer9;
  #       desktop = "${pkgs.ciscoPacketTracer9}/share/applications/cisco-packet-tracer-9.desktop";
  #       extraArgs = [
  #         "--net=none"
  #         "--noprofile"
  #       ];
  #     };
  #   };
  # };

  home-manager.users.pudding = { pkgs, config, ... }: {
    # Import modular Home Manager sub-configs
    imports = [
      # ./neovim.nix
      ./helix.nix
    ];

    gtk = {
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

    programs.mangohud = {
      enable = true;

      settings = {
        # -- Size and Scaling --
        font_size = 16; # Default is 24. Drop this to 14-16 for a much smaller footprint.

        # -- Transparency --
        background_alpha = 0.2; # 0.0 is fully invisible, 1.0 is solid black.
        alpha = 0.8; # Makes the text itself slightly translucent.

        # -- Positioning & Layout --
        position = "top-left"; # Options: top-left, top-right, bottom-left, bottom-right.
        hud_compact = true; # Removes some padding to tighten up the box.

        # -- Optional: Stripping it down --
        # Uncomment the line below if you literally ONLY want an FPS number and nothing else
        # fps_only = true;
      };
    };

    home.stateVersion = "24.11";

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs # Wayland screen capture
        obs-vaapi # Hardware acceleration
        obs-vkcapture # Game capture for Vulkan/OpenGL
        droidcam-obs
        obs-pipewire-audio-capture
      ];
    };

    home.packages = [
      # CLI Utilities
      pkgs.yt-dlp
      pkgs.deno

      #Tools and Documentation
      pkgs.thunar
      pkgs.plantuml
      pkgs.zeal
      pkgs.qalculate-gtk
      pkgs.flameshot
      pkgs.obsidian
      pkgs.calibre
      pkgs.zotero
      pkgs.audacity
      pkgs.fritzing
      pkgs.thunderbird
      pkgs.librecad

      # Gaming utilities
      pkgs.dolphin-emu
      pkgs.protonup-qt
      pkgs.lutris
      pkgs.vesktop

      # Media & Applications
      pkgs.zathura
      pkgs.ristretto
      # pkgs.tor-browser
      pkgs.mpv
      # pkgs.vlc
      # pkgs.gimp
      # pkgs.inkscape

      # pkgs.telegram-desktop
      pkgs.libreoffice-qt
      pkgs.kdePackages.kdenlive
    ];

    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.9;
          decorations = "None";
        };

        font = {
          size = 8.0;
          normal.family = "DepartureMono Nerd Font";
        };

        cursor.style = {
          shape = "Underline";
        };

        terminal.shell = {
          program = "tmux";

          args = [
            "new-session"
            "-A"
            "-s"
            "main"
          ];
        };

        colors = {
          primary = {
            background = "#282828";
            foreground = "#D4BE98";
          };

          cursor = {
            cursor = "#D4BE98";
          };

          normal = {
            black = "#3C3836";
            red = "#EA6962";
            green = "#A9B665";
            yellow = "#D8A657";
            blue = "#7DAEA3";
            magenta = "#D3869B";
            cyan = "#89B482";
            white = "#D4BE98";
          };

          bright = {
            black = "#3C3836";
            red = "#EA6962";
            green = "#A9B665";
            yellow = "#D8A657";
            blue = "#7DAEA3";
            magenta = "#D3869B";
            cyan = "#89B482";
            white = "#D4BE98";
          };
        };
      };
    };

    # Native Atuin integration
    programs.atuin = {
      enable = true;
      enableZshIntegration = true;
      flags = [
        "--disable-ctrl-r"
      ];
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        add_newline = false;
        format = "$character";

        character = {
          success_symbol = "[❯](bold green) ";
          error_symbol = "[❯](bold red) ";
        };
      };
    };

    programs.tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
      mouse = true;
      baseIndex = 1;
      shortcut = "Space";
      keyMode = "vi";
      escapeTime = 0;
      historyLimit = 50000;

      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        {
          plugin = gruvbox;
          extraConfig = "set -g @tmux-gruvbox 'dark'";
        }
      ];

      extraConfig = ''
        set -as terminal-features ",*:RGB"
        set -g focus-events on

        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        bind -n M-H previous-window
        bind -n M-L next-window

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        # 'y' removed: the yank plugin handles it

        bind c new-window -c "#{pane_current_path}"
        bind '"' split-window -v -c "#{pane_current_path}"
        bind '%' split-window -h -c "#{pane_current_path}"

        # status bar (path + git branch)
        set -g status-position bottom
        set -g status-interval 2
        set -g status-left-length 80
        set -g status-right-length 80
        set -g status-left '#[bold]#S #[nobold]│ #(echo "#{pane_current_path}" | sed "s|^$HOME|~|") '
        set -g status-right '#(cd "#{pane_current_path}" && git branch --show-current 2>/dev/null) │ %H:%M '

        bind -r h select-pane -L
        bind -r j select-pane -D
        bind -r k select-pane -U
        bind -r l select-pane -R
      '';
    };

    # Zsh configuration
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        # eza
        ls = "eza --icons=always --git --group-directories-first";
        ll = "eza -lh --icons=always --git --group-directories-first";
        la = "eza -aH --icons=always --git";

        cd = "z";

        # bat
        cat = "bat --style=plain";
        preview = "bat --style=numbers,changes,header";

        # find, grep, df, ps
        find = "fd";
        grep = "rg";
        df = "duf";
        ps = "procs";

      };

      history.size = 10000;

      oh-my-zsh = {
        enable = true;
        theme = ""; # Keeps theme blank so Starship handles it cleanly
        plugins = [
          "git"
          "sudo"
          "podman"
          "python"
          "command-not-found"
        ];
      };

      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];

      initContent = ''
        # --- Custom FZF Shell Helpers ---
        # Interactively switch Git branches
        fbr() {
          local branch
          branch=$(git branch -a --format='%(refname:short)' | fzf --height 40% --layout=reverse --prompt="Git Branch > ")
          if [ -n "$branch" ]; then
            git checkout "$branch"
          fi
        }

        # Type 'zi' to fuzzy search & jump into any folder you've visited
        zi() {
          local dir
          dir=$(zoxide query -l | fzf --height 40% --layout=reverse --prompt="Jump to > ") && cd "$dir"
        }

        # Type 'fe' to fuzzy find any file with a live bat preview and open it in Helix
        fe() {
          local file
          file=$(fd --type f --hidden --follow --exclude .git | fzf --height 50% --layout=reverse --preview 'bat --style=numbers --color=always {}') && hx "$file"
        }

        # Zsh options
        setopt INC_APPEND_HISTORY
        setopt SHARE_HISTORY

        # Keybindings
        bindkey "\e[1~" beginning-of-line
        bindkey "\e[4~" end-of-line
        bindkey '^[[3~' delete-char
        bindkey '^[[1;2D' backward-word
        bindkey '^[[1;2C' forward-word

        # Tool initializations
        if command -v rbenv >/dev/null 2>&1; then eval "$(rbenv init -)"; fi
        if command -v pyenv >/dev/null 2>&1; then eval "$(pyenv init - zsh)"; fi

        # Completion Styles
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-Z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd $realpath'

        eval "$(zoxide init zsh --cmd cd)"

      '';
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

  };
}
