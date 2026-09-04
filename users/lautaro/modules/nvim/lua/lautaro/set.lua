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

local dark = os.date("*t").hour > 19
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

-- vim.api.nvim_create_autocmd("ColorScheme", {
--     callback = set_custom_highlights,
-- })

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
