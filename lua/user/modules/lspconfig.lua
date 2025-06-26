-- LSP config
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP completion source
  },
  config = function()
    local lspconfig = require("lspconfig")
    
    -- Get LSP capabilities from nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Shared on_attach function to set LSP keymaps
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }

      -- Essential navigation
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      
      -- Code actions
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

      -- Diagnostics
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)
      
      -- Highlight symbol under cursor
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", {
          clear = false
        })
        vim.api.nvim_clear_autocmds({
          buffer = bufnr,
          group = "lsp_document_highlight",
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          group = "lsp_document_highlight",
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          group = "lsp_document_highlight",
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end

    -- Configure diagnostic signs
    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Configure diagnostics
    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Configure LSP handlers
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded"
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded"
    })

    -- Python LSP (Pyright)
    lspconfig.pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            autoImportCompletions = true,
          },
        },
      },
    })

    -- Lua LSP
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })

    -- TypeScript/JavaScript LSP
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- JSON LSP
    lspconfig.jsonls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    -- YAML LSP
    lspconfig.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- HTML LSP
    lspconfig.html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- CSS LSP
    lspconfig.cssls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Tailwind CSS LSP
    lspconfig.tailwindcss.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Rust LSP
    lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            command = "clippy",
          },
        },
      },
    })

    -- Go LSP
    lspconfig.gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- C/C++ LSP
    lspconfig.clangd.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
    })

    -- Bash LSP
    lspconfig.bashls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Docker LSP
    lspconfig.dockerls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Markdown LSP
    lspconfig.marksman.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
