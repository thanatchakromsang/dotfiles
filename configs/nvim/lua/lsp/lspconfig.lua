local lspconfig = require 'lspconfig'

vim.fn.sign_define("LspDiagnosticsSignError", {texthl = "LspDiagnosticsSignError", text = ""})
vim.fn.sign_define("LspDiagnosticsSignWarning", {texthl = "LspDiagnosticsSignWarning", text = ""})
vim.fn.sign_define("LspDiagnosticsSignInformation", {texthl = "LspDiagnosticsSignInformation", text = ""})
vim.fn.sign_define("LspDiagnosticsSignHint", {texthl = "LspDiagnosticsSignHint", text = ""})

-----------------------------------------------------
-- Handler overrides
-----------------------------------------------------

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {prefix = "", spacing = 0},
    signs = true,
    update_in_insert = false
})

-----------------------------------------------------
-- Custom on_attach / capabilities
-----------------------------------------------------

-- Add LSP Snippets capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Got this from tjdevries/config_manager
local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

-- TODO: after 0.8 update format function to this https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local custom_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gn", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "gp", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)

    if client.resolved_capabilities.code_action then
        buf_set_keymap("n", "<localleader>a", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        buf_set_keymap("v", "<localleader>a", "<Cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
    end
    if client.resolved_capabilities.declaration then buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) end
    if client.resolved_capabilities.implementation then buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts) end
    if client.resolved_capabilities.find_references then buf_set_keymap("n", "gr", "<Cmd>Telescope lsp_references<CR>", opts) end
    if client.resolved_capabilities.type_definition then buf_set_keymap("n", "gt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts) end
    if client.resolved_capabilities.rename then buf_set_keymap("n", "<localleader>r", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts) end
    if client.resolved_capabilities.signature_help then buf_set_keymap("n", "gs", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts) end

    -- Set document highlight using illuminate
    if client.resolved_capabilities.document_highlight then
      require "illuminate".on_attach(client)
    end

    -- -- -- TODO: codelens integration
    -- if client.resolved_capabilities.code_lens then
    --     vim.api.nvim_exec([[
    --       augroup lsp_code_lens_refresh
    --         autocmd! * <buffer>
    --         autocmd InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    --         autocmd InsertLeave <buffer> lua vim.lsp.codelens.display()
    --       augroup END
    --     ]], false)
    -- end

    -- -- autoformat after save
    -- if client.resolved_capabilities.document_formatting then
    --     vim.api.nvim_command [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 300)]]
    -- end

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<localleader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<localleader>f", "<Cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    print("'" .. client.name .. "' server attached")
end

-----------------------------------------------------
-- go LSP
-----------------------------------------------------

lspconfig.gopls.setup {
    cmd = {"gopls", "--remote=auto"},
    on_attach = custom_attach,
    capabilities = capabilities,
    init_options = {usePlaceholders = true, completeUnimported = true},
    flags = {debounce_text_changes = 150}
}

-----------------------------------------------------
-- lua LSP
-----------------------------------------------------

lspconfig.sumneko_lua.setup {
    -- cmd = {"lua-language-server", "-E", "/usr/share/lua-language-server/main.lua"},
    cmd = {"lua-language-server"},
    on_attach = function(client, bufnr)
        -- Disable formatting, use stylua instead
        client.resolved_capabilities.document_formatting = false
        custom_attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim', 'packer_plugins'}},
            workspace = {library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}},
            telemetry = {enable = false}
        }
    },
    flags = {debounce_text_changes = 150}
}

-----------------------------------------------------
-- yaml LSP
-----------------------------------------------------

lspconfig.yamlls.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                -- ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                -- ["https://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                -- ["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                -- ["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                -- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
                kubernetes = "*.{yml,yaml}",
            },
            schemaStore = {enable = true}
        }
    },
    flags = {debounce_text_changes = 150}
}

-----------------------------------------------------
-- tsserver LSP
-----------------------------------------------------

lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
        -- Disable tsserver formatting, use prettier in null-ls instead
        client.resolved_capabilities.document_formatting = false
        custom_attach(client, bufnr)
    end,
    capabilities = capabilities,
    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},
    flags = {debounce_text_changes = 150}
}

-----------------------------------------------------
-- Bash LSP
-----------------------------------------------------

lspconfig.bashls.setup {on_init = custom_init, on_attach = custom_attach, capabilities = capabilities, filetypes = {"sh", "zsh"}}

-----------------------------------------------------
-- terraform LSP
-----------------------------------------------------

lspconfig.terraformls.setup {
    on_attach = function(client, bufnr)
        client.resolved_capabilities.signature_help = false
        custom_attach(client, bufnr)
    end,
    capabilities = capabilities,
    flags = {debounce_text_changes = 150}
}

-----------------------------------------------------
-- Null LSP
-----------------------------------------------------

local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    -- Javascript, Typescript
    formatting.eslint_d,
    formatting.prettier,
    -- Python
    formatting.black,
    formatting.isort,
    -- proto
    formatting.protolint,
    -- sh
    formatting.shfmt,
    code_actions.shellcheck,
    diagnostics.shellcheck,
    -- lua
    formatting.stylua,
    -- general
    code_actions.refactoring,
    diagnostics.codespell,
  },
  on_attach = custom_attach
})

-----------------------------------------------------
-- general LSP
-----------------------------------------------------

-- Avaliable LSP https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local servers = {'dockerls', 'rust_analyzer', 'pyright', 'vimls', 'rnix'}

for _, server in ipairs(servers) do
    lspconfig[server].setup {on_init = custom_init, on_attach = custom_attach, capabilities = capabilities, flags = {debounce_text_changes = 150}}
end
