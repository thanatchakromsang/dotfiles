-- -- WSL clipboard support
-- if vim.fn.exists('$TMUX') == 1 and vim.fn.executable('tmux') == 1 then
--   vim.g.clipboard = {
--     name = "tmux-buffer",
--     copy = {
--       ["+"] = "tmux load-buffer -",
--       ["*"] = "tmux load-buffer -",
--     },
--     paste = {
--       ["+"] = "tmux save-buffer -",
--       ["*"] = "tmux save-buffer -",
--     },
--     cache_enable = 0,
--   }

-- if vim.fn.has("wsl") == 1 and vim.fn.executable('win32yank') == 1 then
--   vim.g.clipboard = {
--     name = "win32yank-wsl",
--     copy = {
--       ["+"] = "win32yank -i --crlf",
--       ["*"] = "win32yank -i --crlf",
--     },
--     paste = {
--       ["+"] = "win32yank -o --lf",
--       ["*"] = "win32yank -o --lf",
--     },
--     cache_enable = 0,
--   }
-- end

-- NOTE: https://www.reddit.com/r/neovim/comments/10y3t48/comment/j7y7jst/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end
