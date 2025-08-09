-- Keymaps configuration
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Window navigation with arrow keys (for consistency with terminal mode)
keymap("n", "<C-w><Left>", "<C-w>h", opts)
keymap("n", "<C-w><Down>", "<C-w>j", opts)
keymap("n", "<C-w><Up>", "<C-w>k", opts)
keymap("n", "<C-w><Right>", "<C-w>l", opts)

-- Window navigation from insert mode
keymap("i", "<C-w><Left>", "<C-\\><C-n><C-w>h", opts)
keymap("i", "<C-w><Down>", "<C-\\><C-n><C-w>j", opts)
keymap("i", "<C-w><Up>", "<C-\\><C-n><C-w>k", opts)
keymap("i", "<C-w><Right>", "<C-\\><C-n><C-w>l", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffer
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- Clear search highlighting
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":move '>+1<CR>gv=gv", opts)
keymap("v", "K", ":move '<-2<CR>gv=gv", opts)

-- Save file
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<ESC>:w<CR>a", opts)
keymap("n", "<leader>w", ":w<CR>", opts)

-- Save and quit
keymap("n", "<leader>x", ":x<CR>", opts)

-- Quit
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>Q", ":qa!<CR>", opts)

-- Split windows
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)

-- Better navigation in insert mode
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)

-- Smart line navigation
keymap({"n", "v"}, "<Left>", function()
  local col = vim.fn.col('.')
  if col == 1 then
    local line = vim.fn.line('.')
    if line > 1 then
      vim.cmd('normal! k$')
    end
  else
    vim.cmd('normal! h')
  end
end, opts)

keymap({"n", "v"}, "<Right>", function()
  local col = vim.fn.col('.')
  local line_len = #vim.fn.getline('.')
  if col >= line_len then
    local line = vim.fn.line('.')
    local last_line = vim.fn.line('$')
    if line < last_line then
      vim.cmd('normal! j0')
    end
  else
    vim.cmd('normal! l')
  end
end, opts)

-- Terminal
keymap("n", "<leader>tt", ":terminal<CR>", opts)
keymap("t", "<ESC>", "<C-\\><C-n>", opts)
-- Claude Code環境でESCが効かない場合の代替キー
keymap("t", "jj", "<C-\\><C-n>", opts)
keymap("t", "<C-[>", "<C-\\><C-n>", opts)

-- Claude Code: ターミナルモードから矢印キーでウィンドウ移動
keymap("t", "<C-w><Left>", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-w><Down>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-w><Up>", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-w><Right>", "<C-\\><C-n><C-w>l", opts)

-- Quick fix
keymap("n", "<leader>co", ":copen<CR>", opts)
keymap("n", "<leader>cc", ":cclose<CR>", opts)
keymap("n", "<leader>cn", ":cnext<CR>", opts)
keymap("n", "<leader>cp", ":cprev<CR>", opts)
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)

-- Tags navigation (for compatibility)
keymap("n", "<C-]>", "<C-]>", opts)
keymap("n", "<C-t>", "<C-t>", opts)

-- LSP navigation menu with Telescope
keymap("n", "<leader>ln", ":TelescopeLspMenu<CR>", { noremap = true, silent = true, desc = "LSP navigation menu" })
keymap("v", "<leader>ln", "<Esc>:TelescopeLspMenu<CR>", { noremap = true, silent = true, desc = "LSP navigation menu" })


-- Help navigation
keymap("n", "gf", "gf", opts)
keymap("n", "gx", "gx", opts)

-- Yank history (for Unite replacement)
keymap("n", "<leader>uy", ":Telescope registers<CR>", opts)

-- New file/directory
keymap("n", "<leader>nf", ":e ", { noremap = true })
keymap("n", "<leader>nd", ":!mkdir -p ", { noremap = true })
keymap("n", "<leader>ns", ":e %:h/", { noremap = true })
keymap("n", "<leader>nr", ":file ", { noremap = true })
keymap("n", "<leader>nD", ":!rm %<CR>", opts)

-- Fugitive
keymap("n", "<leader>gs", ":Git<CR>", opts)
keymap("n", "<leader>gb", ":Git blame<CR>", opts)

-- Translate (requires vim-translator plugin)
-- Translator plugin handles <leader>t mappings

-- Avante (fallback mappings)
keymap("n", "<leader>ae", ":AvanteEdit<CR>", opts)
keymap("v", "<leader>ae", ":AvanteEdit<CR>", opts)
keymap("n", "<leader>aa", ":AvanteAsk<CR>", opts)
keymap("n", "<leader>at", ":AvanteToggle<CR>", opts)
keymap("n", "<leader>ac", ":AvanteChat<CR>", opts)
keymap("n", "<leader>af", ":AvanteFocus<CR>", opts)
keymap("n", "<leader>ar", ":AvanteRefresh<CR>", opts)

-- F4でAvanteトグル
keymap("n", "<F4>", ":AvanteToggle<CR>", opts)

-- Telescope all commands
keymap("n", ":;", ":Telescope commands<CR>", opts)

-- Telescope command history
keymap("n", ";;", ":Telescope command_history<CR>", opts)