-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
        -- Configuration table of features provided by AstroLSP
        features = {
            autoformat = true,      -- enable or disable auto formatting on start
            codelens = true,        -- enable/disable codelens refresh on start
            inlay_hints = true,     -- enable/disable inlay hints on start
            semantic_tokens = true, -- enable/disable semantic token highlighting
        },
        -- customize lsp formatting options
        formatting = {
            -- control auto formatting on save
            format_on_save = {
                enabled = true,     -- enable or disable format on save globally
                allow_filetypes = { -- enable format on save for specified filetypes only
                    -- "go",
                },
                ignore_filetypes = { -- disable format on save for specified filetypes
                    -- "python",
                },
            },
            disabled = { -- disable formatting capabilities for the listed language servers
                -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
                -- "lua_ls",
                "jdtls",
            },
            timeout_ms = 1000, -- default format timeout
            -- filter = function(client) -- fully override the default formatting function
            --   return true
            -- end
        },
        -- enable servers that you already have installed without mason
        servers = {
            -- "pyright"
        },
        -- customize language server configuration options passed to `lspconfig`
        ---@diagnostic disable: missing-fields
        config = {
            clangd = { capabilities = { offsetEncoding = "utf-8" } },
            lua_ls = {
                settings = {
                    Lua = {
                        hint = {
                            enable = true,
                            setType = true,
                            arrayIndex = "Disable", -- "Enable" or "Disable"
                        },
                    },
                },
            },
            tsserver = {
                settings = {
                    javascript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all';
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = false,
                            includeInlayVariableTypeHints = true,
                        },
                    },
                    typescript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all';
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = false,
                            includeInlayVariableTypeHints = true,
                        },
                    },
                },
            },
        },
        -- customize how language servers are attached
        handlers = {
            -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
            -- function(server, opts) require("lspconfig")[server].setup(opts) end

            -- the key is the server that is being setup with `lspconfig`
            -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
            -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
        },
        -- Configure buffer local auto commands to add when attaching a language server
        autocmds = {
            -- first key is the `augroup` to add the auto commands to (:h augroup)
            lsp_document_highlight = {
                -- Optional condition to create/delete auto command group
                -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
                -- condition will be resolved for each client on each execution and if it ever fails for all clients,
                -- the auto commands will be deleted for that buffer
                cond = "textDocument/documentHighlight",
                -- cond = function(client, bufnr) return client.name == "lua_ls" end,
                -- list of auto commands to set
                {
                    -- events to trigger
                    event = { "CursorHold", "CursorHoldI" },
                    -- the rest of the autocmd options (:h nvim_create_autocmd)
                    desc = "Document Highlighting",
                    callback = function() vim.lsp.buf.document_highlight() end,
                },
                {
                    event = { "CursorMoved", "CursorMovedI", "BufLeave" },
                    desc = "Document Highlighting Clear",
                    callback = function() vim.lsp.buf.clear_references() end,
                },
            },
        },
        -- mappings to be set up on attaching of a language server
        mappings = {
            v = {
                ["<leader>lx"] = { "<cmd>'<,'>Hypersonic<CR>", desc = "RegExp explanation" },
            },

            n = {
                gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
                -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
                -- gD = {
                --   function() vim.lsp.buf.declaration() end,
                --   desc = "Declaration of current symbol",
                --   cond = "textDocument/declaration",
                -- },
                -- ["<Leader>uY"] = {
                --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
                --   desc = "Toggle LSP semantic highlight (buffer)",
                --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
                -- },

                -- nvim-lspconfig mappings:
                -- ["<leader>ld"] = { vim.lsp.buf.hover, desc = "Hover diagnostics" },

                ["<leader>ld"] = {
                    function()
                        local hovercraft = require "hovercraft"
                        if hovercraft.is_visible() then
                            hovercraft.enter_popup()
                        else
                            hovercraft.hover()
                        end
                    end,
                    desc = "Hover LSP provider",
                },

                ["<leader>lr"] = { ":IncRename ", desc = "Rename current symbol" },

                ["<leader>le"] = { name = "󱣱 LSP Diagnostics & Navigation" },
                ["<leader>lee"] = { vim.diagnostic.open_float, desc = "Open diagnostic float" },
                ["<leader>led"] = { vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
                ["<leader>lef"] = { vim.diagnostic.goto_next, desc = "Next diagnostic" },
                ["<leader>leq"] = { vim.diagnostic.setloclist, desc = "Set loclist with diagnostics" },
                ["<leader>leD"] = { vim.lsp.buf.declaration, desc = "Go to declaration" },
                ["<leader>leg"] = { vim.lsp.buf.definition, desc = "Go to definition" },
                ["<leader>lei"] = { vim.lsp.buf.implementation, desc = "Go to implementation" },
                ["<leader>let"] = { vim.lsp.buf.type_definition, desc = "Type definition" },
                ["<leader>ler"] = { vim.lsp.buf.references, desc = "Find all references" },
                -- ["<leader>lh"] = {
                --     function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "n", true) end,
                --     desc = "Signature help",
                -- },

                ["<leader>lew"] = { name = "󰥟 Workspace" },
                ["<leader>lewa"] = { vim.lsp.buf.add_workspace_folder, desc = "Add workspace folder" },
                ["<leader>lewr"] = { vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder" },
                ["<leader>lewl"] = {
                    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
                    desc = "List workspace folders",
                },
            },
        },
        -- A custom `on_attach` function to be run after the default `on_attach` function
        -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
        on_attach = function(client, bufnr)
            -- this would disable semanticTokensProvider for all clients
            -- client.server_capabilities.semanticTokensProvider = nil
        end,
    },
}

