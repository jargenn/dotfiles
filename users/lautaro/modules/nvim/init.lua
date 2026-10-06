local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo(
            { { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit ..." } },
            true,
            {}
        )
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set = vim.opt

vim.g.have_nerd_font = true
set.clipboard = "unnamedplus"
vim.o.splitright = true
set.cursorline = true
vim.opt.signcolumn = "yes:1"
set.linebreak = false
set.expandtab = true
set.mouse = "a"
set.number = true
set.relativenumber = true
set.scrolloff = 4
set.shiftround = true
set.shiftwidth = 4
set.showmode = false
set.smartcase = true
set.smartindent = true
set.spelllang = { "en", "es" }
set.tabstop = 4
set.termguicolors = true
set.wrap = false
set.colorcolumn = "100"
vim.o.completeopt = vim.o.completeopt:gsub(",?preview", "")
vim.g.db_ui_auto_execute_table_helpers = 1

-- Plugins
require("lazy").setup({
    change_detection = { notify = false },
    lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",

    spec = {
        -- Colorscheme
        {
            "ellisonleao/gruvbox.nvim",
            priority = 1000,
            config = function()
                require("gruvbox").setup({
                    contrast = "hard",
                    palette_overrides = {
                        dark0_hard = "#181818",
                    }
                })
            end,
        },

        -- Color highlighter
        {
            "catgoose/nvim-colorizer.lua",
            event = "BufReadPre",
            opts = {},
        },

        -- LSP progress
        {
            "j-hui/fidget.nvim",
            opts = {},
            config = function(_, opts)
                require("fidget").setup(opts)
                vim.notify = require("fidget").notify
            end,
        },

        -- File finder
        {
            'dmtrKovalenko/fff',
            build = "nix run .#release",
            opts = {
                debug = {
                    enabled = true,
                    show_scores = true,
                },
            },
            lazy = false,
            keys = {
                { "ff",         function() require('fff').find_files() end, desc = 'FFFind files' },
                { "<leader>fg", function() require('fff').live_grep() end,  desc = 'LiFFFe grep' },
                {
                    "<leader>fz",
                    function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end,
                    desc = 'Live fffuzy grep',
                },
                {
                    "fw",
                    function() require('fff').live_grep_under_cursor() end,
                    mode = { 'n', 'x' },
                    desc = 'Search current word / selection',
                },
            },
        },

        -- Git
        { "tpope/vim-fugitive",      enabled = true, event = "VeryLazy" },
        { "f-person/git-blame.nvim", enabled = true, event = "VeryLazy" },
        { "tpope/vim-commentary",    enabled = true, event = "VeryLazy" },

        -- Git signs
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

        -- Statusline + key binding hints
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

        -- Completion
        {
            "saghen/blink.cmp",
            dependencies = { "rafamadriz/friendly-snippets" },
            version = "1.*",
            opts = {
                keymap = { preset = "default" },
                appearance = {
                    nerd_font_variant = "mono",
                },
                completion = { documentation = { auto_show = true } },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
                fuzzy = { implementation = "prefer_rust_with_warning" },
            },
            opts_extend = { "sources.default" },
        },

        -- Treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            lazy = false,
            config = function()
                local languages = {
                    "rust",
                    "c",
                    "typescript",
                    "css",
                    "djot",
                    "markdown",
                    "javascript",
                    "nix",
                    "sql",
                    "ocaml",
                    "python",
                }
                require("nvim-treesitter").install(languages)
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = vim.list_extend({ "lua" }, languages),
                    callback = function(args)
                        vim.treesitter.start(args.buf)
                    end,
                })
            end,
        },
    },
})

-- Keymaps (after lazy.setup so plugins like mini.clue don't intercept)
---@diagnostic disable: undefined-global
local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { desc = desc, silent = true, noremap = true })
end

map("%", "ggVG", "Select all text")
map("YY", "va{V", "Selecciona el contenido entre dos llaves")
map("<up>", "<C-w><up>", "Move to the tab above")
map("<down>", "<C-w><down>", "Move to the tab below")
map("<left>", "<C-w><left>", "Move to the left tab")
map("<right>", "<C-w><right>", "Move to the right tab")
map("<A-k>", ":m-2<CR>==", "Move the line above")
map("<A-j>", ":m+1<CR>==", "Move the line below")
map("<leader>pv", vim.cmd.Ex, "Open the current folder")
map("<C-g>", ":Git<CR>", "[G]it fugitive")

map("<leader>o", function()
    vim.fn.jobstart({ "gh", "repo", "view", "--web" }, { detach = true })
end, "Open GitHub repo in browser")

vim.keymap.set("n", "<space>cc", function()
    vim.fn.chansend(job_id, { "clear\r\n just run\r\n" })
end)

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.md", "*.txt", "*.tex", "*.dj" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.colorcolumn = "100"
        vim.opt_local.conceallevel = 2
        vim.opt_local.formatoptions:append("n")

        vim.keymap.set("n", "<A-n>", "]sz=", { noremap = true, buffer = true })
        vim.keymap.set("n", "<A-p>", "[sz=", { noremap = true, buffer = true })
    end,
})

local hour = os.date("*t").hour
local dark = hour >= 19 or hour <= 8
vim.o.background = dark and "dark" or "light"
vim.cmd([[colorscheme gruvbox]])

local highlights = {
    ["@comment"]               = { fg = "#ff8c00"},
    ["@comment.documentation"] = { fg = "#ff8c00" },
}

for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
end
