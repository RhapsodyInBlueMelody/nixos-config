{ pkgs, config, ... }:

{
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";

  home.packages = with pkgs; [
    neovim

    # Language Servers & Tools
    clang-tools
    cppcheck
    nil
    nixfmt-rfc-style
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

    # Linters & Formatters
    prettierd
    prettier
    eslint_d
    rubocop

    # Python LSPs / Linters / Tools
    pyright # Python LSP
    ruff # Fast Python Linter & Formatter

    # System Dependencies & Tools
    nodejs_22
    gcc
    ripgrep
    fd
  ];
}
