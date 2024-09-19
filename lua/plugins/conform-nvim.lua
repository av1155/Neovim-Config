return {
    "stevearc/conform.nvim",
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            go = { "gofmt", "goimports" },
            rust = { "rustfmt" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            java = { "clang-format" },
            -- java = { "google-java-format" },
            markdown = { "prettier" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            json = { "prettier" },
            yaml = { "prettier" },
            xml = { "xmllint" },
            ruby = { "rubocop" },
            kotlin = { "ktlint" },
            toml = { "taplo" },
        },
        -- -- Set default options
        -- default_format_opts = {
        --     lsp_format = "fallback",
        -- },
        -- -- Customize formatters
        -- formatters = {
        --     shfmt = {
        --         prepend_args = { "-i", "2" },
        --     },
        -- },
    },
}
