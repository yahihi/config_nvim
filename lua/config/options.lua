-- Basic editor options
local opt = vim.opt

-- Python3 provider
vim.g.python3_host_prog = vim.fn.expand('~/.config/nvim/pynvim-env/bin/python')

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Backup
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.termguicolors = true
opt.pumheight = 10
opt.cmdheight = 1
opt.laststatus = 3

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indent
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true

-- Text width and wrapping
opt.textwidth = 80
opt.colorcolumn = "80"
opt.wrap = true  -- 画面端で折り返す
opt.linebreak = true  -- 単語境界で折り返す
opt.breakindent = true  -- インデントを保持して折り返す
opt.formatoptions:append("t")  -- テキストを自動的に折り返す
opt.formatoptions:append("c")  -- コメントも自動的に折り返す

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Completion
opt.completeopt = "menuone,noselect"

-- Folds
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 99

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- List chars
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Fillchars
opt.fillchars = { eob = " " }