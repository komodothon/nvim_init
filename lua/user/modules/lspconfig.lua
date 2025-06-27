return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- Native LSP capabilities (no cmp-nvim-lsp)
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

    -- Signs
    local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "󰋽" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Diagnostics config
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

    -- Servers configuration
    local servers = {
      pyright = {
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
      },
      lua_ls = {
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
      },
      tsserver = {},
      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      yamlls = {},
      html = {},
      cssls = {},
      tailwindcss = {},
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
          },
        },
      },
      gopls = {},
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
      },
      bashls = {},
      dockerls = {},
      marksman = {},
    }

    -- Setup all servers
    for name, opts in pairs(servers) do
      opts.on_attach = on_attach
      opts.capabilities = capabilities
      lspconfig[name].setup(opts)
    end
  end,
}
