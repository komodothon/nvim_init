-- lualine plugin

return {
 "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional but recommended
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto", -- or try "base16", "gruvbox", "tokyonight", etc.
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
    })
  end,
}
