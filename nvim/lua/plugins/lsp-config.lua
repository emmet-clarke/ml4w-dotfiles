return {
    {
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup()
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "ruff",
                    "tflint",
                    "zls",
                    "dockerls",
                    "docker_compose_language_service",
                    "bashls",
                    "sqlls",
                    "terraformls"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }

            })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})

            lspconfig.ruff.setup({
                 root_dir = util.root_pattern("pyproject.toml", ".git"),
              on_attach = function(_, bufnr)
                vim.keymap.set('n', '<leader>r', function()
                  vim.lsp.buf.code_action({
                    filter = function(a) return a.kind == "source.fixAll.ruff" end,
                    apply = true,
                  })
                end, { buffer = bufnr, desc = "Ruff: Fix all" })
                vim.keymap.set('n', '<leader>F', function()
                    vim.lsp.buf.format({ name = "ruff", async = false })
                end, { buffer = bufnr, desc = "Ruff: Format file" })
              end,
            })

            lspconfig.terraformls.setup{
                filetypes = { "terraform", "tf", "terraform-vars" },
                cmd = { "terraform-ls", "serve" }
            }
        end
    }
}
