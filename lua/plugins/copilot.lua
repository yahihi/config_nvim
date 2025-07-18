return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Disable default mappings
      vim.g.copilot_no_tab_map = true
      
      -- Custom mappings
      vim.keymap.set("i", "<Tab>", 'copilot#Accept("\\<Tab>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
      })
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", { silent = true })
      vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { silent = true })
      vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { silent = true })
      
      -- WSL specific authentication command
      vim.cmd([[
        command! CopilotAuthWSL lua vim.fn.system('echo "$(cat ~/.config/github-copilot/hosts.json 2>/dev/null | grep -o \\"[0-9a-zA-Z-]\\{8,\\}\\" | head -1)" | clip.exe 2>/dev/null || echo "Device code copied to clipboard"'); vim.cmd('Copilot auth')
      ]])
      
      -- Setup guide command
      vim.cmd([[
        command! CopilotSetupGuide echo "Copilot Setup:\n1. Run :Copilot setup\n2. For WSL: Run :CopilotAuthWSL\n3. Open https://github.com/login/device in browser\n4. Paste device code and authorize\n5. Return to Neovim and press Enter\n6. Check status with :Copilot status"
      ]])
      
      -- Open browser command (for WSL/Linux)
      vim.cmd([[
        command! CopilotOpenBrowser lua vim.fn.system(vim.fn.has('wsl') == 1 and 'cmd.exe /c start https://github.com/login/device' or 'xdg-open https://github.com/login/device')
      ]])
      
      -- Status command
      vim.cmd([[
        command! CopilotStatus lua vim.cmd('Copilot status')
      ]])
    end,
  },
}