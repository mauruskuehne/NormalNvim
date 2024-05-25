return {

    --  which-key.nvim [on-screen keybindings]
    --  https://github.com/folke/which-key.nvim
    {
        "folke/which-key.nvim",
        event = "User BaseDefered",
        opts = {
            icons = { group = vim.g.icons_enabled and "" or "+", separator = "" },
            disable = { filetypes = { "TelescopePrompt" } },
        },
        config = function(_, opts)
            require("which-key").setup(opts)
            require("base.utils").which_key_register()
        end,
    },


    --  vim-matchup [improved % motion]
    --  https://github.com/andymass/vim-matchup
    {
        "andymass/vim-matchup",
        event = "User BaseFile",
        config = function()
            vim.g.matchup_matchparen_deferred = 1   -- work async
            vim.g.matchup_matchparen_offscreen = {} -- disable status bar icon
        end,
    },

    --  hop.nvim [go to word visually]
    --  https://github.com/smoka7/hop.nvim
    {
        "smoka7/hop.nvim",
        cmd = { "HopWord" },
        opts = { keys = "etovxqpdygfblzhckisuran" }
    },

    --  nvim-autopairs [auto close brackets]
    --  https://github.com/windwp/nvim-autopairs
    --  It's disabled by default, you can enable it with <space>ua
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
            ts_config = { java = false },
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                offset = 0,
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "PmenuSel",
                highlight_grey = "LineNr",
            },
        },
        config = function(_, opts)
            local npairs = require("nvim-autopairs")
            npairs.setup(opts)
            if not vim.g.autopairs_enabled then npairs.disable() end

            local is_cmp_loaded, cmp = pcall(require, "cmp")
            if is_cmp_loaded then
                cmp.event:on(
                    "confirm_done",
                    require("nvim-autopairs.completion.cmp").on_confirm_done {
                        tex = false }
                )
            end
        end
    },


    -- spectre.nvim [search and replace in project]
    -- https://github.com/nvim-pack/nvim-spectre
    -- INSTRUCTIONS:
    -- To see the instructions press '?'
    -- To start the search press <ESC>.
    -- It doesn't have ctrl-z so please always commit before using it.
    {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        opts = {
            default = {
                find = {
                    -- pick one of item in find_engine [ fd, rg ]
                    cmd = "fd",
                    options = {}
                },
                replace = {
                    -- pick one of item in [ sed, oxi ]
                    cmd = "sed"
                },
            },
            is_insert_mode = true,    -- start open panel on is_insert_mode
            is_block_ui_break = true, -- prevent the UI from breaking
            mapping = {
                ["toggle_line"] = {
                    map = "d",
                    cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
                    desc = "toggle item.",
                },
                ["enter_file"] = {
                    map = "<cr>",
                    cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
                    desc = "open file.",
                },
                ["send_to_qf"] = {
                    map = "sqf",
                    cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                    desc = "send all items to quickfix.",
                },
                ["replace_cmd"] = {
                    map = "src",
                    cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
                    desc = "replace command.",
                },
                ["show_option_menu"] = {
                    map = "so",
                    cmd = "<cmd>lua require('spectre').show_options()<CR>",
                    desc = "show options.",
                },
                ["run_current_replace"] = {
                    map = "c",
                    cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
                    desc = "confirm item.",
                },
                ["run_replace"] = {
                    map = "R",
                    cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
                    desc = "replace all.",
                },
                ["change_view_mode"] = {
                    map = "sv",
                    cmd = "<cmd>lua require('spectre').change_view()<CR>",
                    desc = "results view mode.",
                },
                ["change_replace_sed"] = {
                    map = "srs",
                    cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
                    desc = "use sed to replace.",
                },
                ["change_replace_oxi"] = {
                    map = "sro",
                    cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
                    desc = "use oxi to replace.",
                },
                ["toggle_live_update"] = {
                    map = "sar",
                    cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
                    desc = "auto refresh changes when nvim writes a file.",
                },
                ["resume_last_search"] = {
                    map = "sl",
                    cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
                    desc = "repeat last search.",
                },
                ["insert_qwerty"] = {
                    map = "i",
                    cmd = "<cmd>startinsert<CR>",
                    desc = "insert (qwerty).",
                },
                ["insert_colemak"] = {
                    map = "o",
                    cmd = "<cmd>startinsert<CR>",
                    desc = "insert (colemak).",
                },
                ["quit"] = {
                    map = "q",
                    cmd = "<cmd>lua require('spectre').close()<CR>",
                    desc = "quit.",
                },
            },
        },
    },


    -- trim.nvim [auto trim spaces]
    -- https://github.com/cappyzawa/trim.nvim
    {
        "cappyzawa/trim.nvim",
        event = "BufWrite",
        opts = {
            -- ft_blocklist = {"typescript"},
            trim_on_write = true,
            trim_trailing = true,
            trim_last_line = false,
            trim_first_line = false,
            -- patterns = {[[%s/\(\n\n\)\n\+/\1/]]}, -- Only one consecutive bl
        },
    },


    -- better-scape.nvim [esc]
    -- https://github.com/max397574/better-escape.nvim
    {
        "max397574/better-escape.nvim",
        event = "InsertCharPre",
        opts = {
            mapping = { 'jk' },
            timeout = 300,
            keys = "<Esc>",
        },
    },


    --  code [folding mod] + [promise-asyn] dependency
    --  https://github.com/kevinhwang91/nvim-ufo
    --  https://github.com/kevinhwang91/promise-async
    {
        "kevinhwang91/nvim-ufo",
        event = { "User BaseFile" },
        dependencies = { "kevinhwang91/promise-async" },
        opts = {
            preview = {
                mappings = {
                    scrollB = "<C-b>",
                    scrollF = "<C-f>",
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                },
            },
            provider_selector = function(_, filetype, buftype)
                local function handleFallbackException(bufnr, err, providerName)
                    if type(err) == "string" and err:match "UfoFallbackException" then
                        return require("ufo").getFolds(bufnr, providerName)
                    else
                        return require("promise").reject(err)
                    end
                end

                -- only use indent until a file is opened
                return (filetype == "" or buftype == "nofile") and "indent"
                    or function(bufnr)
                        return require("ufo")
                            .getFolds(bufnr, "lsp")
                            :catch(
                                function(err)
                                    return handleFallbackException(bufnr, err, "treesitter")
                                end
                            )
                            :catch(
                                function(err)
                                    return handleFallbackException(bufnr, err, "indent")
                                end
                            )
                    end
            end,
        },
    },

}
