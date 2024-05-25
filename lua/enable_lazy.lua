local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = {
    spec = { import = "lazy_plugins" },
    defaults = { lazy = true },
    performance = {
        rtp = { -- Use deflate to download faster from the plugin repos.
            disabled_plugins = {
                "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin"
            },
        },
    },
}


require("lazy").setup(lazy_config)
