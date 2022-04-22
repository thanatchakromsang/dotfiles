local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- load snippets from runtimepath, eg. friendly-snippets.
require("luasnip.loaders.from_vscode").load()

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
                -- elseif cmp.visible() then
                --     cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
                -- elseif cmp.visible() then
                --     cmp.select_prev_item()
            else
                fallback()
            end
        end, {"i", "s"})
    }),
    sources = cmp.config.sources({
        {name = 'luasnip'}, {name = 'nvim_lsp'}, {
            -- Completion from visible buffers
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do bufs[vim.api.nvim_win_get_buf(win)] = true end
                    return vim.tbl_keys(bufs)
                end
            }
        }, {name = 'treesitter'}, {name = 'path'}
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[Lsp]',
                path = '[Filesystem]',
                spell = '[Spelling]',
                treesitter = '[Treesitter]',
                luasnip = '[LuaSnip]'
            })[entry.source.name]
            vim_item.kind = ({
                Text = ' Text',
                Method = ' Method',
                Function = ' Function',
                Constructor = ' Constructor',
                Field = 'ﰠ Field',
                Variable = ' Variable',
                Class = 'ﴯ Class',
                Interface = ' Interface',
                Module = ' Module',
                Property = 'ﰠ Property',
                Unit = '塞 Unit',
                Value = ' Value',
                Enum = ' Enum',
                Keyword = ' Keyword',
                Snippet = ' Snippet',
                Color = ' Color',
                File = ' File',
                Reference = ' Reference',
                Folder = ' Folder',
                EnumMember = ' EnumMember',
                Constant = ' Constant',
                Struct = 'פּ Struct',
                Event = ' Event',
                Operator = ' Operator',
                TypeParameter = 'TypeParameter'
            })[vim_item.kind]
            return vim_item
        end
    }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {mapping = cmp.mapping.preset.cmdline(), sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})})
