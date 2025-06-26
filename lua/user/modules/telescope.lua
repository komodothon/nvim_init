-- Telescope
return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep text" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })
    end,
}
