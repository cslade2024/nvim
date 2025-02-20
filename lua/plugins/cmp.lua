local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- Use LuaSnip for snippets
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }), -- Scroll up in docs
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }), -- Scroll down in docs
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- Trigger completion
    ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }), -- Close completion
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- LSP completions
    { name = "luasnip" }, -- Snippet completions
    { name = "buffer" }, -- Buffer completions
    { name = "path" }, -- Path completions
  }),
})

-- Set up command-line completions
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "cmdline" }, -- Command-line completions
  }),
})
