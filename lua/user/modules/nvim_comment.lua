-- comment
return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      toggler = {
        line = "gcc",     -- Toggle current line comment
        block = "gbc",    -- Toggle current block comment
      },
      opleader = {
        line = "gc",      -- Comment operator for lines
        block = "gb",     -- Comment operator for blocks
      },
    })
  end,
}
