-- Fast code outline with Treesitter support
return {
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen" },
    keys = {
      { "<F9>", "<cmd>AerialToggle<cr>", desc = "Toggle code outline" },
      { "{", "<cmd>AerialPrev<cr>", desc = "Previous symbol" },
      { "}", "<cmd>AerialNext<cr>", desc = "Next symbol" },
    },
    opts = {
      -- Treesitterを優先、フォールバックとしてLSP
      backends = { "treesitter", "lsp", "markdown", "man" },
      
      layout = {
        max_width = { 40, 0.2 },
        width = nil,
        min_width = 20,
        win_opts = {},
        default_direction = "prefer_right",
        placement = "edge",  -- 全体を表示
      },
      
      -- パフォーマンス設定
      lazy_load = false,  -- 全体を即座に読み込み
      update_events = "TextChanged,InsertLeave",
      
      -- ファイル全体を表示
      attach_mode = "global",
      
      -- アイコン設定
      icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
      },
      
      -- Treesitterの高速化
      treesitter = {
        update_delay = 50,
      },
      
      -- 自動的にジャンプ
      close_on_select = false,
      
      -- ハイライト設定
      highlight_on_hover = true,
      highlight_on_jump = 300,
      
      -- フィルタ設定
      filter_kind = false,
      
      -- スコープ設定
      show_guides = true,
      
      -- キーマップ
      keymaps = {
        ["<CR>"] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["p"] = "actions.scroll",
        ["<C-j>"] = "actions.down_and_scroll",
        ["<C-k>"] = "actions.up_and_scroll",
        ["{"] = "actions.prev",
        ["}"] = "actions.next",
        ["[["] = "actions.prev_up",
        ["]]"] = "actions.next_up",
        ["q"] = "actions.close",
        ["o"] = "actions.tree_toggle",
        ["za"] = "actions.tree_toggle",
        ["O"] = "actions.tree_toggle_recursive",
        ["zA"] = "actions.tree_toggle_recursive",
        ["l"] = "actions.tree_open",
        ["zo"] = "actions.tree_open",
        ["L"] = "actions.tree_open_recursive",
        ["zO"] = "actions.tree_open_recursive",
        ["h"] = "actions.tree_close",
        ["zc"] = "actions.tree_close",
        ["H"] = "actions.tree_close_recursive",
        ["zC"] = "actions.tree_close_recursive",
        ["zr"] = "actions.tree_increase_fold_level",
        ["zR"] = "actions.tree_open_all",
        ["zm"] = "actions.tree_decrease_fold_level",
        ["zM"] = "actions.tree_close_all",
        ["zx"] = "actions.tree_sync_folds",
        ["zX"] = "actions.tree_sync_folds",
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-web-devicons",
    },
  },
}