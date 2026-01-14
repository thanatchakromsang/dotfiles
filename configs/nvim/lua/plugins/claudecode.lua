-- Claude Code setup
require("render-markdown").setup({
  latex = {
    enabled = false
  }
})

-- claudecode.nvim wraps the `claude` CLI command
-- It will automatically use your existing Claude CLI configuration:
-- - AWS Bedrock if configured via Claude CLI
-- - Anthropic API if configured
-- - Your model preferences and settings from ~/.claude or environment
local status_ok, claudecode = pcall(require, 'claudecode')
if status_ok then
  claudecode.setup({
    -- The plugin invokes the claude CLI binary, respecting all your existing settings
  })

  -- Keymappings for claudecode
  vim.keymap.set('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { noremap = true, silent = true, desc = 'Toggle Claude' })
  vim.keymap.set('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { noremap = true, silent = true, desc = 'Focus Claude' })
  vim.keymap.set('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { noremap = true, silent = true, desc = 'Resume Claude' })
  vim.keymap.set('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>', { noremap = true, silent = true, desc = 'Continue Claude' })
  vim.keymap.set('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', { noremap = true, silent = true, desc = 'Select Claude model' })
  vim.keymap.set('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { noremap = true, silent = true, desc = 'Add current buffer' })

  -- Visual mode: send selection to claude
  vim.keymap.set('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { noremap = true, silent = true, desc = 'Send to Claude' })

  -- File explorer specific binding
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    callback = function()
      vim.keymap.set('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', { buffer = true, noremap = true, silent = true, desc = 'Add file' })
    end,
  })

  -- Diff management
  vim.keymap.set('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { noremap = true, silent = true, desc = 'Accept diff' })
  vim.keymap.set('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { noremap = true, silent = true, desc = 'Deny diff' })
end
