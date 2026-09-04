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

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,

        config = function()
            require("nvim-treesitter").install(languages)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = vim.list_extend({ "lua" }, languages),
                callback = function(args)
                    vim.treesitter.start(args.buf)
                end,
            })
        end,
    },
}
