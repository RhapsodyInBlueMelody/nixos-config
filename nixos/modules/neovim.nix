{ pkgs, config, ... }:

{
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";

  home.packages = with pkgs; [
    neovim # plain package — no home-manager-generated config, no collision

    clang-tools
    nil
    nixfmt-rfc-style
    typescript-language-server
    vscode-langservers-extracted
    tailwindcss-language-server
    pyright
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
    ruff
    rubocop

    nodejs_22
    gcc
    python3
    ripgrep
    fd
  ];
}
