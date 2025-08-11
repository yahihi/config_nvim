-- Neovim configuration
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configurations
require("config.platform").setup()  -- Platform-specific setup
require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.neovide")  -- Neovide-specific settings

-- Load plugins
require("lazy").setup("plugins", {
  defaults = {
    lazy = true,  -- 遅延読み込みをデフォルトに
  },
  install = {
    colorscheme = { "tokyonight" },
  },
  rocks = {
    enabled = false,  -- luarocksサポートを無効化
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
