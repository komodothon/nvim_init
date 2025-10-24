
-- lua/user/plugins/base16.lua

return {
    "RRethy/base16-nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.base16_transparent_background = true
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "base16-*",
            callback = function()
                vim.cmd [[
                    highlight Normal guibg=NONE ctermbg=NONE
                    highlight NormalNC guibg=NONE ctermbg=NONE
                    highlight NormalFloat guibg=NONE ctermbg=NONE
                    highlight FloatBorder guibg=NONE ctermbg=NONE
                    highlight SignColumn guibg=#404040 ctermbg=238
                    highlight VertSplit guibg=NONE ctermbg=NONE
                    
                    " Cursorline with subtle highlight
                    highlight CursorLine guibg=#404040 ctermbg=238
                    highlight CursorLineNr guifg=#d8d8d8 guibg=#404040 gui=bold ctermfg=253 ctermbg=238
                ]]
            end,
        })
        vim.cmd("colorscheme base16-ia-dark")
    end,
}

-- return {
--     "RRethy/base16-nvim",
--     priority = 1000, -- Ensure it's loaded early
--     config = function()
--       vim.g.base16_transparent_background = true
--       vim.cmd("colorscheme base16-ia-dark")
--
--       -- Force transparent background manually
--       vim.cmd [[
--         highlight Normal guibg=NONE ctermbg=NONE
--         highlight NormalNC guibg=NONE ctermbg=NONE
--         highlight NormalFloat guibg=NONE ctermbg=NONE
--         highlight FloatBorder guibg=NONE ctermbg=NONE
--         highlight SignColumn guibg=NONE ctermbg=NONE
--         highlight VertSplit guibg=NONE ctermbg=NONE
--       ]]
--     end,
--
-- }
