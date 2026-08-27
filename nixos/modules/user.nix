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

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      packettracer = {
        executable = lib.getExe pkgs.ciscoPacketTracer9;
        desktop = "${pkgs.ciscoPacketTracer9}/share/applications/cisco-packet-tracer-9.desktop";
        extraArgs = [
          "--net=none"
          "--noprofile"
        ];
      };
    };
  };

  home-manager.users.pudding = { pkgs, ... }: {
    # Import modular Home Manager sub-configs
    imports = [
      # ./neovim.nix
      ./helix.nix
    ];

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
      ];
    };

    programs.firefox = {
      enable = true;
    };

    home.packages = [
      # CLI Utilities
      pkgs.yt-dlp
      pkgs.ytfzf
      pkgs.ani-cli
      pkgs.newsboat

      #Tools and Documentation
      pkgs.thunar
      pkgs.zeal
      pkgs.qalculate-gtk
      pkgs.flameshot
      pkgs.obsidian

      # Gaming utilities
      pkgs.dolphin-emu
      pkgs.protonup-qt
      pkgs.legcord
      pkgs.lutris

      # Media & Applications

      pkgs.zathura
      pkgs.ristretto
      pkgs.strawberry
      pkgs.audacity
      pkgs.tor-browser
      pkgs.gimp
      pkgs.inkscape
      pkgs.mpv

      pkgs.onlyoffice-desktopeditors
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
    };

    # Native Starship Configuration
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      # Embed your exact TOML settings here:
      settings = {
        add_newline = false;
        command_timeout = 1000;

        # Using explicit \n to safely pass Starship variable strings to Nix
        format = ''

          $username$hostname$directory($git_branch$git_status$git_state) $python$fill$status$jobs$cmd_duration$time
          $character'';
        package.disabled = true;

        character = {
          success_symbol = "[❯](bold green) ";
          error_symbol = "[❯](bold red) ";
        };

        fill = {
          symbol = " ";
          style = "none";
        };

        time = {
          disabled = false;
          format = "[$time]($style)";
          style = "8";
        };

        directory = {
          truncate_to_repo = false;
          read_only = " !w";
          format = "[$read_only]($read_only_style)[ $path ]($style)";
          style = "bg:blue fg:#282828 bold";
          read_only_style = "bg:blue fg:#282828";
          truncation_length = 10;
        };

        git_branch = {
          style = "bg:green fg:black ";
          format = "[ $branch ]($style)";
        };

        git_status = {
          conflicted = "!$count";
          ahead = "^$count";
          behind = "v$count";
          diverged = "^$ahead_count v$behind_count";
          up_to_date = "";
          untracked = " ?$count";
          stashed = " *$count";
          modified = " [~$count](bold yellow)";
          staged = " [+$count](green bold)";
          renamed = " =$count";
          deleted = " [-$count](red)";
          format = "[(| $ahead_behind )](bg:green black)[( $conflicted )](bg:red fg:black bold)[$staged$modified$renamed$deleted]($style)[$stashed$untracked](8)";
          style = "yellow";
        };

        cmd_duration = {
          format = "[$duration ](bold yellow)";
        };

        python = {
          symbol = "py ";
          style = "blue";
          version_format = "v\${major}.\${minor}";
          python_binary = [
            "python3"
            "python"
          ];
        };

        nodejs = {
          symbol = "node ";
          style = "green";
          version_format = "v\${major}";
        };

        status = {
          symbol = "E";
          disabled = false;
        };

        jobs = {
          symbol = "*";
          number_threshold = 2;
        };

        username = {
          style_user = "dimmed";
          style_root = "red bold";
          format = "[$user]($style)";
        };

        hostname = {
          style = "dimmed green";
          format = "[@](dimmed)[$hostname]($style) ";
        };
      };
    };

    # Native Tmux configuration
    programs.tmux = {
      enable = true;

      # Core options
      shell = "${pkgs.zsh}/bin/zsh";
      mouse = true;
      baseIndex = 1;
      shortcut = "Space"; # Automatically unbinds C-b and binds C-Space
      keyMode = "vi"; # Automatically sets mode-keys vi

      # Nix-managed plugins
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        yank
        {
          plugin = gruvbox;
          extraConfig = "set -g @tmux-gruvbox 'dark'";
        }
      ];

      # Raw config for bindings and overrides
      extraConfig = ''
        set-option -sa terminal-overrides ",xterm*:Tc"

        # Pane Indexing & Renumbering
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        # Alt-H / Alt-L window navigation
        bind -n M-H previous-window
        bind -n M-L next-window

        # Copy mode vi bindings
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # Split panes retaining current directory path
        bind '"' split-window -v -c "#{pane_current_path}"
        bind '%' split-window -h -c "#{pane_current_path}"
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

        # bat
        cat = "bat --style=plain";
        preview = "bat --style=numbers,changes,header";

        # find, grep, df, ps
        find = "fd";
        grep = "rg";
        df = "duf";
        ps = "procs";
      };

      setOptions = [
        "INC_APPEND_HISTORY" # Write to history file immediately, not on shell exit
        "SHARE_HISTORY" # Share history across all active zsh terminals
      ];

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

      # Changed from initContent to initExtra so Home Manager actually reads it!
      initExtra = ''
        # Keybindings
        bindkey "\e[1~" beginning-of-line
        bindkey "\e[4~" end-of-line
        bindkey '^[[3~' delete-char
        bindkey '^[[1;2D' backward-word
        bindkey '^[[1;2C' forward-word

        # Tool initializations (Zoxide & FZF are handled natively below)
        if command -v rbenv >/dev/null 2>&1; then eval "$(rbenv init -)"; fi
        if command -v pyenv >/dev/null 2>&1; then eval "$(pyenv init - zsh)"; fi

        # Completion Styles
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-Z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd $realpath'

        # Graceful Tmux Autostart Function
        autostart_tmux() {
        }
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
