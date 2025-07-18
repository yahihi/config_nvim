-- Telescopeメニュー拡張
return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      -- Telescopeコマンドのエイリアス
      vim.cmd([[
        command! T lua require("telescope.builtin").builtin()
        command! Tel lua require("telescope.builtin").builtin()
        
        " よく使うTelescopeコマンドのエイリアス
        command! TF Telescope find_files
        command! TG Telescope live_grep
        command! TB Telescope buffers
        command! TH Telescope help_tags
        command! TC Telescope commands
        command! TK Telescope keymaps
        command! TR Telescope registers
        command! TY Telescope yank_history
      ]])
      
      -- カスタムpicker：Telescopeコマンドのみを表示
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      
      local telescope_commands = function(opts)
        opts = opts or {}
        
        -- Telescopeの全てのbuiltinを取得
        local builtin = require("telescope.builtin")
        local commands = {}
        
        for name, _ in pairs(builtin) do
          table.insert(commands, name)
        end
        
        table.sort(commands)
        
        pickers.new(opts, {
          prompt_title = "Telescope Commands",
          finder = finders.new_table({
            results = commands,
          }),
          sorter = conf.generic_sorter(opts),
          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              if selection then
                vim.cmd("Telescope " .. selection[1])
              end
            end)
            return true
          end,
        }):find()
      end
      
      -- グローバル関数として登録
      _G.telescope_commands = telescope_commands
      
      -- コマンド登録
      vim.cmd([[command! TelescopeCommands lua telescope_commands()]])
    end,
  },
}