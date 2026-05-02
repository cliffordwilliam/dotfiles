vim.o.signcolumn = "yes"
vim.cmd.colorscheme "deep-ocean"
vim.g.mapleader = " "
vim.o.ignorecase = false
vim.o.smartcase = false
vim.opt.wrap = false
vim.o.number = true
vim.o.cursorline = true
vim.o.clipboard = "unnamedplus"
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Grab lazy dependency manager idempotently.
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    local output = vim.fn.system {"git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath}
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. output)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        -- Grab file finder.
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {"nvim-lua/plenary.nvim"},
            config = function()
                vim.keymap.set(
                    "n",
                    "<leader>ff",
                    function()
                        require("telescope.builtin").find_files(
                            {
                                hidden = true,
                                file_ignore_patterns = {"^%.git/", "^vendor/"},
                            }
                        )
                    end
                )
            end
        },
        -- Grab LSP manager.
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim"
            },
            config = function()
                vim.api.nvim_create_autocmd(
                    "LspAttach",
                    {
                        group = vim.api.nvim_create_augroup("lsp-attach", {clear = true}),
                        callback = function(event)
                            -- gd       = go to definition.
                            vim.keymap.set(
                                "n",
                                "gd",
                                require("telescope.builtin").lsp_definitions,
                                {buffer = event.buf}
                            )
                            -- gr       = go to references.
                            vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {buffer = event.buf})
                            -- space rn = rename.
                            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer = event.buf})
                            -- space e  = open error.
                            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {buffer = event.buf})
                            -- K        = show documentation.
                            vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = event.buf})
                        end
                    }
                )
                local servers = {
                    lua_ls = {},
                    ts_ls = {},
                    clangd = {}
                }

                require("mason").setup()

                require("mason-lspconfig").setup(
                    {
                        ensure_installed = vim.tbl_keys(servers),
                        handlers = {
                            function(server_name)
                                local opts = servers[server_name] or {}
                                require("lspconfig")[server_name].setup(opts)
                            end
                        }
                    }
                )
            end
        },
        -- Setup autocompletion.
        {
            "saghen/blink.cmp",
            version = "v0.*",
            opts = {
                keymap = {
                    ["<Up>"] = {"select_prev", "fallback"},
                    ["<Down>"] = {"select_next", "fallback"},
                    ["<Enter>"] = {"accept", "fallback"}
                },
                sources = {
                    default = {"lsp", "path"}
                }
            }
        }
    }
)
