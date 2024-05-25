return {
    -- project.nvim [project search + auto cd]
    -- https://github.com/ahmedkhalf/project.nvim
    {
        "Zeioth/project.nvim",
        event = "User BaseDefered",
        cmd = "ProjectRoot",
        opts = {
            -- How to find root directory
            patterns = {
                "_darcs",
                ".hg",
                ".bzr",
                ".svn",
                "Makefile",
                "package.json",
                ".solution",
                ".solution.toml",
                ".git"
            },
            detection_methods = { "pattern", "lsp" },
        },
        config = function(_, opts) require("project_nvim").setup(opts) end,
    },


    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",    -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        cmd = "Neotree",
        opts = function()
            vim.g.neo_tree_remove_legacy_commands = true
            local utils = require("base.utils")
            local get_icon = utils.get_icon
            return {
                auto_clean_after_session_restore = true,
                close_if_last_window = true,
                buffers = {
                    show_unloaded = true
                },
                sources = { "filesystem", "buffers", "git_status", "document_symbols" },
                source_selector = {
                    winbar = true,
                    content_layout = "center",
                    sources = {
                        {
                            source = "filesystem",
                            display_name = get_icon("FolderClosed", 1, true) .. "File",
                        },
                        {
                            source = "buffers",
                            display_name = get_icon("DefaultFile", 1, true) .. "Bufs",
                        },
                        {
                            source = "git_status",
                            display_name = get_icon("Git", 1, true) .. "Git",
                        },
                        {
                            source = "diagnostics",
                            display_name = get_icon("Diagnostic", 1, true) .. "Diagnostic",
                        },
                    },
                },
                default_component_configs = {
                    indent = { padding = 0 },
                    icon = {
                        folder_closed = get_icon("FolderClosed"),
                        folder_open = get_icon("FolderOpen"),
                        folder_empty = get_icon("FolderEmpty"),
                        folder_empty_open = get_icon("FolderEmpty"),
                        default = get_icon "DefaultFile",
                    },
                    modified = { symbol = get_icon "FileModified" },
                    git_status = {
                        symbols = {
                            added = get_icon("GitAdd"),
                            deleted = get_icon("GitDelete"),
                            modified = get_icon("GitChange"),
                            renamed = get_icon("GitRenamed"),
                            untracked = get_icon("GitUntracked"),
                            ignored = get_icon("GitIgnored"),
                            unstaged = get_icon("GitUnstaged"),
                            staged = get_icon("GitStaged"),
                            conflict = get_icon("GitConflict"),
                        },
                    },
                },
                -- A command is a function that we can assign to a mapping (below)
                commands = {
                    system_open = function(state)
                        require("base.utils").open_with_program(state.tree:get_node():get_id())
                    end,
                    parent_or_close = function(state)
                        local node = state.tree:get_node()
                        if
                            (node.type == "directory" or node:has_children())
                            and node:is_expanded()
                        then
                            state.commands.toggle_node(state)
                        else
                            require("neo-tree.ui.renderer").focus_node(
                                state,
                                node:get_parent_id()
                            )
                        end
                    end,
                    child_or_open = function(state)
                        local node = state.tree:get_node()
                        if node.type == "directory" or node:has_children() then
                            if not node:is_expanded() then    -- if unexpanded, expand
                                state.commands.toggle_node(state)
                            else                              -- if expanded and has children, seleect the next child
                                require("neo-tree.ui.renderer").focus_node(
                                    state,
                                    node:get_child_ids()[1]
                                )
                            end
                        else    -- if not a directory just open it
                            state.commands.open(state)
                        end
                    end,
                    copy_selector = function(state)
                        local node = state.tree:get_node()
                        local filepath = node:get_id()
                        local filename = node.name
                        local modify = vim.fn.fnamemodify

                        local results = {
                            e = { val = modify(filename, ":e"), msg = "Extension only" },
                            f = { val = filename, msg = "Filename" },
                            F = {
                                val = modify(filename, ":r"),
                                msg = "Filename w/o extension",
                            },
                            h = {
                                val = modify(filepath, ":~"),
                                msg = "Path relative to Home",
                            },
                            p = {
                                val = modify(filepath, ":."),
                                msg = "Path relative to CWD",
                            },
                            P = { val = filepath, msg = "Absolute path" },
                        }

                        local messages = {
                            { "\nChoose to copy to clipboard:\n", "Normal" },
                        }
                        for i, result in pairs(results) do
                            if result.val and result.val ~= "" then
                                vim.list_extend(messages, {
                                    { ("%s."):format(i),           "Identifier" },
                                    { (" %s: "):format(result.msg) },
                                    { result.val,                  "String" },
                                    { "\n" },
                                })
                            end
                        end
                        vim.api.nvim_echo(messages, false, {})
                        local result = results[vim.fn.getcharstr()]
                        if result and result.val and result.val ~= "" then
                            vim.notify("Copied: " .. result.val)
                            vim.fn.setreg("+", result.val)
                        end
                    end,
                    find_in_dir = function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        require("telescope.builtin").find_files {
                            cwd = node.type == "directory" and path
                                or vim.fn.fnamemodify(path, ":h"),
                        }
                    end,
                },
                window = {
                    width = 30,
                    mappings = {
                        ["<space>"] = false,    -- disable space until we figure out which-key disabling
                        ["<S-CR>"] = "system_open",
                        ["[b"] = "prev_source",
                        ["]b"] = "next_source",
                        F = utils.is_available "telescope.nvim" and "find_in_dir" or nil,
                        O = "system_open",
                        Y = "copy_selector",
                        h = "parent_or_close",
                        l = "child_or_open",
                    },
                },
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                    },
                    hijack_netrw_behavior = "open_current",
                    use_libuv_file_watcher = true,
                },
                event_handlers = {
                    {
                        event = "neo_tree_buffer_enter",
                        handler = function(_) vim.opt_local.signcolumn = "auto" end,
                    },
                },
            }
        end,
    },

    -- session-manager [session]
    -- https://github.com/Shatur/neovim-session-manager
    {
        "Shatur/neovim-session-manager",
        event = "User BaseDefered",
        cmd = "SessionManager",
        opts = function()
            local config = require('session_manager.config')
            return {
                autoload_mode = config.AutoloadMode.Disabled,
                autosave_last_session = false,
                autosave_only_in_session = false,
            }
        end,
        config = function(_, opts)
            local session_manager = require('session_manager')
            session_manager.setup(opts)

            -- Auto save session
            -- BUG: This feature will auto-close anything nofile before saving.
            --      This include neotree, aerial, mergetool, among others.
            --      Consider commenting the next block if this is important for you.
            --
            --      This won't be necessary once neovim fixes:
            --      https://github.com/neovim/neovim/issues/12242
            -- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            --   callback = function ()
            --     session_manager.save_current_session()
            --   end
            -- })
        end
    },

}
