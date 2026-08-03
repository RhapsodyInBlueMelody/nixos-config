local options = vim.opt

options.number = true
options.cursorline = true
options.relativenumber = true
options.shiftwidth = 4
options.clipboard = "unnamedplus"
options.tabstop = 2
options.expandtab = true
options.smartindent = true
options.wrap = false
options.ignorecase = true
options.smartcase = true
options.hlsearch = false
options.incsearch = true
options.termguicolors = true
options.scrolloff = 8
options.sidescrolloff = 8
options.signcolumn = "yes"
options.updatetime = 50
options.timeoutlen = 300
options.completeopt = "menu,menuone,noselect"
options.undofile = true
options.backup = false
options.writebackup = false
options.swapfile = false

vim.filetype.add({
  extension = {
    nix = "nix",
  },
})

