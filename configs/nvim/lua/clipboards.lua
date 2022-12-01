-- WSL clipboard support
if vim.fn.exists('$TMUX') == 1 and vim.fn.executable('tmux') == 1 then
  vim.g.clipboard = {
    name = "tmux-buffer",
    copy = {
      ["+"] = "tmux load-buffer -",
      ["*"] = "tmux load-buffer -",
    },
    paste = {
      ["+"] = "tmux save-buffer -",
      ["*"] = "tmux save-buffer -",
    },
    cache_enable = 0,
  }
elseif vim.fn.has("wsl") == 1 and vim.fn.executable('win32yank') == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank -i --crlf",
      ["*"] = "win32yank -i --crlf",
    },
    paste = {
      ["+"] = "win32yank -o --lf",
      ["*"] = "win32yank -o --lf",
    },
    cache_enable = 0,
  }
end
