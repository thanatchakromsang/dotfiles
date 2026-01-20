-- OpenCode setup
local status_ok, opencode = pcall(require, 'opencode')
if not status_ok then
  return
end

-- Configure opencode.nvim options
vim.g.opencode_opts = {
  provider = {
    enabled = "snacks",
  },
}

-- Required for opts.events.reload
vim.o.autoread = true

-- Keymappings (using recommended keymaps from opencode.nvim)
vim.keymap.set({ "n", "x" }, "<C-a>", function() opencode.ask("@this: ", { submit = true }) end, { desc = "Ask OpenCode..." })
vim.keymap.set({ "n", "x" }, "<C-x>", function() opencode.select() end, { desc = "Execute OpenCode action..." })
vim.keymap.set({ "n", "t" }, "<C-.>", function() opencode.toggle() end, { desc = "Toggle OpenCode" })

-- Operator for adding ranges to OpenCode (supports dot-repeat)
vim.keymap.set({ "n", "x" }, "go", function() return opencode.operator("@this ") end, { expr = true, desc = "Add range to OpenCode" })
vim.keymap.set("n", "goo", function() return opencode.operator("@this ") .. "_" end, { expr = true, desc = "Add line to OpenCode" })

-- Scroll commands
vim.keymap.set("n", "<S-C-u>", function() opencode.command("session.half.page.up") end, { desc = "Scroll OpenCode up" })
vim.keymap.set("n", "<S-C-d>", function() opencode.command("session.half.page.down") end, { desc = "Scroll OpenCode down" })

-- Remap increment/decrement since we're using <C-a> and <C-x>
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
