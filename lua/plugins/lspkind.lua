-- Set highlight group for Copilot
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

return {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
        opts.mode = "symbol_text"
        opts.preset = "codicons"
        opts.symbol_map = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
            Array = "",
            Boolean = "",
            Key = "",
            Namespace = "",
            Null = "",
            Number = "",
            Object = "",
            Package = "",
            String = "",
            Copilot = "", -- Add this line for Copilot
        }
        return opts
    end,
}
