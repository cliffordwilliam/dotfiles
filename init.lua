vim.g.mapleader = " "

vim.opt.number = true
vim.opt.wrap = false
vim.opt.ignorecase = false
vim.opt.smartcase = false
vim.opt.showmode = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "chriskempson/tomorrow-theme",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme Tomorrow-Night-Blue")
    end,
  },
    
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--case-sensitive",
          },
        },
        pickers = {
          live_grep = {
            additional_args = function()
              return { "--case-sensitive", "--fixed-strings", "--hidden" }
            end,
          },
          find_files = {
            hidden = true,
          },
        },
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)

      vim.keymap.set("n", "<leader>fG", function()
        builtin.live_grep({
          additional_args = function()
            return { "--case-sensitive", "--hidden", "--no-ignore" }
          end,
        })
      end)

      vim.keymap.set("n", "<leader>fF", function()
        builtin.find_files({
          hidden = true,
          no_ignore = true,
        })
      end)
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<leader>t]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        direction = "horizontal",
      })

      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
      vim.keymap.set("t", "<leader>t", [[<Cmd>ToggleTerm<CR>]])
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      auto_install = true,
      highlight = { enable = true },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my-lsp", { clear = true }),
        callback = function(event)
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = event.buf })
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = event.buf })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = event.buf })
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      require("mason-lspconfig").setup({
        ensure_installed = { "pylsp", "ts_ls", "clangd" },
        handlers = {
          function(server)
            require("lspconfig")[server].setup({
              capabilities = capabilities,
            })
          end,
        },
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function() end },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
        },
      })
    end,
  },
})
