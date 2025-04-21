return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
            {
                "s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
                version = "2.*",
                config = function()
                    require("window-picker").setup {
                        filter_rules = {
                            include_current_win = false,
                            autoselect_one = true,
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { "terminal", "quickfix" },
                            },
                        },
                    }
                end,
            },
        },
        opts = {
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified",
                },
                git_status = {
                    symbols = {
                        -- -- Change type
                        -- added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        -- modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                        -- deleted = "✖", -- this can only be used in the git_status source
                        -- renamed = "󰁕", -- this can only be used in the git_status source
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "󰄱",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            filesystem = {
                filtered_items = {
                    visible = true, -- when true, they will just be displayed differently than normal items
                    -- hide_dotfiles = true,
                    -- hide_gitignored = true,
                    -- hide_hidden = true, -- only works on Windows for hidden files/directories
                    -- hide_by_name = {
                    --     --"node_modules"
                    -- },
                    -- hide_by_pattern = { -- uses glob style patterns
                    --     --"*.meta",
                    --     --"*/src/*/tsconfig.json",
                    -- },
                    -- always_show = { -- remains visible even if other settings would normally hide it
                    --     --".gitignored",
                    -- },
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                        ".DS_Store",
                        "thumbs.db",
                    },
                    -- never_show_by_pattern = { -- uses glob style patterns
                    --     --".null-ls_*",
                    -- },
                },
            },
        },
    },
}
