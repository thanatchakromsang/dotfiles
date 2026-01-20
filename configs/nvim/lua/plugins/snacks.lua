-- Snacks.nvim setup (required for opencode.nvim)
local status_ok, snacks = pcall(require, 'snacks')
if not status_ok then
  return
end

snacks.setup({
  input = {},    -- Required for opencode ask()
  picker = {},   -- Required for opencode select()
  terminal = {}, -- Required for snacks provider
})
