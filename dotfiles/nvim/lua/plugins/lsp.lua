return {
    -- 1. Mason for LSP server management
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },

    -- 2. Mason LSP Config (Bridges Mason and Lspconfig)
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", "ts_ls", "html", "cssls", "ruby_lsp",
                    "pyright", "clangd", "rust_analyzer", "intelephense",
                },
                automatic_installation = true,
            })
        end,
    },

    -- 3. The Core LSP Configuration (Migrated to Neovim 0.11+)
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Modern Neovim 0.11 Global Configuration Fallback
            -- This injects your cmp capabilities into all servers automatically
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- Modern Neovim 0.11 buffer keymaps attached via Autocommand
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local opts = { buffer = bufnr, remap = false }

                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                end,
            })

            -- SERVER CONFIGURATIONS AND INITIALIZATIONS --

            -- Clangd (C/C++) Enhanced Configuration
            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                -- Tells clangd where to find compilation roots so it can index standard headers correctly
                root_dir = function(filename)
                    return vim.fs.root(filename, { "compile_commands.json", "compile_flags.txt", ".git" })
                end,
            })
            vim.lsp.enable("clangd")

            -- NIX LANGUAGE SERVER (nil) & FORMATTER --
            vim.lsp.config("nil", {
                settings = {
                    ["nil"] = {
                        formatting = {
                            command = { "nixfmt" },
                        },
                    },
                },
            })
            vim.lsp.enable("nil")

            -- Lua
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            -- Intelephense (PHP)
            vim.lsp.config("intelephense", {
                settings = {
                    intelephense = {
                        stubs = { "apache", "bcmath", "curl", "dom", "exif", "gd", "mysqli", "pdo", "standard", "laravel" },
                    }
                }
            })
            vim.lsp.enable("intelephense")

            -- Generic Servers (No unique config needed, enabled directly)
            local simple_servers = { "ts_ls", "cssls", "ruby_lsp", "pyright", "rust_analyzer" }
            for _, server in ipairs(simple_servers) do
                vim.lsp.enable(server)
            end

            -- HTML (Requires specific filetypes layout)
            vim.lsp.config("html", { filetypes = { "html", "htmldjango" } })
            vim.lsp.enable("html")
        end,
    },

    -- 4. Autocompletion (nvim-cmp)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip",  priority = 750 },
                }, {
                    { name = "buffer", priority = 500 },
                    { name = "path",   priority = 250 },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            })
        end,
    },
}
