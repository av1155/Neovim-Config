-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
        -- Configure core features of AstroNvim
        features = {
            large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
            autopairs = true, -- enable autopairs at start
            cmp = true, -- enable completion at start
            diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
            highlighturl = true, -- highlight URLs at start
            notifications = true, -- enable notifications at start
        },

        -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
        diagnostics = {
            virtual_text = {
                prefix = "",
            },
            underline = true,
            severity_sort = true,
        },

        -- vim options can be configured here
        options = {
            opt = { -- vim.opt.<key>
                relativenumber = false, -- sets vim.opt.relativenumber
                number = true, -- sets vim.opt.number
                spell = false, -- sets vim.opt.spell
                signcolumn = "auto", -- sets vim.opt.signcolumn to auto
                wrap = true, -- sets vim.opt.wrap

                -- Custom options:
                showbreak = "↪ ",
                clipboard = "unnamedplus", -- Use the system clipboard
                tabstop = 4, -- Number of spaces a <Tab> counts for.
                softtabstop = 4, -- Number of spaces a <Tab> counts for while performing editing operations.
                shiftwidth = 4, -- Spaces used for each step of (auto)indent.
                expandtab = true, -- Use spaces instead of tabs.
                -- list = true,
                -- listchars = {
                --     tab = "→ ",
                --     extends = "⟩",
                --     precedes = "⟨",
                --     trail = "·",
                --     nbsp = "␣",
                --     eol = "↲",
                -- },
            },
            g = { -- vim.g.<key>
                -- configure global vim variables (vim.g)
                -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
                -- This can be found in the `lua/lazy_setup.lua` file

                -- Add the following line to set the dynamic Python executable for pynvim
                python3_host_prog = os.getenv "NVIM_PYTHON_PATH",
            },
        },

        -- Mappings can be configured through AstroCore as well.
        -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized

        --[[ These tables are a direct conversion to the vim.keymap.set({mode}, {lhs}, {rhs}, {opts}) Lua API. The first key into the table is the {mode}, the second key into the table is the {lhs}, and the element there is the {opts} table with the {rhs} in the first key. Also AstroLSP supports adding a cond key which can dictate when the mapping should be attached. ]]

        mappings = {
            -- Normal mode mappings
            n = {
                -- OVERRIDE DEFAULT NAMES/DESCRIPTIONS BY COMMUNITY
                ["<Leader>a"] = { desc = "󱚤 Avante" },
                ["<leader>f"] = { name = "󰍉 Find" },

                -- CUSTOM KEYMAPS TO SPECIFIC THINGS:
                ["<CR>"] = { ":", desc = "Open command line", noremap = true },
                ["<leader>s"] = { ":SearchBoxReplace<CR>", desc = "Search and Replace" },
                ["<leader>W"] = { ":noautocmd w<CR>", desc = "Save without formatting" },
                -- ["<A-s>"] = { "<Cmd>w<CR>", desc = "Save" }, -- set to C-s in polish.lua

                -- Bindings for split windows
                ["\\"] = { "<cmd>vsplit<CR>", desc = "Vertical Split" },
                ["-"] = { "<cmd>split<CR>", desc = "Horizontal Split" },

                -- Open yazi in a floating terminal
                ["<leader>y"] = {
                    function()
                        local Terminal = require("toggleterm.terminal").Terminal
                        local yazi = Terminal:new { cmd = "yazi", hidden = true, direction = "float" }
                        yazi:toggle()
                    end,
                    desc = "Open Yazi file manager",
                },

                ["<leader>`"] = { "<Cmd>Oil<CR>", desc = "Open Oil" },

                ["<leader>ge"] = {
                    function()
                        -- Insert the Go error handling snippet with a print statement
                        vim.api.nvim_put({
                            "if err != nil {",
                            "    return err",
                            "}",
                        }, "l", true, true)

                        -- Get the current cursor position
                        local pos = vim.api.nvim_win_get_cursor(0)

                        -- Place the cursor in the middle of the block for further edits
                        vim.api.nvim_win_set_cursor(0, { pos[1] - 2, 4 })
                    end,
                    desc = "Insert Go error handling with print statement",
                },

                -- Dadbod:
                ["<leader>lu"] = { "<Cmd>DBUIToggle<Cr>", desc = "Dadbod UI" },

                -- Buffer navigation and management
                ["<s-tab>"] = { "<Cmd>BufferPrevious<CR>", desc = "Move to previous buffer" },
                ["<tab>"] = { "<Cmd>BufferNext<CR>", desc = "Move to next buffer" },
                ["<A-<>"] = { "<Cmd>BufferMovePrevious<CR>", desc = "Re-order to previous buffer" },
                ["<A->>"] = { "<Cmd>BufferMoveNext<CR>", desc = "Re-order to next buffer" },
                ["<A-1>"] = { "<Cmd>BufferGoto 1<CR>", desc = "Goto buffer 1" },
                ["<A-2>"] = { "<Cmd>BufferGoto 2<CR>", desc = "Goto buffer 2" },
                ["<A-3>"] = { "<Cmd>BufferGoto 3<CR>", desc = "Goto buffer 3" },
                ["<A-4>"] = { "<Cmd>BufferGoto 4<CR>", desc = "Goto buffer 4" },
                ["<A-5>"] = { "<Cmd>BufferGoto 5<CR>", desc = "Goto buffer 5" },
                ["<A-6>"] = { "<Cmd>BufferGoto 6<CR>", desc = "Goto buffer 6" },
                ["<A-7>"] = { "<Cmd>BufferGoto 7<CR>", desc = "Goto buffer 7" },
                ["<A-8>"] = { "<Cmd>BufferGoto 8<CR>", desc = "Goto buffer 8" },
                ["<A-9>"] = { "<Cmd>BufferGoto 9<CR>", desc = "Goto buffer 9" },
                ["<A-0>"] = { "<Cmd>BufferGoto 0<CR>", desc = "Goto buffer 0" },
                ["<A-p>"] = { "<Cmd>BufferPin<CR>", desc = "Pin/unpin buffer" },
                ["<A-c>"] = { "<Cmd>BufferClose<CR>", desc = "Close buffer" },
                -- Sort buffers
                ["<Space>bsb"] = { "<Cmd>BufferOrderByBufferNumber<CR>", desc = "Sort buffers by buffer number" },
                ["<Space>bsd"] = { "<Cmd>BufferOrderByDirectory<CR>", desc = "Sort buffers by directory" },
                ["<Space>bsl"] = { "<Cmd>BufferOrderByLanguage<CR>", desc = "Sort buffers by language" },
                ["<Space>bsw"] = { "<Cmd>BufferOrderByWindowNumber<CR>", desc = "Sort buffers by window number" },

                -- DevDocs
                ["<leader>D"] = { name = " DevDocs" },
                ["<leader>Df"] = { "<cmd>DevdocsFetch<CR>", desc = "Fetch DevDocs metadata" },
                ["<leader>Di"] = { "<cmd>DevdocsInstall<CR>", desc = "Install documentation" },
                ["<leader>Do"] = { "<cmd>DevdocsOpen<CR>", desc = "Open documentation in buffer" },
                ["<leader>DO"] = { "<cmd>DevdocsOpenFloat<CR>", desc = "Open documentation in float" },
                ["<leader>DC"] = { "<cmd>DevdocsOpenCurrent<CR>", desc = "Open current filetype doc" },
                ["<leader>Dc"] = {
                    "<cmd>DevdocsFetch<CR><cmd>DevdocsOpenCurrentFloat<CR>",
                    desc = "Open current filetype doc in float",
                },
                ["<leader>Dt"] = { "<cmd>DevdocsToggle<CR>", desc = "Toggle floating window" },
                ["<leader>Du"] = { "<cmd>DevdocsUninstall<CR>", desc = "Uninstall documentation" },
                ["<leader>DU"] = { "<cmd>DevdocsUpdate<CR>", desc = "Update documentation" },
                ["<leader>Da"] = { "<cmd>DevdocsUpdateAll<CR>", desc = "Update all documentations" },

                -- -- Harpoon mappings
                ["<leader><leader>"] = { name = "󰛢 Harpoon" },
                ["<leader><leader>1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", desc = "Harpoon File 1" },
                ["<leader><leader>2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", desc = "Harpoon File 2" },
                ["<leader><leader>3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", desc = "Harpoon File 3" },
                ["<leader><leader>4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", desc = "Harpoon File 4" },

                -- Zen Mode
                ["<leader>z"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" },

                -- stylua: ignore start
                -- Goto Preview Mappings
                ["<leader>lg"] = { name = " GoTo Preview" },
                ["<leader>lgd"] = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Go to definition" },
                ["<leader>lgt"] = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Go to type definition" },
                ["<leader>lgi"] = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "Go to implementation" },
                ["<leader>lgD"] = { "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", desc = "Go to declaration" },
                ["<leader>lgr"] = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "Go to references" },
                ["<leader>lq"] = { "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "Close GoTo preview" },
                -- stylua: ignore end

                -- GitHub Copilot mappings
                ["<leader>Z"] = { name = " Copilot" },
                ["<leader>ZE"] = { "<cmd>Copilot enable<cr>", desc = "Enable Copilot" },
                ["<leader>ZD"] = { "<cmd>Copilot disable<cr>", desc = "Disable Copilot" },
                ["<leader>ZA"] = { "<cmd>Copilot auth<cr>", desc = "Copilot Authenticator" },
                ["<leader>ZP"] = { "<cmd>Copilot panel<cr>", desc = "Open Copilot Panel" },
                ["<leader>ZT"] = { "<cmd>Copilot toggle<cr>", desc = "Toggle Copilot" },
                ["<leader>ZS"] = { "<cmd>Copilot status<cr>", desc = "Show Copilot Status" },
                ["<leader>ZV"] = { "<cmd>Copilot version<cr>", desc = "Show Copilot Version" },
                ["<leader>ZZ"] = { name = " Menu" },
                ["<leader>ZZS"] = { "<cmd>Copilot suggestion<cr>", desc = "Trigger Copilot Suggestion" },
                ["<leader>ZZA"] = { "<cmd>Copilot attach<cr>", desc = "Attach Copilot to Buffer" },
                ["<leader>ZZD"] = { "<cmd>Copilot detach<cr>", desc = "Detach Copilot from Buffer" },

                ["<leader>Ze"] = { -- Custom keybinding for enabling copilot-cmp manually
                    [[:lua require("copilot_cmp").setup(); require("cmp").setup.buffer { sources = { { name = "copilot" }, unpack(require("cmp").get_config().sources) } }<CR>]],
                    desc = "Enable Copilot-CMP for current buffer",
                    noremap = true,
                    silent = true,
                },

                ["<leader>Zd"] = { -- Custom keybinding for disabling copilot-cmp
                    [[:lua require("cmp").setup.buffer { sources = vim.tbl_filter(function(source) return source.name ~= "copilot" end, require("cmp").get_config().sources) }<CR>]],
                    desc = "Disable Copilot-CMP for current buffer",
                    noremap = true,
                    silent = true,
                },

                -- Code Runner mappings
                ["<leader>r"] = { name = " Code Runner" },
                ["<leader>rr"] = { "<cmd>RunCode<cr>", desc = "Smart Run" },
                ["<leader>rc"] = { "<cmd>RunClose<cr>", desc = "Close runner" },
                ["<leader>rp"] = { "<cmd>RunProject<cr>", desc = "Run Project" },
                ["<leader>rf"] = { "<cmd>RunFile<cr>", desc = "Run current file" },

                -- Compiler mappings
                ["<leader>ro"] = { "<cmd>CompilerOpen<cr>", desc = "Open Compiler" },
                ["<leader>rt"] = { "<cmd>CompilerToggleResults<cr>", desc = "Toggle Compiler Results" },
                ["<leader>rx"] = { "<cmd>CompilerRedo<cr>", desc = "Redo Compiler" },
                ["<leader>rk"] = { "<cmd>CompilerStop<cr>", desc = "Stop Compiler Tasks" },

                -- SnipRun mappings
                ["<leader>rs"] = { "<cmd>SnipRun<cr>", desc = "Execute Code Snippet" },
                ["<leader>ri"] = { "<cmd>SnipInfo<cr>", desc = "Snippet Info" },

                -- JavaCompileRun Script
                ["<leader>rj"] = {
                    function()
                        vim.cmd "ToggleTerm direction=float"
                        vim.defer_fn(
                            function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("jcr<CR>", true, false, true), "t", false) end,
                            10
                        ) -- Delay to ensure the terminal has opened before sending keys
                    end,
                    desc = "JavaCompileRun Script",
                },

                -- Flutter-specific mappings
                ["<leader>rg"] = { "<cmd>Telescope flutter commands<CR>", desc = "Flutter commands" },

                -- Toggle Terminal
                ["<A-z>"] = { "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle Terminal" },

                -- ScrollView mappings
                ["<leader>uv"] = { "<cmd>ScrollViewToggle<cr>", desc = "Toggle ScrollView" },
                ["<leader>uB"] = { "<cmd>ScrollViewRefresh<CR>", desc = "Refresh Scrollview" },

                -- Telescope mappings
                ["<leader>T"] = { name = " Telescope" },
                ["<leader>f/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find words in current buffer" },
                ["<leader>Tc"] = { "<cmd>Telescope neoclip<cr>", desc = "Clipboard manager" },
                ["<leader>Td"] = { "<cmd>TodoTelescope<cr>", desc = "Open TODOs in Telescope" },
                ["<leader>Tf"] = { "<cmd>TodoQuickFix<cr>", desc = "Show TODOs in Quickfix" },
                ["<leader>Tl"] = { "<cmd>TodoLocList<cr>", desc = "Show TODOs in Location List" },
                ["<leader>Tt"] = { "<cmd>TodoTrouble<cr>", desc = "List TODOs in Trouble" },

                -- Gen (Ollama) plugin mappings
                ["<leader>m"] = { name = "󰳆 Gen" },
                ["<leader>mu"] = { "<cmd>Gen<cr>", desc = "Open Gen UI" },
                ["<leader>mt"] = { "<cmd>Gen Chat<cr>", desc = "Chat" },
                ["<leader>mg"] = { "<cmd>Gen Generate<cr>", desc = "Generate" },

                -- Markdown Preview mappings
                ["<leader>M"] = { name = " Markdown Preview" },
                ["<leader>MS"] = { "<cmd>MarkdownPreview<cr>", desc = "Start Markdown Preview" },
                ["<leader>MC"] = { "<cmd>MarkdownPreviewStop<cr>", desc = "Close Markdown Preview" },
                ["<leader>MR"] = { "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Render On or Off" },

                ["<Leader>c"] = {
                    function()
                        local bufs = vim.fn.getbufinfo { buflisted = 1 }
                        require("astrocore.buffer").close(0)
                        if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start() end
                    end,
                    desc = "Close buffer",
                },

                ["<Leader>C"] = {
                    function()
                        local bufs = vim.fn.getbufinfo { buflisted = 1 }
                        require("astrocore.buffer").close(0, true)
                        if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
                    end,
                    desc = "Force close buffer",
                },

                -- navigate buffer tabs with `H` and `L`
                L = {
                    function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
                    desc = "Next buffer",
                },
                H = {
                    function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
                    desc = "Previous buffer",
                },

                -- mappings seen under group name "Buffer"
                ["<Leader>bD"] = {
                    function()
                        require("astroui.status.heirline").buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
                    end,
                    desc = "Pick to close",
                },

                -- -- tables with just a `desc` key will be registered with which-key if it's installed
                -- -- this is useful for naming menus
                -- ["<Leader>b"] = { desc = "Buffers" },
                -- -- quick save
                -- -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
            },

            -- Visual mode mappings
            v = {
                -- Gen (Ollama) plugin mappings
                ["<leader>m"] = { name = "󰳆 Gen" },
                ["<leader>mu"] = { ":'<,'>Gen<cr>", desc = "Open Gen UI" },
                ["<leader>mt"] = { ":'<,'>Gen Chat<cr>", desc = "Chat" },
                ["<leader>mg"] = { ":'<,'>Gen Generate<cr>", desc = "Generate" },
                ["<leader>ms"] = { ":'<,'>Gen Summarize<cr>", desc = "Summarize" },
                ["<leader>mr"] = { ":'<,'>Gen Review_Code<cr>", desc = "Review Code" },
                ["<leader>me"] = { ":'<,'>Gen Enhance_Code<cr>", desc = "Enhance Code" },
                ["<leader>mc"] = { ":'<,'>Gen Change_Code<cr>", desc = "Change Code" },
                ["<leader>ma"] = { ":'<,'>Gen Ask<cr>", desc = "Ask" },

                ["<leader>mm"] = { name = " Make" },
                ["<leader>mmg"] = { ":'<,'>Gen Enhance_Grammar_Spelling<cr>", desc = "Enhance Grammar" },
                ["<leader>mmw"] = { ":'<,'>Gen Enhance_Wording<cr>", desc = "Enhance Wording" },
                ["<leader>mmc"] = { ":'<,'>Gen Make_Concise<cr>", desc = "Make Concise" },
                ["<leader>mml"] = { ":'<,'>Gen Make_List<cr>", desc = "Make List" },
                ["<leader>mmt"] = { ":'<,'>Gen Make_Table<cr>", desc = "Make Table" },

                -- Code Runner mappings
                ["<leader>r"] = { name = " Code Runner" },

                -- SnipRun mappings
                ["<leader>rs"] = { ":'<,'>SnipRun<cr>", desc = "Execute Code Snippet" },
            },

            -- Insert mode mappings
            i = {},

            -- Terminal mode mappings
            t = {
                -- -- Add your terminal mode mappings here
                -- -- setting a mapping to false will disable it
                -- ["<esc>"] = false,

                -- Map "alt+z" to exit terminal mode and close the floating terminal window
                ["<A-z>"] = {
                    function()
                        -- First, exit insert mode in the terminal
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
                        -- Then, close the terminal window
                        vim.cmd "ToggleTermToggleAll"
                    end,
                    desc = "Exit terminal mode and close floating terminal",
                },
            },
        },
    },
}
