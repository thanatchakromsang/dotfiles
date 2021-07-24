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

-- vim.api.nvim_command [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=False})]]

vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then vim.cmd [[noautocmd :update]] end
    end
end

-----------------------------------------------------
-- Symbol overrides
-----------------------------------------------------
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

-----------------------------------------------------
-- Custom on_attach / capabilities
-----------------------------------------------------

-- Add LSP Snippets capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Got this from tjdevries/config_manager
local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gd", ":Telescope lsp_definitions<CR>", opts)
    buf_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<localleader>a", ":lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("v", "<localleader>a", ":lua vim.lsp.buf.range_code_action()<CR>", opts)
    buf_set_keymap("n", "gn", ":lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "gp", ":lua vim.lsp.diagnostic.goto_prev()<CR>", opts)

    if client.resolved_capabilities.implementation then buf_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts) end
    if client.resolved_capabilities.find_references then buf_set_keymap("n", "gr", ":Telescope lsp_references<CR>", opts) end
    if client.resolved_capabilities.type_definition then buf_set_keymap("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>", opts) end
    if client.resolved_capabilities.rename then buf_set_keymap("n", "<localleader>r", ":lua vim.lsp.buf.rename()<CR>", opts) end
    if client.resolved_capabilities.signature_help then
        buf_set_keymap("n", "gs", ":lua vim.lsp.buf.signature_help()<CR>", opts)
        vim.api.nvim_command [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
          hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
    ]], false)
    end

    -- -- autoformat after save
    -- if client.resolved_capabilities.document_formatting then
    --     vim.api.nvim_command [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 300)]]
    -- end

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<localleader>f", ":lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<localleader>f", ":lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    print("'" .. client.name .. "' server attached")
end

-----------------------------------------------------
-- go LSP
-----------------------------------------------------

lspconfig.gopls.setup {
    cmd = {"gopls", "--remote=auto"},
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        custom_attach(client)
    end,
    capabilities = capabilities,
    init_options = {usePlaceholders = true, completeUnimported = true}
}

-----------------------------------------------------
-- lua LSP
-----------------------------------------------------

lspconfig.sumneko_lua.setup {
    cmd = {"/usr/bin/lua-language-server", "-E", "/usr/share/lua-language-server/main.lua"},
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim', 'packer_plugins'}},
            workspace = {library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}},
            telemetry = {enable = false}
        }
    }
}

-----------------------------------------------------
-- yaml LSP
-----------------------------------------------------

lspconfig.yamlls.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            -- schemas = {
            --   Kubernetes = "*.yaml"
            -- },
            schemaStore = {enable = true}
        }
    }
}

-----------------------------------------------------
-- tsserver LSP
-----------------------------------------------------

lspconfig.tsserver.setup {
    on_attach = function(client)
        -- Disable tsserver formatting, use prettier in efm lsp instead
        client.resolved_capabilities.document_formatting = false
        custom_attach(client)
    end,
    capabilities = capabilities,
    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"}
}

-----------------------------------------------------
-- efm LSP
-----------------------------------------------------

local luafmt = {formatCommand = "lua-format -i --column-limit=150", formatStdin = true}

local isort = {formatCommand = "isort --quiet -", formatStdin = true}
local yapf = {formatCommand = "yapf --quiet", formatStdin = true}

-- JavaScript/React/TypeScript
-- local prettier = {formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}
local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}
local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local shellcheck = {LintCommand = 'shellcheck -f gcc -x', lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}}

local shfmt = {formatCommand = 'shfmt -ci -s -bn', formatStdin = true}

local golint = {lintCommand = "golint", lintIgnoreExitCode = true, lintFormats = {"%f:%l:%c: %m"}}

local goimports = {formatCommand = "goimports", formatStdin = true}

-- local misspell = {
--     lintCommand = "misspell",
--     lintIgnoreExitCode = true,
--     lintStdin = true,
--     lintFormats = {"%f:%l:%c: %m"}
-- }

local markdownlint = {lintCommand = 'markdownlint -s', lintStdin = true, lintFormats = {'%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'}}

local languages = {
    lua = {luafmt},
    go = {golint, goimports},
    typescript = {prettier, eslint},
    javascript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    ["javascript.jsx"] = {prettier, eslint},
    ["typescript.tsx"] = {prettier, eslint},
    yaml = {prettier},
    json = {prettier},
    html = {prettier},
    scss = {prettier},
    css = {prettier},
    markdown = {markdownlint},
    python = {isort, yapf},
    sh = {shfmt, shellcheck}
}

lspconfig.efm.setup {
    -- root_dir = function() return vim.fn.getcwd() end,
    -- cmd = {'efm-langserver', '-logfile', '/tmp/efm.log', '-loglevel', '5'}, -- debug cmd
    on_attach = custom_attach,
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = vim.tbl_keys(languages),
    settings = {rootMarkers = {"package.json", ".git"}, languages = languages, lintDebounce = 500}
}

-----------------------------------------------------
-- Bash LSP
-----------------------------------------------------

lspconfig.bashls.setup {on_init = custom_init, on_attach = custom_attach, capabilities = capabilities, filetypes = {"sh", "zsh"}}

-----------------------------------------------------
-- terraform LSP
-----------------------------------------------------

lspconfig.terraformls.setup {
    on_attach = function(client)
        client.resolved_capabilities.signature_help = false
        custom_attach(client)
    end,
    capabilities = capabilities
}

-----------------------------------------------------
-- general LSP
-----------------------------------------------------

local servers = {'dockerls', 'rust_analyzer', 'pyright', 'vimls', 'jsonls', 'graphql'}

for _, server in ipairs(servers) do lspconfig[server].setup {on_init = custom_init, on_attach = custom_attach, capabilities = capabilities} end
