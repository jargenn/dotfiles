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
    },

    root_markers = {
        ".git",
    },
})

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

vim.lsp.config['tracey'] = {
    cmd = { 'tracey', 'lsp' },
    filetypes = { 'rust', 'typescript', 'python', 'go', 'markdown' },
    root_markers = { '.config/tracey/config.styx' },
}

vim.lsp.enable('tracey')


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
