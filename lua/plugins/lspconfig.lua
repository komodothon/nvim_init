return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Native LSP capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Shared on_attach function
    local on_attach = function(client, bufnr)
      local map = vim.keymap.set
      local opts = { buffer = bufnr, silent = true }

      -- Navigation
      map("n", "gd", vim.lsp.buf.definition, opts)
      map("n", "gr", vim.lsp.buf.references, opts)
      map("n", "K", vim.lsp.buf.hover, opts)

      -- Actions
      map("n", "<leader>rn", vim.lsp.buf.rename, opts)
      map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

      -- Diagnostics
      map("n", "[d", vim.diagnostic.goto_prev, opts)
      map("n", "]d", vim.diagnostic.goto_next, opts)
      map("n", "<leader>dd", vim.diagnostic.open_float, opts)

      -- Highlight current symbol
      if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          group = group,
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          group = group,
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end

      -- Enable omni completion (for blink.cmp)
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    -- Diagnostics config (signs are now configured here)
    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚",
          [vim.diagnostic.severity.WARN] = "󰀪",
          [vim.diagnostic.severity.HINT] = "󰌶",
          [vim.diagnostic.severity.INFO] = "󰋽",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      },
    })

    -- Handlers with borders
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "rounded" }
    )
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded" }
    )

    -- Configure servers using the new API
    -- Python
    vim.lsp.config.pyright = {
      capabilities = capabilities,
      on_attach = on_attach,
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
    }

    -- Lua
    vim.lsp.config.lua_ls = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
          completion = { callSnippet = "Replace" },
        },
      },
    }

    -- TypeScript
    vim.lsp.config.ts_ls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- JSON
    vim.lsp.config.jsonls = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }

    -- YAML
    vim.lsp.config.yamlls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- HTML
    vim.lsp.config.html = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- CSS
    vim.lsp.config.cssls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Tailwind
    vim.lsp.config.tailwindcss = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Rust
    vim.lsp.config.rust_analyzer = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          checkOnSave = { command = "clippy" },
        },
      },
    }

    -- Go
    vim.lsp.config.gopls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- C/C++
    vim.lsp.config.clangd = {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
    }

    -- Bash
    vim.lsp.config.bashls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Docker
    vim.lsp.config.dockerls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Markdown
    vim.lsp.config.marksman = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Enable all servers
    local servers = {
      "pyright",
      "lua_ls",
      "ts_ls",
      "jsonls",
      "yamlls",
      "html",
      "cssls",
      "tailwindcss",
      "rust_analyzer",
      "gopls",
      "clangd",
      "bashls",
      "dockerls",
      "marksman",
    }

    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end
  end,
}
