-- Telescope LSP Menu - プラグイン読み込み後に設定
local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- LSPナビゲーションメニュー
local function telescope_lsp_menu(opts)
  opts = opts or {}
  
  -- 現在のバッファでサポートされている機能をチェック
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("No LSP client attached to this buffer", vim.log.levels.WARN)
    return
  end
  
  -- 利用可能な機能を収集
  local capabilities = {}
  for _, client in ipairs(clients) do
    if client.server_capabilities then
      for cap, enabled in pairs(client.server_capabilities) do
        if enabled then
          capabilities[cap] = true
        end
      end
    end
  end
  
  -- メニュー項目を動的に生成
  local menu_items = {}
  
  -- 定義へジャンプ
  if capabilities.definitionProvider then
    table.insert(menu_items, { name = "定義へジャンプ (gd)", action = "definition", icon = "󰊕 " })
  end
  
  -- 宣言へジャンプ
  if capabilities.declarationProvider then
    table.insert(menu_items, { name = "宣言へジャンプ (gD)", action = "declaration", icon = "󰊕 " })
  end
  
  -- 参照一覧
  if capabilities.referencesProvider then
    table.insert(menu_items, { name = "参照一覧 (gr)", action = "references", icon = " " })
  end
  
  -- 実装へジャンプ
  if capabilities.implementationProvider then
    table.insert(menu_items, { name = "実装へジャンプ (gI)", action = "implementation", icon = "󰡱 " })
  end
  
  -- ホバー表示（ほぼ全てのLSPがサポート）
  if capabilities.hoverProvider then
    table.insert(menu_items, { name = "ホバー表示 (K)", action = "hover", icon = " " })
  end
  
  -- 型定義へジャンプ
  if capabilities.typeDefinitionProvider then
    table.insert(menu_items, { name = "型定義へジャンプ (gy)", action = "type_definition", icon = " " })
  end
  
  if #menu_items == 0 then
    vim.notify("No LSP features available for this buffer", vim.log.levels.INFO)
    return
  end
  
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

-- コマンドを作成
vim.api.nvim_create_user_command("TelescopeLspMenu", function()
  telescope_lsp_menu()
end, {})

-- グローバル関数として登録（念のため）
_G.telescope_lsp_menu = telescope_lsp_menu