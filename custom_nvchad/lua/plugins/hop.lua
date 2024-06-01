return {
  'smoka7/hop.nvim',
  version = "*",
  opts = {
    multi_windows = true,
    keys = 'etovxqpdygfblzhckisuran',
    uppercase_labels = true,
  },
  keys = {
    {
      "<leader>fj",
      function()
        require("hop").hint_words()
      end,
      mode = { "n", "x", "o" },
    },
  },
}
