-- blink.cmp

return {
  "Saghen/blink.cmp",
  version = "1.*",  -- ✅ Use tagged release with prebuilt binaries
  event = "InsertEnter",
  dependencies = { "Saghen/blink.nvim" },
  config = function()
    require("blink.cmp").setup({
      popup = { border = "rounded", winblend = 10 },
      keymaps = {
        confirm = "<CR>",
        cancel  = "<Esc>",
        next    = "<Tab>",
        prev    = "<S-Tab>",
      },
    })
  end,
}
