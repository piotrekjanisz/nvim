-- biome does formatting, linting and import sorting in one pass, but only inside
-- a project that has a biome.json; conform's `biome-check` config keys its cwd
-- off that file. prettier is the fallback everywhere else. `stop_after_first`
-- means the first formatter actually available for the buffer wins, so a repo
-- with biome gets biome and a repo without it still gets formatted.
--
-- The *linting* half of "biome as formatter and linter" comes from the biome
-- language server, configured in lsp.lua -- conform only formats.
local web = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true }

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'prefer' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters = {
      -- Without this, biome-check runs even where no biome.json exists (cwd is
      -- only a hint unless required), so it would win in every web project and
      -- the prettier fallback would never be reached.
      ['biome-check'] = { require_cwd = true },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff' },
      javascript = web,
      javascriptreact = web,
      typescript = web,
      typescriptreact = web,
      json = web,
      jsonc = web,
      css = web,
      html = web,
      graphql = web,
      -- biome does not handle markdown or yaml
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
