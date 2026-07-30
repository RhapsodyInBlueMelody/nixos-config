local keymap = vim.keymap.set

-- Set space as the leader key
vim.g.mapleader = " "
keymap("n", "<leader>cd", ":Ex<CR>")
keymap("n", "<leader>q", ":q!<CR>")
keymap("n", "<leader>wq", ":wq<CR>")
keymap("n", "<leader>x", ":x<CR>")

-- auto completion
keymap("n", "<leader>mp", function()
    require("conform").format({ lsp_fallback = true })
end)

-- Trouble
keymap("n", "<leader>xx", ":Trouble<CR>")
keymap("n", "<leader>xw", ":Trouble workspace_diagnostics<CR>")
keymap("n", "<leader>xd", ":Trouble document_diagnostics<CR>")

-- Terminal
keymap("n", "<leader>tt", ":terminal<CR>")
keymap("t", "<Esc>", "<C-\\><C-n>")

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

--buffer switch
keymap("n", "<C-n>", ":bnext<CR>")
keymap("n", "<C-p>", ":bprevious<CR>")

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Visual mode mappings
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")

-- Add inside your LspAttach autocmd block (near gd, K, etc.):
keymap("n", "<leader>fm", function()
    vim.lsp.buf.format({ async = true })
end, opts)
