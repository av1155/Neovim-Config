-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
        -- change colorscheme
        colorscheme = "catppuccin-mocha",
        -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
        highlights = {
            init = { -- this table overrides highlights in all themes
                -- Normal = { bg = "#000000" },

                -- Add or modify highlight groups specifically for nvim-dap-virtual-text
                NvimDapVirtualText = { fg = "#b58900", bg = "", italic = true },
                NvimDapVirtualTextError = { fg = "#dc322f", bg = "", bold = true, underline = true },
                NvimDapVirtualTextChanged = { fg = "#6c71c4", bg = "", underline = true },

                -- barbar plugin for Current buffer
                BufferCurrent = { fg = "#f28b25", bg = "" },
                BufferCurrentIndex = { fg = "#89b4fb", bg = "" },
                -- Setting Git status highlights with specified colors and transparent backgrounds
                BufferCurrentAdded = { fg = "#a6e3a2", bg = "" }, -- For added files
                BufferCurrentDeleted = { fg = "#f38ba9", bg = "" }, -- For removed files
                BufferCurrentChanged = { fg = "#f9e2b0", bg = "" }, -- For changed files
                -- Other:
                BufferCurrentMod = { fg = "#f28b25", bg = "" }, -- For changed files
                -- BufferCurrentIcon = { fg = "#foreground_color", bg = "" }, -- For changed files
                BufferCurrentWARN = { fg = "#f9e2b0", bg = "" }, -- For changed files
                BufferCurrentERROR = { fg = "#f38ba9", bg = "" }, -- For changed files
                BufferCurrentHINT = { fg = "#93e2d6", bg = "" }, -- For changed files
                BufferCurrentINFO = { fg = "#89dcec", bg = "" }, -- For info in files
                BufferCurrentSign = { fg = "#89b4fb", bg = "" }, -- For changed files
                BufferCurrentSignRight = { fg = "#89b4fb", bg = "" }, -- For changed files

                -- barbar plugin for Inactive buffers
                BufferInactive = { fg = "#6c7087", bg = "" }, -- Foreground color for inactive buffers
                BufferInactiveIndex = { fg = "#89b4fb", bg = "" }, -- Foreground color for inactive buffer indices

                -- Setting Git status highlights with specified colors and transparent backgrounds for inactive buffers
                BufferInactiveAdded = { fg = "#a6e3a2", bg = "" }, -- For added files in inactive buffers
                BufferInactiveDeleted = { fg = "#f38ba9", bg = "" }, -- For removed files in inactive buffers
                BufferInactiveChanged = { fg = "#f9e2b0", bg = "" }, -- For changed files in inactive buffers
                BufferInactiveMod = { fg = "#f9e2b0", bg = "" }, -- For modified files in inactive buffers
                -- BufferInactiveIcon = { fg = "#foreground_color", bg = "" }, -- Foreground color for icons in inactive buffers
                BufferInactiveWARN = { fg = "#f9e2b0", bg = "" }, -- For warnings in inactive buffers
                BufferInactiveERROR = { fg = "#f38ba9", bg = "" }, -- For errors in inactive buffers
                BufferInactiveHINT = { fg = "#93e2d6", bg = "" }, -- For hints in inactive buffers
                BufferInactiveINFO = { fg = "#89dcec", bg = "" }, -- For info in inactive files
                BufferInactiveSign = { fg = "#89b4fb", bg = "" }, -- Foreground color for signs in inactive buffers
                BufferInactiveSignRight = { fg = "#89b4fb", bg = "" }, -- Foreground color for right signs in inactive buffers

                -- barbar plugin for Alternate buffers
                BufferAlternate = { fg = "#f28b25", bg = "" }, -- Foreground color for alternate buffers

                -- Setting Git status highlights with specified colors and transparent backgrounds for alternate buffers
                BufferAlternateAdded = { fg = "#a6e3a2", bg = "" }, -- For added files in alternate buffers
                BufferAlternateDeleted = { fg = "#f38ba9", bg = "" }, -- For removed files in alternate buffers
                BufferAlternateChanged = { fg = "#f9e2b0", bg = "" }, -- For changed files in alternate buffers
                BufferAlternateMod = { fg = "#f9e2b0", bg = "" }, -- For modified files in alternate buffers
                -- BufferAlternateIcon = { fg = "#foreground_color", bg = "" }, -- Foreground color for icons in alternate buffers
                BufferAlternateWARN = { fg = "#f9e2b0", bg = "" }, -- For warnings in alternate buffers
                BufferAlternateERROR = { fg = "#f38ba9", bg = "" }, -- For errors in alternate buffers
                BufferAlternateHINT = { fg = "#93e2d6", bg = "" }, -- For hints in alternate buffers
                BufferAlternateINFO = { fg = "#89dcec", bg = "" }, -- For info in alternate files
                BufferAlternateSign = { fg = "#89b4fb", bg = "" }, -- Foreground color for signs in alternate buffers
                BufferAlternateSignRight = { fg = "#89b4fb", bg = "" }, -- Foreground color for right signs in alternate buffers

                -- barbar plugin for Visible buffers
                BufferVisible = { fg = "#f28b25", bg = "" }, -- Foreground color for visible buffers

                -- Setting Git status highlights with specified colors and transparent backgrounds for visible buffers
                BufferVisibleAdded = { fg = "#a6e3a2", bg = "" }, -- For added files in visible buffers
                BufferVisibleDeleted = { fg = "#f38ba9", bg = "" }, -- For removed files in visible buffers
                BufferVisibleChanged = { fg = "#f9e2b0", bg = "" }, -- For changed files in visible buffers
                BufferVisibleMod = { fg = "#f9e2b0", bg = "" }, -- For modified files in visible buffers
                -- BufferVisibleIcon = { fg = "#foreground_color", bg = "" }, -- Foreground color for icons in visible buffers
                BufferVisibleWARN = { fg = "#f9e2b0", bg = "" }, -- For warnings in visible buffers
                BufferVisibleERROR = { fg = "#f38ba9", bg = "" }, -- For errors in visible buffers
                BufferVisibleHINT = { fg = "#93e2d6", bg = "" }, -- For hints in visible buffers
                BufferVisibleINFO = { fg = "#89dcec", bg = "" }, -- For info in files
                BufferVisibleSign = { fg = "#89b4fb", bg = "" }, -- Foreground color for signs in visible buffers
                BufferVisibleSignRight = { fg = "#89b4fb", bg = "" }, -- Foreground color for right signs in visible buffers

                -- Cursor
                CursorLine = { bg = "#3a3c47" },
                -- Set the visual selection color
                Visual = {
                    bg = "#775d46" --[[ , fg = "#ffffff" ]],
                },

                -- BufferLineTabClose = { fg = "#1e222a", bg = "#1e222a" },
                -- BufferLineBufferSelected = { fg = "#abb2bf", bg = "#1e222a" },
                -- NormalNC = { fg = "#abb2bf", bg = "#1e222a" },
                -- WinBar = { fg = "#5c6370", bg = "#1e222a" },
                -- WinBarNC = { fg = "#5c6370", bg = "#1e222a" },

                --VS code cmp
                CmpItemKindConstructor = { fg = "#f28b25" },
                CmpItemKindUnit = { fg = "#D4D4D4" },
                CmpItemKindProperty = { fg = "#D4D4D4" },
                CmpItemKindKeyword = { fg = "#D4D4D4" },
                CmpItemKindMethod = { fg = "#C586C0" },
                CmpItemKindFunction = { fg = "#C586C0" },
                CmpItemKindColor = { fg = "#C586C0" },
                CmpItemKindText = { fg = "#9CDCFE" },
                CmpItemKindInterface = { fg = "#9CDCFE" },
                CmpItemKindVariable = { fg = "#9CDCFE" },
                CmpItemKindField = { fg = "#9CDCFE" },
                CmpItemKindValue = { fg = "#9CDCFE" },
                CmpItemKindEnum = { fg = "#9CDCFE" },
                CmpItemKindEnumMember = { fg = "#9CDCFE" },
                CmpItemKindStruct = { fg = "#9CDCFE" },
                CmpItemKindReference = { fg = "#9CDCFE" },
                CmpItemKindTypeParameter = { fg = "#9CDCFE" },
                CmpItemKindSnippet = { fg = "#D4D4D4" },
                CmpItemKindClass = { fg = "#f28b25" },
                CmpItemKindModule = { fg = "#D4D4D4" },
                CmpItemKindOperator = { fg = "#D4D4D4" },
                CmpItemKindConstant = { fg = "#D4D4D4" },
                CmpItemKindFile = { fg = "#D4D4D4" },
                CmpItemKindFolder = { fg = "#D4D4D4" },
                CmpItemKindEvent = { fg = "#D4D4D4" },
                CmpItemAbbrMatch = { fg = "#18a2fe", bold = true },
                CmpItemAbbrMatchFuzzy = { fg = "#18a2fe", bold = true },
                CmpItemMenu = { fg = "#777d86" },
                -- VS code tree
                AerialArrayIcon = { fg = "" },
                AerialClassIcon = { fg = "#f28b25" },
                AerialConstantIcon = { fg = "#D4D4D4" },
                AerialConstructorIcon = { fg = "#f28b25" },
                AerialEnumIcon = { fg = "#9CDCFE" },
                AeiralEnumMember = { fg = "#9CDCFE" },
                AerialEventIcon = { fg = "#D4D4D4" },
                AerialFieldIcon = { fg = "#9CDCFE" },
                AerialFileIcon = { fg = "#D4D4D4" },
                AerialFunctionIcon = { fg = "#C586C0" },
                AerialInterfaceIcon = { fg = "#9CDCFE" },
                AerialKeyIcon = { fg = "#D4D4D4" },
                AerialMethodIcon = { fg = "#C586C0" },
                AerialModuleIcon = { fg = "#D4D4D4" },
                AerialNamespaceIcon = { fg = "#D4D4D4" },
                AerialNullIcon = { fg = "#D4D4D4" },
                AerialNumberIcon = { fg = "#D4D4D4" },
                AerialObjectIcon = { fg = "#f28b25" },
                AerialOperatorIcon = { fg = "#D4D4D4" },
                AerialPackageIcon = { fg = "#D4D4D4" },
                AerialPropertyIcon = { fg = "#D4D4D4" },
                AerialStringIcon = { fg = "#9CDCFE" },
                AerialStructIcon = { fg = "#f28b25" },
                AerialTypeParameter = { fg = "#9CDCFE" },
                AerialVariableIcon = { fg = "#9CDCFE" },
                AerialGuide = { fg = "#777d86" },
                -- Spell
                SpellBad = { sp = "#ffbba6", undercurl = true },
                SpellCap = { sp = "#ffbba6", undercurl = true },
                SpellLocal = { sp = "#ffbba6", undercurl = true },
                SpellRare = { sp = "#ffbba6", undercurl = true },
                -- Inlay hint
                LspInlayHint = {
                    fg = "#8f939b",
                    -- fg = "#D4D4D4",
                    -- fg = "#4b5263",
                    -- link = "Comment",

                    -- #D4D4D4 Brighter
                    -- #8f939b In-Between
                    -- #4b5263 Original
                },
                -- Indentline
                IndentBlanklineSpaceChar = { fg = "#3b4048", nocombine = true },
                IndentBlanklineChar = { fg = "#3b4048", nocombine = true },
                IndentBlanklineContextStart = { fg = "#5c5c5c", underline = true },
                IndentBlanklineContextChar = { fg = "#5c5c5c", nocombine = true },
                IndentBlanklineSpaceCharBlankline = { fg = "#3b4048", nocombine = true },
            },
            astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
                -- Normal = { bg = "#000000" },
            },
        },
        -- Icons can be configured throughout the interface
        icons = {
            -- configure the loading of the lsp in the status line
            LSPLoading1 = "⠋",
            LSPLoading2 = "⠙",
            LSPLoading3 = "⠹",
            LSPLoading4 = "⠸",
            LSPLoading5 = "⠼",
            LSPLoading6 = "⠴",
            LSPLoading7 = "⠦",
            LSPLoading8 = "⠧",
            LSPLoading9 = "⠇",
            LSPLoading10 = "⠏",
        },
    },
}
