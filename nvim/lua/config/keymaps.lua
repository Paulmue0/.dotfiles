-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Open command-line prompt with `-` in normal mode
vim.keymap.set("n", "-", ":", { noremap = true })

-- Open Neogit
vim.keymap.set("n", "<leader>gg", function()
  require("neogit").open()
end, { desc = "Open Neogit" })

-- Unmap the default Ctrl+a (optional)
vim.api.nvim_set_keymap("n", "<C-a>", "", { noremap = true, silent = true })

-- Map Ctrl+y to increment number (same as Ctrl+a)
vim.api.nvim_set_keymap("n", "<C-y>", "<C-a>", { noremap = true, silent = true })

-- Delete blink.cmp accept feature
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.schedule(function()
      pcall(vim.api.nvim_buf_del_keymap, 0, "i", "<C-y>")
      vim.api.nvim_buf_set_keymap(0, "i", "<C-y>", "<C-y>", { noremap = true })
    end)
  end,
})
