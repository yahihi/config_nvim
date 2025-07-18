return {
  {
    "hrsh7th/vim-searchx",
    keys = {
      { "/", "<Plug>(searchx-forward)", mode = { "n", "x", "o" } },
      { "?", "<Plug>(searchx-backward)", mode = { "n", "x", "o" } },
      { "n", "<Plug>(searchx-next)", mode = { "n", "x", "o" } },
      { "N", "<Plug>(searchx-prev)", mode = { "n", "x", "o" } },
      { "*", "<Plug>(searchx-select)", mode = "v" },
    },
    config = function()
      vim.g.searchx = {
        auto_accept = true,
        scrolloff = vim.o.scrolloff,
        scrolltime = 500,
        nohlsearch = {
          jump = true,
        },
        markers = {
          current = "[>]",
          others = "[-]",
        },
        convert = function(input)
          if string.match(input, "^%s*jj%s*$") ~= nil then
            return vim.fn.escape(vim.fn.getreg("j"), [[\/]])
          end
          return input
        end,
      }

      -- Enhanced keymaps for searchx
      vim.keymap.set({ "n", "x", "o" }, ";", function()
        require("searchx").next()
      end)
      
      vim.keymap.set({ "n", "x", "o" }, ",", function()
        require("searchx").prev()
      end)

      -- Clear search highlighting
      vim.keymap.set("n", "<Esc><Esc>", function()
        require("searchx").clear()
      end)

      -- Visual star search
      vim.keymap.set("x", "*", function()
        require("searchx").select()
      end)
    end,
  },
}