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

-- Initialize platform-specific settings
function M.setup()
  M.setup_shell()
  
  -- Platform-specific options
  if M.is_windows then
    vim.opt.shellslash = true  -- Use forward slashes in file paths
  end
end

return M