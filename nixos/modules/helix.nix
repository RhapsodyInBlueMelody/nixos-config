{ pkgs, ... }:

{
  programs.helix = {
    enable = true;

    defaultEditor = true;

    # 1. Update this to use your new custom theme name
    settings = {
      theme = "gruvbox_custom";
      editor = {
        true-color = true;
        line-number = "relative";
        bufferline = "always";
        auto-format = true;

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };

    themes = {
      gruvbox_custom = {
        inherits = "gruvbox";

        # 1. Force the main background and space markers to be fully transparent
        "ui.background" = {
          bg = "none";
        };
        "ui.virtual.whitespace" = {
          bg = "none";
        };

      };
    };

    extraPackages = with pkgs; [
      clang-tools
      cppcheck
      nil
      nixfmt
      typescript-language-server
      vscode-langservers-extracted
      tailwindcss-language-server
      lua-language-server
      rust-analyzer
      gopls
      zls
      intelephense
      ruby-lsp
      stylua
      prettierd
      prettier
      eslint_d
      rubocop
      pyright
      ruff
      nodejs_22
      gcc
      ripgrep
      fd
    ];

    languages = {
      language = [
        {
          name = "nix";
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "lua";
          formatter = {
            command = "stylua";
            args = [ "--stdin" ];
          };
        }
        {
          name = "python";
          language-servers = [
            "pyright"
            "ruff"
          ];
        }
      ];
    };
  };
}
