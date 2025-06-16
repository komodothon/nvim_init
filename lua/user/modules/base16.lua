
-- lua/user/plugins/base16.lua

return {
    "RRethy/base16-nvim",
    priority = 1000, -- Ensure it's loaded early
    config = function()
      vim.cmd("colorscheme base16-ia-dark")
    end,
}
