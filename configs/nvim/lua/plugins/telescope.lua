local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case"},
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            prompt_position = "bottom",
            width = 0.75,
            preview_cutoff = 120,
            horizontal = {mirror = false, preview_width = 0.5},
            vertical = {mirror = false}
        },
        file_sorter = require"telescope.sorters".get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require"telescope.sorters".get_generic_fuzzy_sorter,
        path_display = {},
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        file_previewer = require"telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require"telescope.previewers".vim_buffer_vimgrep.new,
        qflist_previewer = require"telescope.previewers".vim_buffer_qflist.new
    },
    extensions = {
        media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg" -- find command (defaults to `fd`)
        }
    },
    pickers = {
        git_commits = {
            mappings = {
                i = {
                    ["<CR>"] = function(prompt_bufnr)
                        actions.close(prompt_bufnr)
                        local value = actions.get_selected_entry(prompt_bufnr).value
                        -- changes from commit against current index
                        vim.cmd('DiffviewOpen ' .. value)
                    end
                }
            }
        },
        git_bcommits = {
            mappings = {
                i = {
                    -- change from current commit against current index specific file
                    ["<CR>"] = function(prompt_bufnr)
                        actions.close(prompt_bufnr)
                        local value = actions.get_selected_entry(prompt_bufnr).value
                        vim.cmd('DiffviewOpen ' .. value .. ' -- %')
                    end
                }
            }
        }
    }
})

-- TODO: add dap integration with telescope
telescope.load_extension("media_files")
