-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

    -- == Examples of Adding Plugins ==

    -- "andweeb/presence.nvim",
    -- {
    --     "ray-x/lsp_signature.nvim",
    --     event = "BufRead",
    --     config = function() require("lsp_signature").setup() end,
    -- },

    -- == Examples of Overriding Plugins ==

    -- customize alpha options
    {
        "goolord/alpha-nvim",
        opts = function(_, opts)
            -- Define your existing logo
            local custom_logo = {
                [[                                                    ]],
                [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
                [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
                [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
                [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
                [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
                [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
                [[                                                    ]],
                [[                                                    ]],
            }

            -- Function to center and crop the logo
            local function center_and_crop_logo(logo)
                local width = vim.o.columns
                local cropped_logo = {}
                for _, line in ipairs(logo) do
                    local line_length = vim.fn.strdisplaywidth(line)
                    if line_length > width then
                        -- Crop the line if it is longer than the window width
                        local crop_start = math.floor((line_length - width) / 2) + 1
                        local crop_end = crop_start + width - 1
                        line = string.sub(line, crop_start, crop_end)
                    end
                    -- Center the line by adding equal padding to both sides
                    local padding = (width - vim.fn.strdisplaywidth(line)) / 2
                    local padding_left = math.floor(padding)
                    local padding_right = math.ceil(padding)
                    line = string.rep(" ", padding_left) .. line .. string.rep(" ", padding_right)
                    table.insert(cropped_logo, line)
                end
                return table.concat(cropped_logo, "\n")
            end

            -- Function to center a single line of text
            local function center_text(text)
                local width = vim.o.columns
                local text_length = vim.fn.strdisplaywidth(text)
                local padding = (width - text_length) / 2
                local padding_left = math.floor(padding)
                local padding_right = math.ceil(padding)
                return string.rep(" ", padding_left) .. text .. string.rep(" ", padding_right)
            end

            -- Greeting function
            local function getGreeting(name)
                local tableTime = os.date "*t"
                local datetime = os.date " %Y-%m-%d   %I:%M %p"
                local hour = tableTime.hour
                local greetingsTable = {
                    [1] = "  Sleep well",
                    [2] = "  Good morning",
                    [3] = "  Good afternoon",
                    [4] = "  Good evening",
                    [5] = "󰖔  Good night",
                }
                local greetingIndex = 0
                if hour == 23 or hour < 7 then
                    greetingIndex = 1
                elseif hour < 12 then
                    greetingIndex = 2
                elseif hour >= 12 and hour < 18 then
                    greetingIndex = 3
                elseif hour >= 18 and hour < 21 then
                    greetingIndex = 4
                elseif hour >= 21 then
                    greetingIndex = 5
                end
                return datetime .. "\t" .. greetingsTable[greetingIndex] .. ", " .. name
            end

            local userName = "Andrea"
            local greeting = getGreeting(userName)
            local centered_greeting = center_text(greeting)

            -- Adjust padding in the layout
            opts.config.layout = {
                { type = "padding", val = 4 }, -- Adjust top padding
                opts.section.header,
                { type = "padding", val = 3 }, -- Adjust padding between header and buttons
                opts.section.buttons,
                { type = "padding", val = 2 }, -- Adjust padding between buttons and footer
                opts.section.footer,
            }

            -- Convert the custom_logo table to a string and center the greeting
            local logo = center_and_crop_logo(custom_logo)
            opts.section.header.val = vim.split(logo .. "\n" .. centered_greeting, "\n")

            -- Update logo and greeting when window is resized
            vim.api.nvim_create_autocmd("VimResized", {
                pattern = "*",
                callback = function()
                    -- Recalculate the centered and cropped logo and centered greeting
                    opts.section.header.val =
                        vim.split(center_and_crop_logo(custom_logo) .. "\n" .. center_text(getGreeting(userName)), "\n")
                end,
            })

            return opts
        end,
    },

    -- You can disable default plugins as follows:
    { "max397574/better-escape.nvim", enabled = false },

    -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
    {
        "L3MON4D3/LuaSnip",
        config = function(plugin, opts)
            require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom luasnip configuration such as filetype extend or custom snippets
            local luasnip = require "luasnip"
            luasnip.filetype_extend("javascript", { "javascriptreact" })
        end,
    },

    {
        "windwp/nvim-autopairs",
        config = function(plugin, opts)
            require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom autopairs configuration such as custom rules
            local npairs = require "nvim-autopairs"
            local Rule = require "nvim-autopairs.rule"
            local cond = require "nvim-autopairs.conds"
            npairs.add_rules(
                {
                    Rule("$", "$", { "tex", "latex" })
                        -- don't add a pair if the next character is %
                        :with_pair(cond.not_after_regex "%%")
                        -- don't add a pair if  the previous character is xxx
                        :with_pair(
                            cond.not_before_regex("xxx", 3)
                        )
                        -- don't move right when repeat character
                        :with_move(cond.none())
                        -- don't delete if the next character is xx
                        :with_del(cond.not_after_regex "xx")
                        -- disable adding a newline when you press <cr>
                        :with_cr(cond.none()),
                },
                -- disable for .vim files, but it work for another filetypes
                Rule("a", "a", "-vim")
            )
        end,
    },

    -- ==========================================================

    -- General Structure:
    -- Each plugin is structured with the following details:
    -- 1. Plugin name and link
    -- 2. Dependencies (if any)
    -- 3. Options/Configuration
    -- 4. Event triggers

    -- Events:
    --  VeryLazy: Load on startup
    --  User AstroFile: Load on opening a file
    --  BufEnter *.lua: Load on opening a lua file
    --  InsertEnter: Load on entering insert mode
    --  LspAttach: Triggered after starting an LSP.

    -- TODO: Ensure to test each configuration after modification

    -- Plugin List Begins Here:
    -- ==========================================================
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "User AstroFile",
        config = function()
            require("treesitter-context").setup {
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = "-",
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
        end,
    },

    -- ==========================================================

    -- barbar (tabline)
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "lewis6991/gitsigns.nvim",
        },
        opts = {
            -- configurations go here
            animation = true,
            insert_at_start = false,
            icons = {
                -- Configure the base icons on the bufferline.
                -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
                buffer_index = false,
                buffer_number = false,
                button = "",
                -- Enables / disables diagnostic symbols
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
                    [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
                    [vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
                    [vim.diagnostic.severity.HINT] = { enabled = true },
                },
                gitsigns = {
                    added = { enabled = true, icon = "+" },
                    changed = { enabled = true, icon = "~" },
                    deleted = { enabled = true, icon = "-" },
                },
                filetype = {
                    -- Sets the icon's highlight group.
                    -- If false, will use nvim-web-devicons colors
                    custom_colors = false,

                    -- Requires `nvim-web-devicons` if `true`
                    enabled = true,
                },
                -- separator = { left = "▎", right = "" },

                -- If true, add an additional separator at the end of the buffer list
                -- separator_at_end = true,

                -- Configure the icons on the bufferline when modified or pinned.
                -- Supports all the base icon options.
                modified = { button = "◉" },
                pinned = { button = "", filename = true },

                -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
                -- preset = "powerline",

                -- Configure the icons on the bufferline based on the visibility of a buffer.
                -- Supports all the base icon options, plus `modified` and `pinned`.
                alternate = { filetype = { enabled = false } },
                current = { buffer_index = true },
                inactive = { button = "×" },
                visible = { modified = { buffer_number = false } },
            },
        },
        event = "VeryLazy",
    }, -- End of 'barbar.nvim'

    -- ==========================================================

    -- Scrollview
    {
        "dstein64/nvim-scrollview",
        config = function()
            -- Configuration goes here (leave empty to use default settings)
        end,
        event = "User AstroFile",
    }, -- End of 'nvim-scrollview'

    -- ==========================================================

    -- Code Runner
    {
        "CRAG666/code_runner.nvim",
        opts = {
            mode = "toggleterm",
            focus = true,
            startinsert = true,
            filetype = {
                html = {
                    "cd $dir && live-server $fileName",
                },
            },
        },
        event = "User AstroFile",
    }, -- End of 'code_runner.nvim'

    -- ==========================================================

    -- Numb (line numbers)
    {
        "nacro90/numb.nvim",
        opts = {
            -- Configuration goes here (leave empty to use default settings)
        },
        event = "User AstroFile",
    }, -- End of 'numb.nvim'

    -- ==========================================================

    -- Gen (ollama)
    {
        "David-Kunz/gen.nvim",
        opts = {
            model = "llama3", -- The default model to use.
            display_mode = "float", -- The display mode. Can be "float" or "split".
            show_prompt = true, -- Shows the Prompt submitted to Ollama.
            show_model = true, -- Displays which model you are using at the beginning of your chat session.
            no_auto_close = true, -- Never closes the window automatically.
        },
        event = "User AstroFile",
    }, -- End of 'gen.nvim'

    -- ==========================================================

    { -- searchbox
        "VonHeikemen/searchbox.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            -- Configuration goes here (leave empty to use default settings)
        },
        event = "User AstroFile",
    }, -- End of 'searchbox.nvim'

    -- ==========================================================

    { -- vim-be-good
        "ThePrimeagen/vim-be-good",
        config = function()
            --  Configuration goes here (leave empty to use default settings)
        end,
        event = "VeryLazy",
    }, -- End of 'vim-be-good'

    -- ==========================================================

    { -- copilot cmp
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup {
                event = { "InsertEnter", "LspAttach" },
                fix_pairs = true,
            }
        end,
        event = "User AstroFile",
    },

    -- ==========================================================

    { -- goto preview
        "rmagatti/goto-preview",
        opts = {
            width = 120, -- Width of the floating window
            height = 15, -- Height of the floating window
            border = { "↖", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Border characters of the floating window
            -- border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
            default_mappings = false, -- Bind default mappings
            debug = false, -- Print debug information
            opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
            resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
            post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
            post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
            references = { -- Configure the telescope UI for slowing the references cycling window.
                telescope = require("telescope.themes").get_dropdown { hide_preview = false },
            },
            -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
            focus_on_open = true, -- Focus the floating window when opening it.
            dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
            force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
            bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
            stack_floating_preview_windows = true, -- Whether to nest floating windows
            preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
        },
        event = "User AstroFile",
    },

    -- ==========================================================

    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- ==========================================================

    {
        "patrickpichler/hovercraft.nvim",

        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },

        opts = function()
            return {
                window = {
                    border = "rounded",
                },

                -- keys = {
                --     { "<C-u>", function() require("hovercraft").scroll { delta = -4 } end },
                --     { "<C-d>", function() require("hovercraft").scroll { delta = 4 } end },
                --     { "<TAB>", function() require("hovercraft").hover_next() end },
                --     { "<S-TAB>", function() require("hovercraft").hover_next { step = -1 } end },
                -- },
            }
        end,
    },
    -- ==========================================================

    {
        "fei6409/log-highlight.nvim",
        config = function() require("log-highlight").setup {} end,
    },

    -- ==========================================================

    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    { -- optional completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },

    -- ==========================================================

    -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim

    -- {
    --     "ThePrimeagen/harpoon",
    --     opts = {
    --         -- Configuration goes here (leave empty to use default settings)
    --     },
    --     event = "VeryLazy",
    -- },

    -- ==========================================================

    -- { -- Oceanic Next (theme)
    --     "mhartington/oceanic-next",
    --     config = function()
    --         -- Configuration goes here (leave empty to use default settings)
    --     end,
    --     event = "VeryLazy",
    -- }, -- End of 'oceanic-next'

    -- ==========================================================

    -- "andweeb/presence.nvim",
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("lsp_signature").setup()
    --   end,
    -- },

    -- ==========================================================

    -- BREAKS CODE RUNNER PLUGIN (aesthetically only; both plugins still work)

    -- { -- Barbecue (winbar)
    --   "utilyre/barbecue.nvim",
    --   dependencies = {
    --     "SmiteshP/nvim-navic",
    --     "nvim-tree/nvim-web-devicons", -- optional dependency
    --   },
    --   opts = {
    --     -- configurations go here
    --   },
    --   event = "VeryLazy",
    -- }, -- End of 'barbecue.nvim'

    -- ==========================================================

    -- { -- Lualine (statusline)
    --   "nvim-lualine/lualine.nvim",
    --   dependencies = {
    --     "nvim-tree/nvim-web-devicons",
    --   },
    --   opts = {
    --     -- configurations go here
    --   },
    --   event = "User AstroFile",
    -- }, -- End of 'lualine.nvim'

    -- ==========================================================
}
