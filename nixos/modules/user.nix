{ config, pkgs, ... }:

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
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.pudding = { pkgs, ... }: {
    # Import modular Home Manager sub-configs
    imports = [
      ./neovim.nix
    ];

    home.stateVersion = "24.11";

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs # Wayland screen capture
        obs-vaapi # Hardware acceleration
        obs-vkcapture # Game capture for Vulkan/OpenGL
      ];
    };

    home.packages = with pkgs; [
      # CLI Utilities
      lsd
      fzf
      zoxide
      starship
    ];

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

      history.size = 10000;

      shellAliases = {
        cd = "z";
        ls = "lsd --depth 1 --tree";
      };

      oh-my-zsh = {
        enable = true;
        theme = "";
        plugins = [
          "git"
          "sudo"
          "rbenv"
          "ruby"
          "pip"
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
        # Keybindings
        bindkey "\e[1~" beginning-of-line
        bindkey "\e[4~" end-of-line
        bindkey '^[[3~' delete-char
        bindkey '^[[1;2D' backward-word
        bindkey '^[[1;2C' forward-word

        # Tool initializations
        eval "$(zoxide init zsh)"
        eval "$(fzf --zsh)"
        if command -v rbenv >/dev/null 2>&1; then eval "$(rbenv init -)"; fi
        if command -v pyenv >/dev/null 2>&1; then eval "$(pyenv init - zsh)"; fi

        # Completion Styles
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-Z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd $realpath'

        # User PATH additions
        export PATH="$HOME/.local/bin:$HOME/.local/bin/zig:$HOME/.dotnet/tools:$PATH"

        # Bun & Juliaup paths if installed locally
        export BUN_INSTALL="$HOME/.bun"
        [ -d "$BUN_INSTALL" ] && export PATH="$BUN_INSTALL/bin:$PATH"
        [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
        [ -d "$HOME/.juliaup/bin" ] && export PATH="$HOME/.juliaup/bin:$PATH"

        # Android SDK
        export ANDROID_HOME="$HOME/Android/Sdk"
        export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH"

        # Graceful Tmux Autostart Function
        autostart_tmux() {
            if command -v tmux >/dev/null 2>&1 && \
               [ -n "$PS1" ] && \
               [[ "$TERM" != screen* ]] && \
               [[ "$TERM" != tmux* ]] && \
               [ -z "$TMUX" ] && \
               [ "$TERM_PROGRAM" != "vscode" ] && \
               { [ -z "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ]; }; then

                if tmux has-session 2>/dev/null; then
                    echo "Attaching to existing tmux session..."
                    sleep 0.5
                    exec tmux attach-session
                else
                    echo "Starting new tmux session..."
                    sleep 0.5
                    exec tmux new-session -s "main" -n "terminal"
                fi
            fi
        }
        autostart_tmux
      '';
    };
  };
}
