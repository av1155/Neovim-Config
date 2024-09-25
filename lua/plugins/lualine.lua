-- Bubbles config for lualine:

-- stylua: ignore
local colors = {
    blue       = '#80a0ff',
    cyan       = '#79dac8',
    -- black  = '#080808', -- transparent
    black      = '',
    white      = '#c6c6c6',
    red        = '#ff5189',
    pink     = '#F4B8E4',
    grey       = '#303030',
    muted_blue = '#5f87af', -- A muted blue color
    dark_grey  = '#262626', -- A new dark grey color for better contrast

}

local bubbles_theme = {
    normal = {
        a = { fg = colors.dark_grey, bg = colors.pink, gui = "bold" },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.black, bg = colors.black },
        z = { fg = colors.white, bg = colors.muted_blue },
    },

    insert = {
        a = { fg = colors.dark_grey, bg = colors.blue, gui = "bold" },
        z = { fg = colors.white, bg = colors.muted_blue },
    },
    visual = {
        a = { fg = colors.dark_grey, bg = colors.cyan, gui = "bold" },
        z = { fg = colors.white, bg = colors.muted_blue },
    },
    replace = {
        a = { fg = colors.dark_grey, bg = colors.red, gui = "bold" },
        z = { fg = colors.white, bg = colors.muted_blue },
    },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
        z = { fg = colors.white, bg = colors.muted_blue },
    },
}

local function python_interpreter()
    if vim.bo.filetype == "python" then
        local python_path = os.getenv "NVIM_PYTHON_PATH"
        if python_path then
            -- Check if the path belongs to an environment inside `envs/`
            local env_name = python_path:match ".*/envs/(.-)/bin/python"
            if env_name then
                return " " .. env_name
            else
                if python_path:match ".base/bin/python" then
                    return " Base"
                else
                    return " Python Env"
                end
            end
        else
            return " No Python Interpreter"
        end
    else
        return ""
    end
end

local function lsp_status()
    local columns = vim.o.columns
    if columns < 100 then -- Adjust the value as needed for your setup
        return ""
    else
        local active_clients = vim.lsp.get_clients()
        if next(active_clients) == nil then return "No Active Lsp" end

        local buf_ft = vim.bo.filetype
        local active_servers = {}

        for _, client in ipairs(active_clients) do
            local filetypes = client.config and client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then table.insert(active_servers, client.name) end
        end

        if #active_servers == 0 then
            return "No Active Lsp"
        else
            return table.concat(active_servers, ", ")
        end
    end
end

local function is_copilot_cmp_active()
    local cmp = require "cmp"
    -- Check if copilot is in the cmp sources for the current buffer
    local sources = cmp.get_config().sources
    for _, source in ipairs(sources) do
        if source.name == "copilot" then return true end
    end
    return false
end

local function toggle_copilot_cmp()
    local cmp = require "cmp"
    if is_copilot_cmp_active() then
        -- Disable Copilot-CMP by filtering it out of the sources
        cmp.setup.buffer {
            sources = vim.tbl_filter(function(source) return source.name ~= "copilot" end, cmp.get_config().sources),
        }
        vim.notify("Copilot-CMP Disabled", vim.log.levels.INFO) -- Notify the user
    else
        -- Enable Copilot-CMP by adding it to the sources
        require("copilot_cmp").setup()
        cmp.setup.buffer {
            sources = { { name = "copilot" }, unpack(cmp.get_config().sources) },
        }
        vim.notify("Copilot-CMP Enabled", vim.log.levels.INFO) -- Notify the user
    end
end

local function copilot_cmp_status()
    if is_copilot_cmp_active() then
        return "" -- Enabled icon
    else
        return "" -- Disabled icon
    end
end

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "AndreM222/copilot-lualine",
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("lualine").setup {
                options = {
                    theme = bubbles_theme,
                    component_separators = "|",
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {
                            "neo-tree",
                            "alpha",
                            "Avante",
                            "alpha",
                        },
                        winbar = {},
                    },
                },
                sections = {
                    lualine_a = {
                        {
                            "mode",
                            on_click = function()
                                if vim.bo.buftype == "" then vim.cmd "Telescope man_pages" end
                            end,
                            separator = { left = "" },
                            right_padding = 2,
                        },
                    },
                    lualine_b = {
                        {
                            "filename",
                            on_click = function()
                                if vim.bo.buftype == "" then vim.cmd "Telescope buffers" end
                            end,
                        },

                        {
                            "branch",
                            icon = "",
                            color = { fg = "#c6c6c6" },
                            on_click = function()
                                if vim.bo.buftype == "" then vim.cmd "Telescope git_branches" end
                            end,
                        },
                    },
                    lualine_c = {
                        "fileformat",
                        { python_interpreter, color = { fg = "#c6c6c6" } },
                    },

                    lualine_x = {
                        {
                            lsp_status,
                            icon = " LSP:",
                            color = { fg = "#c6c6c6" },
                            on_click = function()
                                if vim.bo.buftype == "" then vim.cmd "LspInfo" end
                            end,
                        },
                        -- {
                        --     "copilot",
                        --     show_colors = true,
                        --     on_click = function()
                        --         if vim.bo.buftype == "" then vim.cmd "Copilot toggle" end
                        --     end,
                        -- },
                        {
                            copilot_cmp_status, -- Displays only the icon
                            color = function()
                                if is_copilot_cmp_active() then
                                    return { fg = "#6CC644" } -- Green for enabled
                                else
                                    return { fg = "#6371A4" } -- Grey for disabled
                                end
                            end,
                            on_click = function()
                                toggle_copilot_cmp() -- Toggle Copilot-CMP on click
                            end,
                        },
                    },

                    lualine_y = {
                        {
                            "filetype",
                            on_click = function()
                                if vim.bo.buftype == "" then
                                    vim.cmd "DevdocsFetch"
                                    vim.cmd "DevdocsOpenCurrentFloat"
                                end
                            end,
                        },
                        -- {
                        --     "progress",
                        --     color = { fg = "#ff5189", gui = "bold" }, -- Customize the progress bar
                        --     separator = { right = "" },
                        -- },
                        {
                            "progress",
                            color = { fg = "#e06c75", gui = "bold" },
                            separator = { right = "" },
                        },
                    },
                    lualine_z = {
                        { "diff", separator = { right = "" }, left_padding = 2 },
                    },
                },
                inactive_sections = {
                    lualine_a = { "filename" },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { "location" },
                },
                tabline = {},
                extensions = {},
            }
        end,
    },
}
