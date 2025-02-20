-- ~/.config/nvim/lua/plugins/cmp.lua
return {
  {
    "hrsh7th/nvim-cmp", -- The completion engine
    dependencies = {
      "hrsh7th/cmp-buffer", -- Completions from the current buffer
      "hrsh7th/cmp-path", -- Completions for file paths
      "hrsh7th/cmp-nvim-lsp", -- Completions from LSP (e.g., Pyright)
      "L3MON4D3/LuaSnip", -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet completions
    },
    config = function()
      -- Set up nvim-cmp
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- Use LuaSnip for snippets
          end,
        },
        mapping = {
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable, -- Disable default `<C-y>` mapping
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(), -- Abort completion
            c = cmp.mapping.close(), -- Close completion
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP completions (e.g., Pyright)
          { name = "luasnip" }, -- Snippet completions
          { name = "buffer" }, -- Current buffer completions
          { name = "path" }, -- File path completions
        }),
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip", -- Snippet engine
    config = function()
      require("luasnip").setup() -- Initialize LuaSnip
    end,
  },
}
