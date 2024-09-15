vim.api.nvim_set_hl(0, "MyHeaderHighlight", { fg = "#88C0D0", bg = "" })
vim.api.nvim_set_hl(0, "MyGreetingHighlight", { fg = "#81A1C1", bg = "" })
vim.api.nvim_set_hl(0, "MyButtonsHighlight", { fg = "#ECEFF4", bg = "" })
vim.api.nvim_set_hl(0, "MyFooterHighlight", { fg = "#EBCB8B", bg = "" })

return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
        local dashboard = require "alpha.themes.dashboard"

        -- dashboard.section.header.val = {
        --     "                                                     ",
        --     "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        --     "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        --     "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        --     "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        --     "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        --     "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        -- }

        local header = {
            [[                                                    ]],
            [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
            [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
            [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
            [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
            [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
            [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
            [[                                                    ]],
        }

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

        -- -- Center the logo and greeting text
        -- dashboard.section.header.val = vim.split(table.concat(header, "\n") .. "\n" .. greeting, "\n")

        -- Split the header and greeting separately
        dashboard.section.header.val = vim.split(table.concat(header, "\n"), "\n")
        dashboard.section.greeting = { type = "text", val = greeting, opts = { hl = "MyGreetingHighlight", position = "center" } }

        dashboard.section.buttons.val = {
            dashboard.button("p", "🗂️  Find project", ":Telescope projects <CR>"),
            dashboard.button("n", "📝  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "🔍  Find file", ":Telescope find_files <CR>"),
            dashboard.button("t", "📜  Find text", ":Telescope live_grep <CR>"),
            dashboard.button("m", "🔖  BookMarks", ":Telescope marks <CR>"),
            dashboard.button("r", "🕘  Recently used files", ":Telescope oldfiles <CR>"),
            dashboard.button("c", "🔧  Configuration", ":e ~/.config/nvim/<CR>"),
            dashboard.button("q", "💨  Quit Neovim", ":qa<CR>"),
            dashboard.button("u", "🚀  Check for Updates", ":AstroUpdate<CR>"),
        }

        -- dashboard.section.buttons.val = {
        --     dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
        --     dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        --     dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        --     dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
        --     dashboard.button("m", "  BookMarks", ":Telescope marks <CR>"),
        --     dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
        --     dashboard.button("c", "  Configuration", ":e ~/.config/nvim<CR>"),
        --     dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        --     dashboard.button("u", "🚀 Check for Updates", ":AstroUpdate<CR>"),
        -- }

        -- Apply highlight groups to buttons and shortcuts
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "MyButtonsHighlight"
            button.opts.hl_shortcut = "AlphaShortcut" -- Optional, you can define this
        end

        -- dashboard.section.header.opts.hl = "Include"
        -- dashboard.section.buttons.opts.hl = "Keyword"
        -- dashboard.section.footer.opts.hl = "Type"

        dashboard.section.header.opts.hl = "MyHeaderHighlight"
        dashboard.section.buttons.opts.hl = "MyButtonsHighlight"
        dashboard.section.footer.opts.hl = "MyFooterHighlight"

        -- Calculate padding based on percentage of screen dimensions
        local function get_padding(percentage) return math.floor(vim.o.lines * percentage) end

        -- Adjust padding dynamically based on the screen size
        local top_padding = get_padding(0.07) -- 7% of screen height as top padding
        local between_header_and_greeting = get_padding(0.02) -- padding between header and greeting
        local between_greeting_and_buttons = get_padding(0.04) -- padding between greeting and buttons
        local between_buttons_and_footer = get_padding(0.03) -- padding between buttons and footer
        local bottom_padding = get_padding(0.02) -- padding at the bottom

        dashboard.opts.layout = {
            { type = "padding", val = top_padding },
            dashboard.section.header,
            { type = "padding", val = between_header_and_greeting },
            dashboard.section.greeting, -- Insert greeting section here
            { type = "padding", val = between_greeting_and_buttons },
            dashboard.section.buttons,
            { type = "padding", val = between_buttons_and_footer },
            dashboard.section.footer,
            { type = "padding", val = bottom_padding },
        }

        return dashboard
    end,

    config = function(_, dashboard)
        -- Close Lazy window if open, then reopen after Alpha is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                once = true,
                pattern = "AlphaReady",
                callback = function() require("lazy").show() end,
            })
        end

        -- Setup alpha with the provided options
        require("alpha").setup(dashboard.opts)

        -- Update the footer dynamically after Neovim starts
        vim.api.nvim_create_autocmd("User", {
            once = true,
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}

-- "888b    888                  888     888 d8b               ",
-- "8888b   888                  888     888 Y8P               ",
-- "88888b  888                  888     888                   ",
-- "888Y88b 888  .d88b.   .d88b. Y88b   d88P 888 88888b.d88b.  ",
-- '888 Y88b888 d8P  Y8b d88""88b Y88b d88P  888 888 "888 "88b ',
-- "888  Y88888 88888888 888  888  Y88o88P   888 888  888  888 ",
-- "888   Y8888 Y8b.     Y88..88P   Y888P    888  888  888  888",
-- '888    Y888  "Y8888   "Y88P"     Y8P     888 888  888  888 ',
