-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
    extension = {
        foo = "fooscript",
        log = "log",
        zsh = "sh",
        sh = "sh",
    },
    filename = {
        ["Foofile"] = "fooscript",
        [".zshrc"] = "sh",
        [".zshenv"] = "sh",
        [".zprofile"] = "sh",
    },
    pattern = {
        ["~/%.config/foo/.*"] = "fooscript",
    },
}

-- ================================================================================

-- setup nvim-dap-repl-highlights or else the dap_repl parser won't be found
require("nvim-dap-repl-highlights").setup()
local dap = require "dap"
dap.configurations.java = {
    {
        name = "Java Debug Current File",
        type = "java",
        request = "launch",
        program = "${file}",
        repl_lang = "java", -- Ensuring that the REPL buffer will have Java filetype
    },
}

-- Defer the execution of setting LSP and Mason configurations to reduce startup time
vim.defer_fn(function()
    -- Setting border for LSP windows
    require("lspconfig.ui.windows").default_options.border = "rounded"

    -- Setting up Mason with a custom UI configuration
    require("mason").setup {
        ui = {
            border = "rounded",
        },
    }
end, 1000) -- Delay in milliseconds, adjust as needed

-- ======================= Bux Fixes for Specific Issues ==========================

-- Disable lualine for neo-tree only (fixes home screen bug)
require("lualine").setup {
    options = {
        disabled_filetypes = {
            statusline = { "neo-tree", "Avante", "AvanteInput" },
        },
    },
}

-- require("inc_rename").setup {}

-- ---@diagnostic disable-next-line: missing-fields
-- require("notify").setup {
--     background_colour = "#262d3b",
-- }

-- ========================= Unmapping and Mapping =================================

-- local opts = { noremap = true, silent = true }

-- local map = vim.api.nvim_set_keymap
-- -- Allow gf to work for non-existing files
-- map("n", "gf", ":edit <cfile><cr>", { desc = "Edit file" })
-- map("v", "gf", ":edit <cfile><cr>", { desc = "Edit file" })
-- map("o", "gf", ":edit <cfile><cr>", { desc = "Edit file" })
--
-- map("n", "<f8>", ":cprev<cr>", { desc = "Previous item in quickfix list" })
-- map("n", "<f9>", ":cnext<cr>", { desc = "Next item in quickfix list" })
-- map("n", "<leader>qf", ":lua hu_toggle_qf()<cr>", { desc = "Toggle quickfix list" })

local unmap = vim.api.nvim_del_keymap

-- Undo some AstroNvim mappings:
unmap("n", "<leader>bse")
unmap("n", "<leader>bsi")
unmap("n", "<leader>bsm")
unmap("n", "<leader>bsp")
unmap("n", "<leader>bsr")
unmap("n", "<leader>Mp")
unmap("n", "<leader>Ms")
unmap("n", "<leader>Mt")
-- unmap("n", "<leader>u")
-- unmap("n", "<C-q>")
-- unmap("n", "<C-s>")
-- unmap("n", "<leader>h")
-- unmap("n", "<leader>q")
-- unmap("n", "<leader>sb") -- use <leader>gb
-- unmap("n", "<leader>sh") -- use <leader>fh
-- unmap("n", "<leader>sm")
-- unmap("n", "<leader>tl") -- Not installed on bare metal
-- unmap("n", "<leader>tn")
-- unmap("n", "<leader>tp")
-- unmap("n", "<leader>w")

-- -- Packer/Mason keymaps:
-- unmap("n", "<leader>pA")
-- unmap("n", "<leader>pS")
-- unmap("n", "<leader>pc")
-- unmap("n", "<leader>pi")
-- unmap("n", "<leader>ps")
-- unmap("n", "<leader>pu")
-- unmap("n", "<leader>pv")

-- ============================= Autocommands ====================================
-- ===============================================================================

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
    pattern = { "*.html", "*.css" },
    callback = function() vim.cmd "silent write" end,
})

-- ================================================================================

-- Show cursor line only in active window, except for neo-tree buffer
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    callback = function()
        if vim.tbl_contains({
            "neo-tree",
            "aerial",
        }, vim.bo.filetype) then return end

        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, "auto-cursorline")
        end
    end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    callback = function()
        if vim.tbl_contains({
            "neo-tree",
            "aerial",
        }, vim.bo.filetype) then return end

        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
            vim.wo.cursorline = false
        end
    end,
})

-- ================================================================================

-- Code to disable semantic tokens provider (Uncomment to use)
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     client.server_capabilities.semanticTokensProvider = nil
--   end,
-- })

-- ================================================================================
