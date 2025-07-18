-- Autocmds configuration
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor position
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = "RestoreCursor",
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Format options - 80文字折り返しの設定
augroup("FormatOptions", { clear = true })
autocmd("BufEnter", {
  group = "FormatOptions",
  pattern = "*",
  callback = function()
    -- 自動折り返しを有効にする
    vim.opt_local.formatoptions = vim.opt_local.formatoptions
      + "t"    -- textwidthで自動折り返し
      + "c"    -- コメントも自動折り返し
      + "q"    -- gqでフォーマット可能
      + "w"    -- 行末の空白で段落を認識
      - "l"    -- 長い行でも折り返す
  end,
})

-- Close certain filetypes with q
augroup("QuickClose", { clear = true })
autocmd("FileType", {
  group = "QuickClose",
  pattern = {
    "help",
    "qf",
    "lspinfo",
    "man",
    "notify",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Auto create directory when saving file
augroup("AutoCreateDir", { clear = true })
autocmd("BufWritePre", {
  group = "AutoCreateDir",
  pattern = "*",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})


-- Terminal settings
augroup("TerminalSettings", { clear = true })
autocmd("TermOpen", {
  group = "TerminalSettings",
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
})

-- Transparent background (optional)
augroup("TransparentBg", { clear = true })
autocmd("ColorScheme", {
  group = "TransparentBg",
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
  end,
})

-- Neo-tree開いた後も透明度を維持
autocmd("FileType", {
  group = "TransparentBg",
  pattern = "neo-tree",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
  end,
})