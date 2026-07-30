{ config, pkgs, ... }:

{
  # System-level user definition
  users.users.pudding = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Enable Zsh at the system level
  programs.zsh.enable = true;

  # Home Manager configuration for 'pudding'
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.pudding = { pkgs, ... }: {
    home.stateVersion = "24.11"; # Match your NixOS release

        programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs                 # Wayland screen capture (if needed)
        obs-vaapi              # Hardware acceleration
        obs-vkcapture          # Game capture for Vulkan/OpenGL
      ];
    };

    # Packages required for your plugins/tools (lsd, fzf, zoxide, p10k)
    home.packages = with pkgs; [

      #Nix
      nil
      nixfmt

      #Web Development
      typescript-language-server # ts_ls
      vscode-langservers-extracted # html, cssls, jsonls, eslint
      tailwindcss-language-server

      # Other Languages
      pyright # Python
      ruff    # Python Linter + Formatter
      clang-tools # clangd (C/C++)
      intelephense # PHP
      lua-language-server # lua_ls
      rust-analyzer # Rust

      # System Compiler & Runtimes
      nodejs_22
      gcc
      python3

      lsd
      fzf
      zoxide
      zsh-powerlevel10k
    ];

        programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withRuby = false;
      withPython3 = false;

      # Nix will download, patch, and inject all of these directly into Neovim's path
      extraPackages = with pkgs; [
        # Linters & Formatters (Your missing Mason tools)
        prettierd                   # Fast prettier daemon
        prettier       # Prettier base
        eslint_d                    # Fast eslint daemon
        ruff                        # Replaces flake8 (massively faster and works out-of-the-box)
        htmlbeautifier
        rubyfmt
        rubocop

        # Language Servers (LSPs)
        pyright                     # Python
        nil                         # Nix
        nixfmt-rfc-style            # Nix formatter
        typescript-language-server  # JS/TS
        vscode-langservers-extracted # HTML, CSS, JSON, ESLint
        tailwindcss-language-server # Tailwind
        lua-language-server         # Lua
        rust-analyzer               # Rust
        gopls                       # Go
        zls                         # Zig
        intelephense                # PHP
        ruby-lsp                    # Ruby
        stimulus-language-server    # Stimulus
        csharp-ls                   # C#
      ];
    };

    # Native Atuin integration
    programs.atuin = {
      enable = true;
      enableZshIntegration = true;
    };

        # Native Tmux configuration
    programs.tmux = {
      enable = true;
      
      # Core options
      shell = "${pkgs.zsh}/bin/zsh";
      mouse = true;
      baseIndex = 1;
      shortcut = "Space"; # Automatically unbinds C-b and binds C-Space
      keyMode = "vi";     # Automatically sets mode-keys vi

      # Nix-managed plugins (replaces TPM)
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        yank
        {
          plugin = gruvbox;
          extraConfig = "set -g @tmux-gruvbox 'dark'";
        }
      ];

      # Raw config for bindings and overrides not handled by standard options
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

      # Aliases from your old .zshrc
      shellAliases = {
        cd = "z";
        ls = "lsd --depth 1 --tree";
      };

      # Native Oh My Zsh plugins (replaces zinit snippets)
      oh-my-zsh = {
        enable = true;
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

      # Community Zsh plugins installed via Nix (replaces zinit light)
      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];

      # Complete init script containing keybindings, PATHs, completion styles, and autostart
      initContent = ''
        # Source local Powerlevel10k config if present
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
