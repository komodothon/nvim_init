  -- Mason for managing LSP servers
return {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
}
