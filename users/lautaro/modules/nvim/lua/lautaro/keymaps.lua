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

