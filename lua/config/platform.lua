-- Platform-specific configurations
local M = {}

-- Detect OS
M.is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
M.is_mac = vim.fn.has('macunix') == 1
M.is_linux = vim.fn.has('unix') == 1 and not M.is_mac
M.is_wsl = vim.fn.has('wsl') == 1

-- Get appropriate commands for each platform
function M.get_find_command()
  if M.is_windows then
    -- Windows: fd.exeを使用
    if vim.fn.executable('fd') == 1 then
      return { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' }
    else
      -- fallback to dir command
      return nil
    end
  elseif M.is_mac then
    -- macOS: fdを使用（Homebrewでインストール）
    if vim.fn.executable('fd') == 1 then
      return { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' }
    else
      return nil
    end
  else
    -- Linux/WSL: fdfindを使用
    if vim.fn.executable('fdfind') == 1 then
      return { 'fdfind', '--type', 'f', '--strip-cwd-prefix', '--hidden', '--exclude', '.git' }
    elseif vim.fn.executable('fd') == 1 then
      return { 'fd', '--type', 'f', '--strip-cwd-prefix', '--hidden', '--exclude', '.git' }
    else
      return nil
    end
  end
end

-- Get ripgrep command
function M.get_rg_command()
  if vim.fn.executable('rg') == 1 then
    return 'rg'
  elseif M.is_windows and vim.fn.executable('rg.exe') == 1 then
    return 'rg.exe'
  else
    return nil
  end
end

-- Platform-specific paths
function M.get_data_path()
  if M.is_windows then
    return vim.fn.expand('~/AppData/Local/nvim-data')
  else
    return vim.fn.stdpath('data')
  end
end

-- Shell configuration
function M.setup_shell()
  if M.is_windows then
    -- PowerShellを優先
    if vim.fn.executable('pwsh') == 1 then
      vim.o.shell = 'pwsh'
      vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
      vim.o.shellxquote = ''
      vim.o.shellquote = ''
      vim.o.shellpipe = '| Out-File -Encoding UTF8 %s'
      vim.o.shellredir = '| Out-File -Encoding UTF8 %s'
    elseif vim.fn.executable('powershell') == 1 then
      vim.o.shell = 'powershell'
      vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
      vim.o.shellxquote = ''
      vim.o.shellquote = ''
      vim.o.shellpipe = '| Out-File -Encoding UTF8 %s'
      vim.o.shellredir = '| Out-File -Encoding UTF8 %s'
    end
  end
end

-- IME control functions
function M.ime_off()
  if M.is_mac then
    -- macOS: im-selectを使用（要インストール: brew install im-select）
    if vim.fn.executable('im-select') == 1 then
      vim.fn.system('im-select com.apple.keylayout.ABC')
    end
  elseif M.is_windows or M.is_wsl then
    -- Windows/WSL: zenhan.exeを使用（scoopでインストール済み）
    if vim.fn.executable('zenhan.exe') == 1 then
      vim.fn.jobstart('zenhan.exe 0', { detach = true })  -- 非同期実行で高速化
    elseif M.is_wsl and vim.fn.executable('powershell.exe') == 1 then
      -- WSL: PowerShell経由でIMEを制御（フォールバック）
      vim.fn.jobstart([[powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('%( )')"]], { detach = true })
    end
  elseif M.is_linux then
    -- Linux: fcitx/ibus制御
    if vim.fn.executable('fcitx-remote') == 1 then
      vim.fn.system('fcitx-remote -c')  -- IMEをオフ
    elseif vim.fn.executable('fcitx5-remote') == 1 then
      vim.fn.system('fcitx5-remote -c')  -- Fcitx5をオフ
    elseif vim.fn.executable('ibus') == 1 then
      vim.fn.system('ibus engine xkb:us::eng')  -- IBusを英語に
    end
  end
end

-- Setup IME auto-off on mode change
function M.setup_ime()
  -- InsertLeaveイベントでIMEを自動的にオフ
  vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
      M.ime_off()
    end,
    desc = "Auto turn off IME when leaving insert mode",
  })
  
  -- EscキーでもIMEをオフ（念のため）
  vim.keymap.set("i", "<Esc>", function()
    M.ime_off()
    return "<Esc>"
  end, { expr = true, desc = "Turn off IME and exit insert mode" })
end

-- Initialize platform-specific settings
function M.setup()
  M.setup_shell()
  
  -- Platform-specific options
  if M.is_windows then
    vim.opt.shellslash = true  -- Use forward slashes in file paths
  end
  
  -- IME制御のセットアップ
  M.setup_ime()
end

return M