vim.g.mapleader = " "
vim.o.number = true
vim.o.clipboard = "unnamedplus"
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

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
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {"nvim-lua/plenary.nvim"},
            config = function()
                vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
            end
        }
    }
)
