-- Suppress lspconfig deprecation warnings for now
-- TODO: Migrate to vim.lsp.config when nvim-lspconfig v3.0.0 is released
local lspconfig = require("lspconfig")

-- Disable deprecation warnings globally for lspconfig server access
local original_deprecate = vim.deprecate
vim.deprecate = function() end

-- Configure diagnostic signs using modern vim.diagnostic.config
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

-----------------------------------------------------
-- Handler overrides
-----------------------------------------------------

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.handlers["textDocument/publishDiagnostics"], {
	underline = true,
	virtual_text = { prefix = "", spacing = 0 },
	signs = true,
	update_in_insert = false,
})

-----------------------------------------------------
-- Custom on_attach / capabilities
-----------------------------------------------------

-- Add LSP Snippets capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Got this from tjdevries/config_manager
local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(option, value)
		vim.api.nvim_set_option_value(option, value, { buf = bufnr })
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", opts)
	buf_set_keymap("n", "gn", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "gp", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)

	if client.server_capabilities.codeActionProvider then
		buf_set_keymap("n", "<localleader>a", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		buf_set_keymap("v", "<localleader>a", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	end

	if client.server_capabilities.hoverProvider then
		buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	end
	if client.server_capabilities.declarationProvider then
		buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	end
	if client.server_capabilities.implementationProvider then
		buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	end
	if client.server_capabilities.referencesProvider then
		buf_set_keymap("n", "gr", "<Cmd>Telescope lsp_references<CR>", opts)
	end
	if client.server_capabilities.typeDefinitionProvider then
		buf_set_keymap("n", "gt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	end
	if client.server_capabilities.renameProvider then
		buf_set_keymap("n", "<localleader>r", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
	end
	if client.server_capabilities.signatureHelpProvider then
		buf_set_keymap("n", "gs", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	end

	-- Set document highlight using illuminate
	if client.server_capabilities.documentHighlightProvider then
		require("illuminate").on_attach(client)
	end

	-- TODO: codelens integration

	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.documentFormattingProvider then
		buf_set_keymap("n", "<localleader>f", "<Cmd>lua vim.lsp.buf.format()<CR>", opts)
		buf_set_keymap("v", "<localleader>f", "<Cmd>lua vim.lsp.buf.format()<CR>", opts)
	end

	print("'" .. client.name .. "' server attached")
end

-----------------------------------------------------
-- go LSP
-----------------------------------------------------

lspconfig.gopls.setup({
	cmd = { "gopls", "--remote=auto" },
	on_attach = custom_attach,
	capabilities = capabilities,
	init_options = { usePlaceholders = true, completeUnimported = true },
	flags = { debounce_text_changes = 150 },
})

-----------------------------------------------------
-- lua LSP
-----------------------------------------------------

lspconfig.lua_ls.setup({
	-- cmd = {"lua-language-server", "-E", "/usr/share/lua-language-server/main.lua"},
	cmd = { "lua-language-server" },
	on_attach = function(client, bufnr)
		-- Disable formatting, use stylua instead
		client.server_capabilities.documentFormattingProvider = false
		custom_attach(client, bufnr)
	end,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
			diagnostics = { globals = { "vim", "packer_plugins" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
			telemetry = { enable = false },
		},
	},
	flags = { debounce_text_changes = 150 },
})

-----------------------------------------------------
-- yaml LSP
-----------------------------------------------------

lspconfig.yamlls.setup({
	on_attach = custom_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
				-- ["https://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
				["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
				["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
				-- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
				-- kubernetes = "*.{yml,yaml}",
			},
			schemaStore = { enable = true },
		},
	},
	flags = { debounce_text_changes = 150 },
	filetypes = { "yaml" },
})

-----------------------------------------------------
-- helm-ls LSP
-----------------------------------------------------

lspconfig.helm_ls.setup({
	on_attach = custom_attach,
	capabilities = capabilities,
	settings = {
		yamlls = {
			enabled = true,
		},
	},
	flags = { debounce_text_changes = 150 },
	filetypes = { "helm", "helmfile" },
})
-- INFO: Workaround to fix yamlls lsp in helm ft
vim.api.nvim_create_autocmd({ "Filetype" }, {
	pattern = { "helm" },
	command = "LspRestart",
})

-----------------------------------------------------
-- ts_ls LSP
-----------------------------------------------------

lspconfig.ts_ls.setup({
	on_attach = function(client, bufnr)
		-- Disable tsserver formatting, use prettier in none-ls instead
		client.server_capabilities.documentFormattingProvider = false
		custom_attach(client, bufnr)
	end,
	capabilities = capabilities,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	flags = { debounce_text_changes = 150 },
})

-----------------------------------------------------
-- Bash LSP
-----------------------------------------------------

lspconfig.bashls.setup({
	on_init = custom_init,
	on_attach = custom_attach,
	capabilities = capabilities,
	filetypes = { "sh", "zsh" },
})

-----------------------------------------------------
-- terraform LSP
-----------------------------------------------------

lspconfig.terraformls.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.signatureHelpProvider = false
		custom_attach(client, bufnr)
	end,
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
})

-----------------------------------------------------
-- None LSP
-----------------------------------------------------

local none_ls = require("null-ls")

local formatting = none_ls.builtins.formatting
local diagnostics = none_ls.builtins.diagnostics
local code_actions = none_ls.builtins.code_actions

none_ls.setup({
	sources = {
		-- Javascript, Typescript
		formatting.prettier,
		-- Python
		formatting.black,
		formatting.isort,
		-- proto
		formatting.protolint,
		-- sh
		formatting.shfmt,
		-- lua
		formatting.stylua,
		-- general
		code_actions.refactoring,
		diagnostics.codespell,
	},
	on_attach = custom_attach,
})

-----------------------------------------------------
-- general LSP
-----------------------------------------------------

-- Available LSP https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local servers = { "dockerls", "rust_analyzer", "pyright", "vimls" }

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		on_init = custom_init,
		on_attach = custom_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
	})
end

-- Restore original deprecate function after all LSP setup
vim.deprecate = original_deprecate
