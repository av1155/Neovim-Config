-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
    -- use mason-lspconfig to configure LSP installations
    {
        "williamboman/mason-lspconfig.nvim",
        -- overrides `require("mason-lspconfig").setup(...)`
        opts = function(_, opts)
            -- add more things to the ensure_installed table protecting against community packs modifying it
            opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
                "lua_ls",
                -- add more language servers you want to install
            })
            -- Remove unwanted language servers
            opts.ensure_installed = vim.tbl_filter(
                function(server) return server ~= "selene" and server ~= "lemminx" end,
                opts.ensure_installed
            )
        end,
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    {
        "jay-babu/mason-null-ls.nvim",
        -- overrides `require("mason-null-ls").setup(...)`
        opts = function(_, opts)
            -- add more things to the ensure_installed table protecting against community packs modifying it
            opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
                "stylua",
                "clang-format",
                -- add more null-ls sources you want to install
            })
            -- Remove unwanted formatters/linters
            opts.ensure_installed = vim.tbl_filter(
                function(source) return source ~= "selene" and source ~= "lemminx" end,
                opts.ensure_installed
            )
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        -- overrides `require("mason-nvim-dap").setup(...)`
        opts = function(_, opts)
            -- add more things to the ensure_installed table protecting against community packs modifying it
            opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
                "python",
                -- add more debuggers you want to install
            })
            -- Remove unwanted debuggers
            opts.ensure_installed = vim.tbl_filter(function(dap) return dap ~= "selene" and dap ~= "lemminx" end,
                opts.ensure_installed)
        end,
    },
}

