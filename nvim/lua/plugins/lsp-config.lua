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

            -- Simple ruff setup
            lspconfig.ruff.setup({
                on_attach = function(_, bufnr)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format()
                        vim.lsp.buf.code_action({
                            filter = function(action)
                                return action.title == "Ruff: Organize Imports"
                            end,
                            apply = true
                        })
                    end, { buffer = bufnr })
                end
            })

            lspconfig.terraformls.setup{
                filetypes = { "terraform", "tf", "terraform-vars" },
                cmd = { "terraform-ls", "serve" }
            }
        end
    }
}
