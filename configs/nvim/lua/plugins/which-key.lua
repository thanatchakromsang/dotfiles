local wk = require("which-key")

wk.setup {
    presets = {
        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = false -- bindings for prefixed with g
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
        rules = false,
        mappings = false,
    },
    win = {
        padding = {2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    show_help = true, -- show help message on the command line when the popup is visible
    -- triggers = {"<leader>", "<localleader>", "g", "\'", "\"", "<C-r>", "z"} -- automatically setup triggers
}

-- Normal Leader
wk.add(
  {
    { "<leader>", group = "leader", nowait = false, remap = false },
    { "<leader> ", desc = "fold", nowait = false, remap = false },
    { "<leader>T", group = "trouble", nowait = false, remap = false },
    { "<leader>TT", desc = "TODO", nowait = false, remap = false },
    { "<leader>Td", desc = "document diagnostics", nowait = false, remap = false },
    { "<leader>Tl", desc = "local list", nowait = false, remap = false },
    { "<leader>Tq", desc = "quickfix list", nowait = false, remap = false },
    { "<leader>Tt", desc = "toggle", nowait = false, remap = false },
    { "<leader>Tw", desc = "workspace diagnostics", nowait = false, remap = false },
    { "<leader>e", desc = "explorer", nowait = false, remap = false },
    { "<leader>f", group = "find", nowait = false, remap = false },
    { "<leader>f.", ":Telescope filetypes<CR>", desc = "filetypes", nowait = false, remap = false },
    { "<leader>fB", ":Telescope git_branches<CR>", desc = "git branches", nowait = false, remap = false },
    { "<leader>fC", ":Telescope git_commits<CR>", desc = "git history", nowait = false, remap = false },
    { "<leader>fD", ":Telescope diagnostics<CR>", desc = "workspace diagnostics", nowait = false, remap = false },
    { "<leader>fT", ":TodoTelescope<CR>", desc = "TODO", nowait = false, remap = false },
    { "<leader>fb", ":Telescope buffers<CR>", desc = "buffers", nowait = false, remap = false },
    { "<leader>fc", ":Telescope git_commits<CR>", desc = "git current file history", nowait = false, remap = false },
    { "<leader>fd", ":Telescope diagnostics bufnr=0<CR>", desc = "document diagnostics", nowait = false, remap = false },
    { "<leader>ff", ":Telescope find_files<CR>", desc = "find files", nowait = false, remap = false },
    { "<leader>fg", ":Telescope git_files<CR>", desc = "find git files", nowait = false, remap = false },
    { "<leader>fh", ":Telescope command_history<CR>", desc = "command history", nowait = false, remap = false },
    { "<leader>fi", ":Telescope media_files<CR>", desc = "media files", nowait = false, remap = false },
    { "<leader>fl", ":Telescope loclist<CR>", desc = "loclist", nowait = false, remap = false },
    { "<leader>fm", ":Telescope marks<CR>", desc = "marks", nowait = false, remap = false },
    { "<leader>fo", ":Telescope vim_options<CR>", desc = "vim options", nowait = false, remap = false },
    { "<leader>fq", ":Telescope quickfix<CR>", desc = "quickfix", nowait = false, remap = false },
    { "<leader>fs", ":Telescope lsp_document_symbols<CR>", desc = "document diagnostics", nowait = false, remap = false },
    { "<leader>ft", ":Telescope live_grep<CR>", desc = "text", nowait = false, remap = false },
    { "<leader>g", group = "git", nowait = false, remap = false },
    { "<leader>gB", desc = "browse git remote", nowait = false, remap = false },
    { "<leader>gC", ":Telescope git_commits<CR>", desc = "git history", nowait = false, remap = false },
    { "<leader>gP", desc = "preview hunk", nowait = false, remap = false },
    { "<leader>gR", desc = "reset buffer", nowait = false, remap = false },
    { "<leader>gS", ":Telescope git_stash<CR>", desc = "git stash", nowait = false, remap = false },
    { "<leader>gb", desc = "blame line", nowait = false, remap = false },
    { "<leader>gc", ":Telescope git_bcommits<CR>", desc = "git current file history", nowait = false, remap = false },
    { "<leader>gd", group = "diff", nowait = false, remap = false },
    { "<leader>gdc", desc = "diff view close", nowait = false, remap = false },
    { "<leader>gdd", desc = "diff this", nowait = false, remap = false },
    { "<leader>gdo", desc = "diff view open", nowait = false, remap = false },
    { "<leader>gdr", desc = "diff view refresh", nowait = false, remap = false },
    { "<leader>gg", "<cmd>FloatermNew --height=0.9 --width=0.9 --name=git --wintype=float lazygit<CR>", desc = "lazygit", nowait = false, remap = false },
    { "<leader>gn", desc = "go to next hunk", nowait = false, remap = false },
    { "<leader>gp", desc = "go to prev hunk", nowait = false, remap = false },
    { "<leader>gr", desc = "reset hunk", nowait = false, remap = false },
    { "<leader>gs", desc = "stage hunk", nowait = false, remap = false },
    { "<leader>gu", desc = "undo stage hunk", nowait = false, remap = false },
    { "<leader>o", group = "opencode", nowait = false, remap = false },
    { "<leader>oa", function() require('opencode').ask() end, desc = "ask", nowait = false, remap = false },
    { "<leader>oo", function() require('opencode').toggle() end, desc = "toggle", nowait = false, remap = false },
    { "<leader>op", function() require('opencode').select() end, desc = "select prompt", nowait = false, remap = false },
    { "<leader>oC", function() require('opencode').command('agent.cycle') end, desc = "cycle agent", nowait = false, remap = false },
    { "<leader>oi", function() require('opencode').command('session.interrupt') end, desc = "interrupt session", nowait = false, remap = false },
    { "<leader>ol", function() require('opencode').command('session.list') end, desc = "list session", nowait = false, remap = false },
    { "<leader>oc", function() require('opencode').command('prompt.clear') end, desc = "prompt clear", nowait = false, remap = false },
    { "<leader>os", function() require('opencode').command('prompt.submit') end, desc = "prompt submit", nowait = false, remap = false },
    { "<leader>ob", function() require('opencode').prompt('@buffer ') end, desc = "add buffer to prompt", nowait = false, remap = false },
    { "<leader>ox", function() require('opencode').ask("@this: explain this", { submit = true }) end, desc = "explain", nowait = false, remap = false },
    { "<leader>O", ":SymbolsOutline<CR>", desc = "outline", nowait = false, remap = false },
    { "<leader>p", group = "packer", nowait = false, remap = false },
    { "<leader>pC", ":PackerClean<CR>", desc = "clean", nowait = false, remap = false },
    { "<leader>pc", ":PackerCompile<CR>", desc = "compile", nowait = false, remap = false },
    { "<leader>pi", ":PackerInstall<CR>", desc = "install", nowait = false, remap = false },
    { "<leader>ps", ":PackerSync<CR>", desc = "sync", nowait = false, remap = false },
    { "<leader>pu", ":PackerUpdate<CR>", desc = "update", nowait = false, remap = false },
    { "<leader>r", ":FloatermNew --height=0.8 --width=0.8 --name=ranger --wintype=float ranger<CR>", desc = "ranger", nowait = false, remap = false },
    { "<leader>s", group = "startify", nowait = false, remap = false },
    { "<leader>sc", ":SClose<CR>", desc = "close session", nowait = false, remap = false },
    { "<leader>sd", ":SDelete<CR>", desc = "delete session", nowait = false, remap = false },
    { "<leader>sh", ":Startify<CR>", desc = "home", nowait = false, remap = false },
    { "<leader>sl", ":SLoad<CR>", desc = "load session", nowait = false, remap = false },
    { "<leader>ss", ":SSave<CR>", desc = "save session", nowait = false, remap = false },
    { "<leader>t", group = "test", nowait = false, remap = false },
    { "<leader>tf", desc = "test file", nowait = false, remap = false },
    { "<leader>tl", desc = "test last", nowait = false, remap = false },
    { "<leader>ts", desc = "test suite", nowait = false, remap = false },
    { "<leader>tt", desc = "test nearest", nowait = false, remap = false },
    { "<leader>tv", desc = "test visit", nowait = false, remap = false },
  }
)

wk.add(
  {
    {
      mode = { "v" },
      { "<leader>", group = "leader", nowait = false, remap = false },
      { "<leader>g", group = "git", nowait = false, remap = false },
      { "<leader>gB", desc = "browse git remote", nowait = false, remap = false },
      { "<leader>o", group = "opencode", nowait = false, remap = false },
      { "<leader>oa", function() require('opencode').ask("@this: ") end, desc = "ask", nowait = false, remap = false },
      { "<leader>of", function() require('opencode').ask("@this: fix this code") end, desc = "fix code", nowait = false, remap = false },
      { "<leader>or", function() require('opencode').ask("@this: refactor this") end, desc = "refactor", nowait = false, remap = false },
      { "<leader>ox", function() require('opencode').ask("@this: explain this") end, desc = "explain", nowait = false, remap = false },
      { "<leader>op", function() require('opencode').select() end, desc = "select prompt", nowait = false, remap = false },
      { "<leader>r", desc = "refactoring", nowait = false, remap = false },
    },
  }
)

-- Normal Local Leader
wk.add(
  {
    { "<localleader>", group = "localleader", nowait = false, remap = false },
    { "<localleader>.", desc = "set current working dir", nowait = false, remap = false },
    { "<localleader>R", desc = "set root working dir", nowait = false, remap = false },
    { "<localleader>a", desc = "code action", nowait = false, remap = false },
    { "<localleader>b", desc = "horizontal split", nowait = false, remap = false },
    { "<localleader>c", desc = "close buffer", nowait = false, remap = false },
    { "<localleader>d", group = "dap", nowait = false, remap = false },
    { "<localleader>dl", desc = "log breakpoint", nowait = false, remap = false },
    { "<localleader>dr", desc = "repl open", nowait = false, remap = false },
    { "<localleader>dt", desc = "toggle breakpoint", nowait = false, remap = false },
    { "<localleader>f", desc = "code format", nowait = false, remap = false },
    { "<localleader>r", desc = "rename", nowait = false, remap = false },
    { "<localleader>v", desc = "vertical split", nowait = false, remap = false },
    { "<localleader>w", desc = "close window", nowait = false, remap = false },
  }
)

-- Normal G
wk.add(
  {
    { "g", group = "goto", nowait = false, remap = false },
    { "gD", desc = "declaration", nowait = false, remap = false },
    { "gR", desc = "references", nowait = false, remap = false },
    { "gd", desc = "definition", nowait = false, remap = false },
    { "gi", desc = "implementation", nowait = false, remap = false },
    { "gn", desc = "next diagnostic", nowait = false, remap = false },
    { "go", desc = "opencode operator", nowait = false, remap = false },
    { "gp", desc = "prev diagnostic", nowait = false, remap = false },
    { "gr", desc = "reference", nowait = false, remap = false },
    { "gs", desc = "signature help", nowait = false, remap = false },
    { "gt", desc = "type definition", nowait = false, remap = false },
  }
)

-- OpenCode keymaps
wk.add(
  {
    { "<C-a>", desc = "ask opencode", mode = { "n", "x" }, nowait = false, remap = false },
    { "<C-x>", desc = "opencode select", mode = { "n", "x" }, nowait = false, remap = false },
    { "<C-.>", desc = "toggle opencode", mode = { "n", "t" }, nowait = false, remap = false },
    { "+", desc = "increment", nowait = false, remap = false },
    { "-", desc = "decrement", nowait = false, remap = false },
  }
)
