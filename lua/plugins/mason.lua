-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
    -- use mason-lspconfig to configure LSP installations
    {
        "williamboman/mason-lspconfig.nvim",
        -- overrides `require("mason-lspconfig").setup(...)`
        opts = function(_, opts)
            -- Get the system architecture
            local arch = vim.loop.os_uname().machine

            -- Add more things to the ensure_installed table protecting against community packs modifying it
            opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
                "lua_ls",
                -- add more language servers you want to install
            })

            -- Remove unwanted language servers based on architecture
            opts.ensure_installed = vim.tbl_filter(function(server)
                if arch == "aarch64" then
                    return server ~= "selene" and server ~= "lemminx"
                else
                    return true
                end
            end, opts.ensure_installed)
        end,
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    {
        "jay-babu/mason-null-ls.nvim",
        -- overrides `require("mason-null-ls").setup(...)`
        opts = function(_, opts)
            -- Get the system architecture
            local arch = vim.loop.os_uname().machine

            -- Add more things to the ensure_installed table protecting against community packs modifying it
            opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
                "stylua", -- Lua
                "clang-format", -- C, C++, Java
                "prettier", -- JavaScript, TypeScript, HTML, CSS, JSON, YAML
                "prettierd", -- Faster prettier daemon
                "black", -- Python
                "isort", -- Python imports
                "shfmt", -- Shell scripts (bash/zsh)
                "google-java-format", -- Java
                "rustfmt", -- Rust
                "gofmt", -- Go
                "goimports", -- Go
                "rubocop", -- Ruby
                "ktlint", -- Kotlin
                "taplo", -- TOML
                "xmllint", -- XML
            })

            -- Remove unwanted formatters/linters based on architecture
            opts.ensure_installed = vim.tbl_filter(function(source)
                if arch == "aarch64" then
                    return source ~= "selene" and source ~= "lemminx"
                else
                    return true
                end
            end, opts.ensure_installed)
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        -- overrides `require("mason-nvim-dap").setup(...)`
        opts = function(_, opts)
            -- Get the system architecture
            local arch = vim.loop.os_uname().machine

            -- Add more things to the ensure_installed table protecting against community packs modifying it
            opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
                "python",
                -- add more debuggers you want to install
            })

            -- Remove unwanted debuggers based on architecture
            opts.ensure_installed = vim.tbl_filter(function(dap)
                if arch == "aarch64" then
                    return dap ~= "selene" and dap ~= "lemminx"
                else
                    return true
                end
            end, opts.ensure_installed)
        end,
    },
}
