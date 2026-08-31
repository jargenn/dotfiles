return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,

        config = function()
            require("nvim-treesitter").install({
                "rust",
                "c",
                "typescript",
                "markdown",
                "sql",
                "ocaml",
                "python",
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local max_filesize = 100 * 1024
                    local ok, stats = pcall(
                        vim.uv.fs_stat,
                        vim.api.nvim_buf_get_name(args.buf)
                    )

                    if ok and stats and stats.size > max_filesize then
                        return
                    end

                    vim.treesitter.start(args.buf)
                end,
            })
        end,
    },
}
