-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
        -- add more things to the ensure_installed table protecting against community packs modifying it
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
            "vim",
            "regex",
            "lua",
            "bash",
            "markdown",
            "markdown_inline",
            -- "lua",
            -- "python",
            -- "java",
            -- "javascript",
            -- "typescript",
            -- "tsx",
            -- "json",
            -- "html",
            -- "css",
            -- "gitignore",
            -- "vim",
            -- "bash",
            -- "markdown",
            -- "markdown_inline",
            -- "yaml",
            -- "query",
            -- "dockerfile",
            -- "graphql",
            -- "svelte",
            -- add more arguments for adding more treesitter parsers
        })
    end,
}

