vim.opt.number = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  --Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  --Tab Management
  'romgrk/barbar.nvim',

  --File Sidebar
  'nvim-tree/nvim-tree.lua',
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  --LSP Installatoin
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  --LSP Configuration
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('mason-lspconfig').setup_handlers {
        function(server)
          require('lspconfig')[server].setup {}
        end,
      }
    end,
  },

  --Autocomplete
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip', -- Snippet engine
      'saadparwaiz1/cmp_luasnip', -- Snippet completions
    },
  },

  --Bottom Status Bar
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  --Theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  },

  --Terminal
  {'akinsho/toggleterm.nvim', version = "*", config = true},

})

require('plugins.lualine')
require('plugins.mason')
require('plugins.mason-config')
require('plugins.terminal')
require('plugins.cmp')
require('plugins.barbar')
require('plugins.tree')
require('plugins.lsps.lua_ls')

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
