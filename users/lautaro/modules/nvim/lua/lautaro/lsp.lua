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
        ".git",
    },
})

vim.lsp.enable("typescript-language-server")

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

vim.lsp.config("tracey", {
    cmd = { "tracey", "lsp" },

    filetypes = { "rust", "typescript", "markdown" },

    root_markers = {
        ".config/tracey/config.styx",
    },
})

vim.lsp.enable("rust_analyzer")

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

local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
end

map("<space>e", vim.diagnostic.open_float, "")
map("K", vim.lsp.buf.hover, "[H]over")
map("gS", vim.lsp.buf.signature_help, "[G]oto [S]ignature")
map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd")
map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove")
map("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, "[W]orkspace [L]ist")
map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
map("<leader>a", vim.lsp.buf.code_action, "[C]ode [A]ction")
map("<leader>fo", function()
    vim.lsp.buf.format({ async = true })
end, "[F]ormat")

