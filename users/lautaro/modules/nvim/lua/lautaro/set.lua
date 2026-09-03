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

local function set_custom_highlights()
    vim.api.nvim_set_hl(0, "@lsp.typemod.comment.documentation.rust", {
        fg = "#ff8c00",
    })

    vim.api.nvim_set_hl(0, "@lsp.type.comment.rust", {
        fg = "#ff8c00",
    })

    vim.api.nvim_set_hl(0, "@comment.rust", {
        fg = "#ff8c00",
    })

    vim.api.nvim_set_hl(0, "@comment.documentation.rust", {
        fg = "#ff8c00",
    })

    -- vim.api.nvim_set_hl(0, "@lsp.mod.mutable", {
    --     underline = true,
    -- })

    vim.api.nvim_set_hl(0, "@lsp.typemod.variable.consuming.rust", {
        -- underline = true,
        -- fg = "#83a598",
        bold = true,
    })

    vim.api.nvim_set_hl(0, "@lsp.typemod.keyword.unsafe.rust", {
        -- underline = true,
        bold = true,
    })

    vim.api.nvim_set_hl(0, "@lsp.type.module.ocaml", {
        italic = true,
        underline = true,
    })

    vim.api.nvim_set_hl(0, "@lsp.type.constructor.ocaml", {
        bold = true,
    })

    vim.api.nvim_set_hl(0, "@lsp.type.operator.ocaml", {
        bold = true,
    })

    vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.ocaml", {
        underline = true,
    })

    vim.api.nvim_set_hl(0, "@lsp.typemod.property.readonly.java", {
        underline = true,
    })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_custom_highlights,
})

set_custom_highlights()

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        vim.lsp.buf.format({
            bufnr = args.buf,
            async = false,
            filter = function(client)
                return client.supports_method("textDocument/formatting")
            end,
        })
    end,
})
