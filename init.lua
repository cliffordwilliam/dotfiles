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
                                entry_maker = make_icon_entry_maker(require("telescope.pickers.entry_display"))
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

-- ICON SETUP
-- Icons are NerdFont glyphs identified by Unicode codepoint.
-- nr2char() converts a codepoint number to the UTF-8 character at runtime,
-- which avoids raw glyph bytes being mangled when saving this file.
--
-- Codepoints are sourced from nvim-material-icon:
--   lua/nvim-web-devicons/default/icons_by_file_extension.lua
-- To find the codepoint for a new icon, grep that file for the extension,
-- then run: python3 -c "print(hex(ord('<paste glyph here>')))"
--
-- ADDING A NEW ICON:
--   1. Find the extension entry in nvim-material-icon's icons_by_file_extension.lua
--   2. Get the codepoint with the python3 command above
--   3. Pick or add a color name below (reuse an existing one if the color matches)
--   4. Add a line: ext = {nr(0xXXXX), "TeleIconColorName"},
--
-- BREAKING CHANGE RISK — NerdFont version mismatch:
--   These codepoints are from NerdFont v3. If your terminal font is NerdFont v2,
--   many glyphs will render as boxes or wrong characters. Verify with:
--     :echo nr2char(0xED1B)   -- should show the Python icon
--   If it shows garbage, your font is likely v2. In that case, source codepoints
--   from the v2 cheat sheet at https://www.nerdfonts.com/cheat-sheet (filter v2).
--
-- BREAKING CHANGE RISK — Telescope entry_display API:
--   entry_display.create() and the displayer call format are internal Telescope APIs.
--   If icons stop appearing after a Telescope update, check:
--     telescope.nvim: lua/telescope/pickers/entry_display.lua
--   The displayer expects: { {glyph, hl_group}, remaining_text }
function make_icon_entry_maker(entry_display)
    local nr = vim.fn.nr2char
    local hl = vim.api.nvim_set_hl

    -- Color palette — Material Design colors from nvim-material-icon.
    -- To add a new color: pick a name, add it here, then reference it in the icons table.
    for name, color in pairs(
        {
            TeleIconBlue = "#42a5f5",
            TeleIconAqua = "#02acc1",
            TeleIconYellow = "#ffca29",
            TeleIconOrange = "#ff7043",
            TeleIconRed = "#ff5252",
            TeleIconGreen = "#44a047",
            TeleIconCyan = "#04bcd4",
            TeleIconSky = "#0188d1",
            TeleIconPy = "#3a87cb",
            TeleIconAmber = "#faa825",
            TeleIconHtml = "#e44e27",
            TeleIconGrey = "#888888"
        }
    ) do
        hl(0, name, {fg = color})
    end

    -- Each entry is { codepoint_as_char, highlight_group_name }.
    -- Key is the file extension in lowercase (no leading dot).
    local icons = {
        py = {nr(0xED1B), "TeleIconPy"},
        js = {nr(0xF031E), "TeleIconYellow"},
        ts = {nr(0xF06E6), "TeleIconSky"},
        jsx = {nr(0xED46), "TeleIconYellow"},
        tsx = {nr(0xED46), "TeleIconCyan"},
        lua = {nr(0xE620), "TeleIconBlue"},
        c = {nr(0xE649), "TeleIconSky"},
        cpp = {nr(0xE646), "TeleIconSky"},
        h = {nr(0xF0829), "TeleIconSky"},
        hpp = {nr(0xF0FD), "TeleIconSky"},
        rs = {nr(0xE68B), "TeleIconOrange"},
        go = {nr(0xF07D3), "TeleIconAqua"},
        html = {nr(0xF13B), "TeleIconHtml"},
        css = {nr(0xE749), "TeleIconBlue"},
        json = {nr(0xE60B), "TeleIconAmber"},
        yaml = {nr(0xF0219), "TeleIconRed"},
        yml = {nr(0xF0219), "TeleIconRed"},
        md = {nr(0xEB1D), "TeleIconBlue"},
        sh = {nr(0xF018D), "TeleIconOrange"},
        bash = {nr(0xEBCA), "TeleIconOrange"},
        zsh = {nr(0xF018D), "TeleIconOrange"},
        toml = {nr(0xE6B2), "TeleIconRed"},
        vim = {nr(0xE62B), "TeleIconGreen"}
    }
    -- Fallback for unrecognised extensions and extensionless files.
    local default_icon = {nr(0xF15B), "TeleIconGrey"}

    -- Two-column layout: fixed-width icon column + remaining space for the path.
    -- If icons become misaligned after a Telescope update, check entry_display.create()
    -- in telescope.nvim — the 'items' width config may need adjustment.
    local displayer = entry_display.create({separator = " ", items = {{width = 2}, {remaining = true}}})

    return function(filepath)
        local ext = filepath:match("%.([^%.]+)$")
        local info = (ext and icons[ext:lower()]) or default_icon
        return {
            value = filepath,
            ordinal = filepath,
            display = function(e)
                return displayer({{info[1], info[2]}, e.value})
            end
        }
    end
end
