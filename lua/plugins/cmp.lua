return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-emoji",
        "jc-doyle/cmp-pandoc-references",
        "kdheepak/cmp-latex-symbols",
        "f3fora/cmp-spell",
        { "zbirenbaum/copilot-cmp", lazy = true },
    },
    opts = function(_, opts)
        local cmp = require "cmp"
        local compare = require "cmp.config.compare"
        local luasnip = require "luasnip"
        local copilot_cmp = require "copilot_cmp.comparators"

        local has_words_before = function()
            local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
            if buftype == "prompt" then return false end
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
        end

        -- Directly set the opts table instead of using extend_tbl
        opts.sources = cmp.config.sources {
            -- { name = "copilot", priority = 1000 },
            { name = "nvim_lsp", priority = 950 },
            { name = "luasnip", priority = 900 },
            { name = "latex_symbols", priority = 800 },
            { name = "pandoc_references", priority = 750 },
            { name = "calc", priority = 700 },
            { name = "path", priority = 650 },
            { name = "emoji", priority = 600 },
            { name = "buffer", priority = 500 },
            { name = "spell", priority = 400 },
        }

        -- Directly set the sorting and mapping configurations
        opts.sorting = {
            priority_weight = 2,
            comparators = {
                copilot_cmp.prioritize, -- Added Copilot comparator
                compare.offset,
                compare.exact,
                compare.score,
                -- Custom comparator to sort completion items with leading underscores lower
                function(entry1, entry2)
                    local _, entry1_under = entry1.completion_item.label:find "^_+"
                    local _, entry2_under = entry2.completion_item.label:find "^_+"
                    entry1_under = entry1_under or 0
                    entry2_under = entry2_under or 0
                    if entry1_under > entry2_under then
                        return false
                    elseif entry1_under < entry2_under then
                        return true
                    end
                end,
                compare.kind,
                compare.sort_text,
                compare.length,
                compare.order,
            },
        }

        opts.mapping = {
            -- Navigate up in the completion menu while in insert mode
            ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },

            -- Navigate down in the completion menu while in insert mode
            ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },

            -- Alternative to <C-p> for navigating up in the completion menu in insert mode
            ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },

            -- Alternative to <C-n> for navigating down in the completion menu in insert mode
            ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },

            -- Disable a specific key mapping for cmp (here, <C-y> is disabled)
            ["<C-y>"] = cmp.config.disable,

            -- Abort the completion menu in insert mode and close it in command mode
            ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },

            -- Confirm the selected completion item without selecting it
            ["<CR>"] = cmp.mapping.confirm { select = false },

            -- On Tab press, if the completion menu is visible and there are words before the cursor,
            -- select the next item in the completion menu, otherwise perform the default Tab action
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() and has_words_before() then
                    cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { "i", "s" }),

            -- On Shift-Tab press, if the completion menu is visible, select the previous item,
            -- if there's a jumpable snippet to the left, jump to it, otherwise perform the default Shift-Tab action
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),

            -- On Control-U press, if the completion menu is visible, undo the last change and abort the completion menu,
            -- otherwise perform the default Control-U action
            ["<C-u>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-g>u<C-u>", true, false, true), "n", true)
                    cmp.abort()
                else
                    fallback()
                end
            end, { "i", "c" }),
        }

        return opts
    end,
}
