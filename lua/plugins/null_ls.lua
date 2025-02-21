local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
  },
})

-- Optional: Set up a keybinding to format files
vim.keymap.set("n", "<leader>p", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format file with Prettier" })
