vim.opt.colorcolumn = "140" -- vertical separator after 140 chars
vim.opt.number = true       -- Show line numbers
vim.opt.showtabline = 2     -- always display tabline.
vim.opt.ignorecase = true   -- Case insensitive searching.
vim.opt.infercase = true    -- Infer cases in keyword completion.


vim.opt.laststatus = 3         -- Globalstatus.
vim.opt.linebreak = true       -- Wrap lines at'breakat'.
vim.opt.preserveindent = true  -- Preserve indent structure as much as possible.
vim.opt.pumheight = 10         -- Height of the pop up menu.
vim.opt.relativenumber = false -- Show relative numberline.
vim.opt.shiftwidth = 2         -- Number of space inserted for indentation.
vim.opt.showmode = false       -- Disable showing modes in command line.
vim.opt.signcolumn = "yes"     -- Always show the sign column.
vim.opt.smartcase = true       -- Case sensitivie searching.
vim.opt.smartindent = false    -- Smarter autoindentation.
vim.opt.splitbelow = true      -- Splitting a new window below the current one.
vim.opt.splitright = true      -- Splitting a new window at the right of the current one.
vim.opt.tabstop = 2            -- Number of space in a tab.

vim.opt.termguicolors = true   -- Enable 24-bit RGB color in the TUI.
vim.opt.timeoutlen = 500       -- Shorten key timeout length a little bit for which-key.
vim.opt.undofile = true        -- Enable persistent undo between session and reboots.
vim.opt.updatetime = 300       -- Length of time to wait before triggering the plugin.
vim.opt.virtualedit = "block"  -- Allow going past end of line in visual block mode.

vim.opt.cmdheight = 0          -- Hide command line unless needed.

vim.g.mapleader = " "          -- Set leader key.
vim.g.maplocalleader = ","     -- Set default local leader key.


vim.o.foldcolumn = '1'    -- '0' is not bad
vim.o.foldlevel = 99      -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99 -- Start with all code unfolded.
vim.o.foldenable = true


-- The next globals are toggleable with <space + l + u>
vim.g.autoformat_enabled = false       -- Enable auto formatting at start.
vim.g.autopairs_enabled = false        -- Enable autopairs at start.
vim.g.cmp_enabled = true               -- Enable completion at start.
vim.g.codeactions_enabled = true       -- Enable displaying 💡 where code actions can be used.
vim.g.codelens_enabled = true          -- Enable automatic codelens refreshing for lsp that support it.
vim.g.diagnostics_mode = 3             -- Set code linting (0=off, 1=only show in status line, 2=virtual text off, 3=all on).
vim.g.icons_enabled = true             -- Enable icons in the UI (disable if no nerd font is available).
vim.g.inlay_hints_enabled = false      -- Enable always show function parameter names.
vim.g.lsp_round_borders_enabled = true -- Enable round borders for lsp hover and signatureHelp.
vim.g.lsp_signature_enabled = true     -- Enable automatically showing lsp help as you write function parameters.
vim.g.notifications_enabled = true     -- Enable notifications.
vim.g.semantic_tokens_enabled = true   -- Enable lsp semantic tokens at start.
vim.g.url_effect_enabled = true        -- Highlight URLs with an underline effect.


vim.g.big_file = { size = 1024 * 100, lines = 10000 } -- For files bigger than this, disable 'treesitter' (+100kb).
