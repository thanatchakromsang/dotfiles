local npairs = require("nvim-autopairs")

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = { 'string' }, -- it will not add a pair on that treesitter node
    javascript = { 'template_string' },
    java = false,
  },
  enable_check_bracket_line = false,
  disable_filetype = { "TelescopePrompt" },
  break_line_filetype = nil, -- mean all file type
  html_break_line_filetype = { 'html', 'vue', 'typescriptreact', 'svelte', 'javascriptreact' },
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
})

local Rule = require("nvim-autopairs.rule")
local ts_conds = require('nvim-autopairs.ts-conds')

npairs.add_rules {
  Rule(" ", " "):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({ "()", "[]", "{}" }, pair)
  end), Rule("(", ")"):with_pair(function(opts)
    return opts.prev_char:match ".%)" ~= nil
  end):use_key ")", Rule("{", "}"):with_pair(function(opts)
    return opts.prev_char:match ".%}" ~= nil
  end):use_key "}", Rule("[", "]"):with_pair(function(opts)
    return opts.prev_char:match ".%]" ~= nil
  end):use_key "]", Rule("%", "%", "lua")-- press % => %% is only inside comment or string
      :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
  Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ 'function' }))
}
