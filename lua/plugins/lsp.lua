return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- basedpyright >= 1.39.6 gained auto-import of *project* symbols, but it builds the
    -- workspace-wide index lazily, on the first completion / 'add import' request. On a
    -- big monorepo that is a one-off ~9s stall exactly when you ask for an import.
    -- Pay it up front in the background, on a throwaway in-memory document, so it lands
    -- while you are still reading code. Retries because the index is only buildable once
    -- the server has finished its initial workspace enumeration.
    local warmed_clients = {}

    local function warm_auto_import_index(client)
      if warmed_clients[client.id] then
        return
      end
      warmed_clients[client.id] = true
      local uri = vim.uri_from_fname(client.root_dir .. '/__lsp_autoimport_warmup__.py')
      local attempts = 0
      local function __warm()
        if client:is_stopped() or attempts >= 8 then
          return
        end
        attempts = attempts + 1
        local started = vim.uv.hrtime()
        client:notify('textDocument/didOpen', {
          textDocument = { uri = uri, languageId = 'python', version = attempts, text = 'Zz\n' },
        })
        client:request('textDocument/completion', {
          textDocument = { uri = uri },
          position = { line = 0, character = 2 },
        }, function()
          client:notify('textDocument/didClose', { textDocument = { uri = uri } })
          -- A fast reply means the index was not built yet (server still enumerating);
          -- a slow one means we just paid for the build. Only retry in the former case.
          if (vim.uv.hrtime() - started) / 1e9 < 1.5 then
            vim.defer_fn(__warm, 4000)
          end
        end)
      end
      vim.defer_fn(__warm, 1000)
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        -- Snacks.picker LSP equivalents
        map('gd', function()
          Snacks.picker.lsp_definitions()
        end, '[G]oto [D]efinition')
        map('gr', function()
          Snacks.picker.lsp_references()
        end, '[G]oto [R]eferences')
        map('gI', function()
          Snacks.picker.lsp_implementations()
        end, '[G]oto [I]mplementation')
        map('<leader>D', function()
          Snacks.picker.lsp_type_definitions()
        end, 'Type [D]efinition')
        map('<leader>ds', function()
          Snacks.picker.lsp_symbols()
        end, '[D]ocument [S]ymbols')
        map('<leader>ws', function()
          Snacks.picker.lsp_workspace_symbols()
        end, '[W]orkspace [S]ymbols')
        -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.name == 'basedpyright' then
          warm_auto_import_index(client)
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Diagnostic Config
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
      },
    }

    local ruff_on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.semanticTokensProvider = nil
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.py',
        callback = function()
          -- 1. Organize imports using Ruff
          -- vim.lsp.buf.code_action {
          --   context = { only = { 'source.organizeImports' } },
          --   apply = true,
          -- }
          -- vim.wait(100)

          -- 2. Format using Ruff
          vim.lsp.buf.format { async = false }
        end,
      })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      basedpyright = {
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = nil
        end,
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'standard',
              fileEnumerationTimeout = 60,
              diagnosticMode = 'openFilesOnly',
            },
            disableOrganizeImports = true,
          },
        },
      },

      ruff = {
        on_attach = ruff_on_attach,
        init_options = {
          settings = {
            lint = {
              enable = false,
            },
          },
        },
      },
      gopls = {},

      vtsls = {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = 'literals' },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
          javascript = {
            inlayHints = {
              parameterNames = { enabled = 'literals' },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      },

      eslint = {},

      biome = {},

      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
      'prettierd',
      'prettier',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for name, opts in pairs(servers) do
      opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, opts.capabilities or {})
      vim.lsp.config(name, opts)
    end

    require('mason-lspconfig').setup {}
  end,
}

-- vim: ts=2 sts=2 sw=2 et
