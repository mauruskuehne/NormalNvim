-- HELLO, welcome to NormalNvim!
-- ---------------------------------------
-- This is the entry point of your config.
-- ---------------------------------------

-- EVERY TIME NEOVIM OPENS:
-- Compile lua to bytecode if the nvim version supports it.
if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then
    vim.loader.enable()
end
