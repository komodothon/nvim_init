return {
  "Saghen/blink.cmp",
  build = "cargo build --release",  -- 👈 Compile native matcher
  event = "InsertEnter",
  dependencies = {
    "Saghen/blink.nvim",
  },
  config = function()
    require("blink.cmp").setup({
      popup = {
        border = "rounded",
        winblend = 10,
      },
      keymaps = {
        confirm = "<CR>",
        cancel = "<Esc>",
        next = "<Tab>",
        prev = "<S-Tab>",
      },
    })
  end,
}
