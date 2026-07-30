local conf = require('telescope.config').values
local themes = require('telescope.themes')

-- helper function to use telescope on harpoon list.
-- change get_ivy to other themes if wanted
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end
    local opts = themes.get_ivy({
        promt_title = "Working List"
    })

    require("telescope.pickers").new(opts, {
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer(opts),
        sorter = conf.generic_sorter(opts),
    }):find()
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local harpoon = require('harpoon')
        -- Add file to harpoon list
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon Add File" })
        -- Telescope view
        vim.keymap.set("n", "<leader>hl", function() toggle_telescope(harpoon:list()) end,
            { desc = "Harpoon List (Telescope)" })
        -- Harpoon quick menu
        vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Harpoon Menu" })
        -- Harpoon navigation (previous/next)
        vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon Prev" })
        vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon Next" })

        -- Optional: Jump to 1st-4th harpoon files
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon to 1" })
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon to 2" })
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon to 3" })
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon to 4" })
    end
}
