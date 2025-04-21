require("lazy").setup({
    {
        "AstroNvim/AstroNvim",
        version = "^5", -- Remove version tracking to elect for nighly AstroNvim
        import = "astronvim.plugins",
        opts = { -- AstroNvim options must be set here with the `import` key
            mapleader = " ", -- This ensures the leader key must be configured before Lazy is set up
            maplocalleader = ",", -- This ensures the localleader key must be configured before Lazy is set up
            icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
            pin_plugins = nil, -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
            update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
        },
    },
    { import = "community" },
    { import = "plugins" },
} --[[@as LazySpec]], {
    -- Configure any other `lazy.nvim` configuration options here
    install = { colorscheme = { "astrodark", "habamax" } },
    -- concurrency = 8,
    ui = {
        backdrop = 100,
        border = "rounded",
        size = {
            width = 0.8,
            height = 0.8,
        },
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        -- concurrency = 8, ---@type number? set to 1 to check for updates very slowly
        notify = true, -- get a notification when new updates are found
        frequency = 3600, -- check for updates every hour
    },
    performance = {
        rtp = {
            -- disable some rtp plugins, add more to your liking
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "zipPlugin",
            },
        },
    },
} --[[@as LazyConfig]])
