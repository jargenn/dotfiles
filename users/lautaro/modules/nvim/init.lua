-- Bootstrap lazy.nvim
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

-- Options
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

local hour = os.date("*t").hour
local dark = hour >= 19 or hour <= 8
vim.o.background = dark and "dark" or "light"

local colors = dark and {
    comment = "#ff8c00",
} or {
    comment = "#af3a03",
}

local highlights = {
    ["@lsp.typemod.comment.documentation"]   = { fg = colors.comment },
    ["@lsp.type.comment"]                    = { fg = colors.comment },
    ["@comment"]                             = { fg = colors.comment },
    ["@comment.documentation"]               = { fg = colors.comment },

    ["@lsp.typemod.variable.consuming.rust"] = { bold = true },
    ["@lsp.typemod.keyword.unsafe.rust"]     = { bold = true },

    ["@lsp.type.module.ocaml"]               = {
        italic = true,
        underline = true,
    },
    ["@lsp.type.constructor.ocaml"]          = { bold = true },
    ["@lsp.type.operator.ocaml"]             = { bold = true },
    ["@lsp.typemod.variable.readonly"]       = { underline = true },
}

for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
end

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        vim.lsp.buf.format({
            bufnr = args.buf,
            async = false,
            filter = function(client)
                return client:supports_method('textDocument/formatting')
            end,
        })
    end,
})

-- Keymaps
do
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
    map("<F8>", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", "Enable inlay hints")
    map("<leader>pv", vim.cmd.Ex, "Open the current folder")
    map("<C-g>", ":Git<CR>", "[G]it fugitive")

    map("gd", function()
        vim.lsp.buf.definition()
    end, "Goto definition")

    map("<leader>gd", function()
        vim.cmd("vsplit")
        vim.lsp.buf.definition()
    end, "Goto definition in vsplit")

    map("<leader>o", function()
        vim.fn.jobstart({ "gh", "repo", "view", "--web" }, { detach = true })
    end, "Open GitHub repo in browser")

    vim.keymap.set("n", "<space>cc", function()
        vim.fn.chansend(job_id, { "clear\r\n just run\r\n" })
    end)

    vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
    vim.keymap.set("n", "<space>x", ":.lua<CR>")
    vim.keymap.set("v", "<space>x", ":lua<CR>")
end

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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspCodelens", { clear = true }),
    callback = function(args)
        vim.lsp.codelens.enable(true, { bufnr = args.buf })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, {
                buffer = event.buf,
                desc = "LSP: " .. desc,
            })
        end

        map("<space>e", vim.diagnostic.open_float, "Open diagnostic")
        map("K", vim.lsp.buf.hover, "Hover")
        map("gS", vim.lsp.buf.signature_help, "Signature help")
        map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        map("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "List workspace folders")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>a", vim.lsp.buf.code_action, "Code action")
        map("<leader>fo", function()
            vim.lsp.buf.format({ async = true })
        end, "Format")
    end,
})

-- LSP
vim.lsp.config("typescript-language-server", {
    cmd = {
        "pnpm",
        "exec",
        "typescript-language-server",
        "--stdio",
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    root_markers = {
        "package.json",
        "tsconfig.json",
    },
})
vim.lsp.enable("typescript-language-server")

vim.lsp.config("nix-lsp", {
    cmd = {
        "nil",
        "--stdio",
    },
    filetypes = {
        "nix",
    },
    root_markers = {
        "flake.nix",
        "flake.lock",
    },
})
vim.lsp.enable("nix-lsp")

vim.lsp.config("deno-lsp", {
    cmd = {
        "deno",
        "lsp",
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    root_markers = {
        "deno.json",
    },
})
vim.lsp.enable("deno-lsp")

vim.lsp.config("vscode-css-languageserver", {
    cmd = {
        "vscode-css-languageserver",
        "--stdio",
    },
    filetypes = {
        "css",
        "scss",
        "less",
    },
    root_markers = {
        "package.json",
        ".git",
    },
})
vim.lsp.enable("vscode-css-languageserver")

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        { ".emmyrc.json", ".luarc.json", ".luarc.jsonc" },
        ".git",
    },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
        },
    },
})
vim.lsp.enable("lua_ls")

vim.lsp.config("rust_analyzer", {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = {
        "Cargo.toml",
        "rust-project.json",
    },
})
vim.lsp.enable("rust_analyzer")

vim.lsp.config["tracey"] = {
    cmd = { "tracey", "lsp" },
    filetypes = { "rust", "typescript", "python", "go", "markdown" },
    root_markers = { ".config/tracey/config.styx" },
}
vim.lsp.enable("tracey")

vim.lsp.config("ocamllsp", {
    cmd = { "ocamllsp" },
    filetypes = {
        "ocaml",
        "ocaml.interface",
        "ocaml.ocamllex",
        "ocaml.ocamlyacc",
    },
    root_markers = {
        "dune-project",
        "dune-workspace",
        ".git",
    },
})
vim.lsp.enable("ocamllsp")

vim.lsp.config("basedpyright", {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        ".git",
    },
})
vim.lsp.enable("basedpyright")

vim.lsp.config("ruff", {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "ruff.toml",
        ".ruff.toml",
        ".git",
    },
})
vim.lsp.enable("ruff")

vim.diagnostic.config({ virtual_text = true })

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
                    contrast = "hard"
                })
                vim.cmd([[colorscheme gruvbox]])
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
