-----------------------------------------------------
-- Daps
-----------------------------------------------------

local dap = require'dap'
local map = vim.api.nvim_set_keymap

vim.g.dap_virtual_text = true

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = {os.getenv("HOME") .. "/repos/vscode-node-debug2/out/src/nodeDebug.js"}
}

dap.configurations.javascript = {
  {
    type = "node2",
    request = "launch",
    program = "${workspaceFolder}/${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal"
  }
}

dap.configurations.javascriptreact = {
  {
    type = "node2",
    request = "launch",
    -- program = "${workspaceFolder}/${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal"
  }
}

dap.configurations.typescript = {
  {
    type = "node2",
    request = "launch",
    program = "${workspaceFolder}/${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal"
  }
}

map("n", "<F5>", [[:lua require('dap').continue()<CR>]], {})
map("n", "<F6>", [[:lua require('dap').step_over()<CR>]], {})
map("n", "<F7>", [[:lua require('dap').step_into()<CR>]], {})
map("n", "<F8>", [[:lua require('dap').step_out()<CR>]], {})
map("n", "<localleader>dt", [[:lua require('dap').toggle_breakpoint()<CR>]], {})
map("n", "<localleader>dl", [[:lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]], {})
map("n", "<localleader>dr", [[:lua require('dap').repl.open()<CR>]], {})
