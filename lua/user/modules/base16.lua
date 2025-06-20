
-- lua/user/plugins/base16.lua

return {
    "RRethy/base16-nvim",
    priority = 1000, -- Ensure it's loaded early
    config = function()
      vim.g.base16_transparent_background = true
      vim.cmd("colorscheme base16-ia-dark")

      -- Force transparent background manually
      vim.cmd [[
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight NormalFloat guibg=NONE ctermbg=NONE
        highlight FloatBorder guibg=NONE ctermbg=NONE
        highlight SignColumn guibg=NONE ctermbg=NONE
        highlight VertSplit guibg=NONE ctermbg=NONE
      ]]
    end,

}
