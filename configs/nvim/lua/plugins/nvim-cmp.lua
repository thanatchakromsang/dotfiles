local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- load snippets from runtimepath, eg. friendly-snippets.
require("luasnip.loaders.from_vscode").load()

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key) vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true) end

cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                feedkey("<C-n>")
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                feedkey("<C-p>")
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"})
    },
    sources = {{name = 'luasnip'}, {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'treesitter'}, {name = 'path'}},
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                path = '[Filesystem]',
                spell = '[Spelling]',
                treesitter = '[Treesitter]',
                luasnip = '[LuaSnip]'
            })[entry.source.name]
            vim_item.kind = ({
                Text = '(Text)',
                Method = '(Method)',
                Function = '(Function)',
                Constructor = '(Constructor)',
                Field = '(Field)',
                Variable = '(Variable)',
                Class = '(Class)',
                Interface = '(Interface)',
                Module = '(Module)',
                Property = '(Property)',
                Unit = '(Unit)',
                Value = '(Value)',
                Enum = '(Enum)',
                Keyword = '(Keyword)',
                Snippet = '(Snippet)',
                Color = '(Color)',
                File = '(File)',
                Reference = '(Reference)',
                Folder = '(Folder)',
                EnumMember = '(EnumMember)',
                Constant = '(Constant)',
                Struct = '(Struct)',
                Event = '(Event)',
                Operator = '(Operator)',
                TypeParameter = '(TypeParameter)'
            })[vim_item.kind]
            return vim_item
        end
    }
})
