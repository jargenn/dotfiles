return {
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = { },
    },
    {
    { "tpope/vim-fugitive",          enabled = true, event = "VeryLazy" },
    { "f-person/git-blame.nvim",     enabled = true, event = "VeryLazy" },
    { "tpope/vim-commentary",        enabled = true, event = "VeryLazy" },
    {
        "lewis6991/gitsigns.nvim",
        enabled = true,
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    {
        "echasnovski/mini.nvim",
        enabled = true,
        event = "VeryLazy",
        config = function()
            local statusline = require("mini.statusline")
            statusline.setup({ use_icons = true })

            local miniclue = require("mini.clue")
            miniclue.setup({
                triggers = {
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'n', keys = 'g' },
                    { mode = 'n', keys = '<C-w>' },
                    { mode = 'i', keys = '<C-x>' },
                    { mode = 'c', keys = '<C-r>' },
                },
                clues = {
                    { mode = 'n', keys = '<Leader>b', desc = '+Buffers' },
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.windows({ submode_resize = true }),
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.registers(),
                },
                window = {
                    delay = 100,
                    config = {
                        width = 'auto',
                        border = 'double',
                    }
                }
            })
        end,
    },
}
