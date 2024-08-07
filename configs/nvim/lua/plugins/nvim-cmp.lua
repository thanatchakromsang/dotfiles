local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- load snippets from runtimepath, eg. friendly-snippets.
require("luasnip.loaders.from_vscode").load()

cmp.setup({
  experimental = { ghost_text = false },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
    --
    documentation = {
      border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
      winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None'
    },
    completion = {
      border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
      winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None'
    }
  },
  preselect = cmp.PreselectMode.None,
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      -- elseif cmp.visible() then
      --   cmp.select_next_item()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      -- elseif cmp.visible() then
      --   cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" })
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, { name = 'luasnip' }, {
      -- Completion from visible buffers
      name = 'buffer',
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do bufs[vim.api.nvim_win_get_buf(win)] = true end
          return vim.tbl_keys(bufs)
        end
      }
    },
    -- { name = 'treesitter' },
    { name = 'path' }
  }),
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer = '[BUF]',
        nvim_lsp = '[LSP]',
        path = '[PATH]',
        spell = '[SPELL]',
        -- treesitter = '[Treesitter]',
        luasnip = '[LuaSnip]'
      })[entry.source.name]
      vim_item.kind = ({
        Text = '󰉿 Text',
        Method = '󰆧 Method',
        Function = '󰊕 Function',
        Constructor = ' Constructor',
        Field = '󰜢 Field',
        Variable = ' Variable',
        Class = '󰠱 Class',
        Interface = ' Interface',
        Module = ' Module',
        Property = '󰜢 Property',
        Unit = '󰑭 Unit',
        Value = '󰎠 Value',
        Enum = ' Enum',
        Keyword = '󰌋 Keyword',
        Snippet = ' Snippet',
        Color = '󰏘 Color',
        File = '󰈙 File',
        Reference = '󰈇 Reference',
        Folder = '󰉋 Folder',
        EnumMember = ' EnumMember',
        Constant = '󰏿 Constant',
        Struct = '󰙅 Struct',
        Event = ' Event',
        Operator = '󰆕 Operator',
        TypeParameter = 'TypeParameter'
      })[vim_item.kind]
      return vim_item
    end
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })
cmp.setup.cmdline('?', { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', { mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }) })
