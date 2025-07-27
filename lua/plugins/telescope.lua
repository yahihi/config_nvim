return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    cmd = { "Telescope", "TelescopeLspMenu" },
    event = "VeryLazy",
    keys = {
      { "::", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fa", "<cmd>Telescope find_files<cr>", desc = "All Files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { ":<CR>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer Search" },
      { ":@", function() require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Find files from current directory" },
      -- Unite-like commands
      { "<leader>uc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>um", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>uh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      -- Telescope builtin picker
      { "<leader><leader>", function() require("telescope.builtin").builtin() end, desc = "Telescope Builtin" },
      { "<leader>ft", function() require("telescope.builtin").builtin() end, desc = "Telescope Builtin" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          file_ignore_patterns = { "^.git/" },  -- .gitディレクトリのみ除外
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-f>"] = actions.results_scrolling_up,
              ["<C-b>"] = actions.results_scrolling_down,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
            },
          },
        },
        pickers = {
          find_files = {
            -- プラットフォーム別のfindコマンドを使用
            find_command = require("config.platform").get_find_command(),
            hidden = true,  -- 隠しファイルも表示
          },
          live_grep = {
            -- 隠しファイルも検索対象に含める
            additional_args = function()
              return { "--hidden" }
            end,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      
      -- Load extensions
      telescope.load_extension("fzf")
      
      -- LSPナビゲーションメニュー
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      
      local function telescope_lsp_menu(opts)
        opts = opts or {}
        
        local menu_items = {
          { name = "定義へジャンプ (gd)", action = "definition", icon = "󰊕 " },
          { name = "宣言へジャンプ (gD)", action = "declaration", icon = "󰊕 " },
          { name = "参照一覧 (gr)", action = "references", icon = " " },
          { name = "実装へジャンプ (gI)", action = "implementation", icon = "󰡱 " },
          { name = "ホバー表示 (K)", action = "hover", icon = " " },
          { name = "型定義へジャンプ (gy)", action = "type_definition", icon = " " },
        }
        
        pickers.new(opts, {
          prompt_title = "LSP Navigation",
          finder = finders.new_table({
            results = menu_items,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.icon .. entry.name,
                ordinal = entry.name,
              }
            end,
          }),
          sorter = conf.generic_sorter(opts),
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              if selection then
                local action = selection.value.action
                
                if action == "definition" then
                  vim.lsp.buf.definition()
                elseif action == "declaration" then
                  vim.lsp.buf.declaration()
                elseif action == "references" then
                  vim.lsp.buf.references()
                elseif action == "implementation" then
                  vim.lsp.buf.implementation()
                elseif action == "hover" then
                  vim.lsp.buf.hover()
                elseif action == "type_definition" then
                  vim.lsp.buf.type_definition()
                end
              end
            end)
            return true
          end,
        }):find()
      end
      
      vim.api.nvim_create_user_command("TelescopeLspMenu", function()
        telescope_lsp_menu()
      end, {})
    end,
  },
}