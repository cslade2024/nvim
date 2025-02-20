vim.opt.number = true

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
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  'romgrk/barbar.nvim',
  'nvim-tree/nvim-tree.lua',
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
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
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  },
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
