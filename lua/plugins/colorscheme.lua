-- return {
--   'folke/tokyonight.nvim',
--   priority = 1000,
--   config = function()
--     ---@diagnostic disable-next-line: missing-fields
--     require('tokyonight').setup {
--       styles = {
--         comments = { italic = false },
--       },
--     }
--     vim.cmd.colorscheme 'tokyonight-night'
--   end,
-- }
-- return {
--   'pmouraguedes/neodarcula.nvim',
--   lazy = false,
--   priority = 1000,
-- }
-- return {
--   {
--     'sainnhe/gruvbox-material',
--     lazy = false,
--     priority = 1000,
--     config = function()
--       -- Option 1: Set the contrast to 'hard'
--       vim.g.gruvbox_material_background = 'hard'
--
--       -- Option 2: Better aesthetics for the status line and cursor
--       vim.g.gruvbox_material_better_performance = 1
--       vim.g.gruvbox_material_foreground = 'material' -- or 'mix'
--
--       -- Apply the colorscheme
--       vim.cmd.colorscheme 'gruvbox-material'
--     end,
--   },
-- }
-- return {
--   'navarasu/onedark.nvim',
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     require('onedark').setup {
--       style = 'darker',
--     }
--     require('onedark').load()
--
--     -- Let treesitter win for groups it handles well,
--     -- but keep semantic-only groups (parameter, decorator, etc.)
--     local dominated_by_treesitter = {
--       'variable',
--       'function',
--       'method',
--       'keyword',
--       'type',
--       'property',
--       'namespace',
--       'string',
--       'number',
--       'operator',
--       'comment',
--     }
--     for _, group in ipairs(dominated_by_treesitter) do
--       vim.api.nvim_set_hl(0, '@lsp.type.' .. group, {})
--       vim.api.nvim_set_hl(0, '@lsp.type.' .. group .. '.python', {})
--     end
--   end,
-- }
-- return {
--   {
--     'rebelot/kanagawa.nvim',
--     config = function()
--       vim.cmd 'colorscheme kanagawa-wave'
--     end,
--   },
-- }
-- return {
--   {
--     'EdenEast/nightfox.nvim',
--     priority = 1000, -- Load early
--     config = function()
--       require('nightfox').setup {
--         options = {
--           -- Compiled themes are faster to load
--           compile_path = vim.fn.stdpath 'cache' .. '/nightfox',
--           compile_file_suffix = '_compiled',
--
--           transparent = false, -- Set to true if you like transparency
--           terminal_colors = true, -- Use nightfox colors in :terminal
--           dim_inactive = false, -- Dims non-active windows
--
--           styles = { -- Style customization
--             comments = 'italic',
--             keywords = 'bold',
--             types = 'italic,bold',
--           },
--         },
--       }
--
--       -- You can change "nightfox" to "duskfox", "nordfox", etc.
--       vim.cmd 'colorscheme nightfox'
--     end,
--   },
-- }
-- return {
--   {
--     'olimorris/onedarkpro.nvim',
--     priority = 1000, -- Ensure it loads first
--     config = function()
--       require('onedarkpro').setup {
--         theme = 'onedark_vivid', -- This is the key setting
--         options = {
--           transparency = false, -- Set to true for that clean look
--           terminal_colors = true,
--           highlight_inactive_windows = false,
--         },
--       }
--       vim.cmd 'colorscheme onedark'
--     end,
--   },
-- }
-- return {
--   {
--     'catppuccin/nvim',
--     name = 'catppuccin',
--     priority = 1000,
--     config = function()
--       require('catppuccin').setup {
--         flavour = 'macchiato', -- latte, frappe, macchiato, mocha
--         background = {
--           light = 'latte',
--           dark = 'macchiato',
--         },
--         transparent_background = false, -- Set to true if you want terminal transparency
--         show_end_of_buffer = false, -- Hide the ~ at the end of the buffer
--         term_colors = true, -- Sets terminal colors (e.g. for :terminal)
--         integrations = {
--           cmp = true,
--           gitsigns = true,
--           nvimtree = true,
--           treesitter = true,
--           notify = true,
--           mini = {
--             enabled = true,
--             indentscope_color = '',
--           },
--           -- For more plugins, check their GitHub documentation
--         },
--       }
--
--       -- Set the colorscheme
--       vim.cmd.colorscheme 'catppuccin'
--     end,
--   },
-- }
return {
  'nickkadutskyi/jb.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('jb').setup {
      -- Optional: enable transparency if your terminal has a blur effect
      -- transparent = true,

      -- Disable jb.nvim's snacks picker styling — its ToolWindow colors
      -- make the picker look gray. Let snacks.nvim use its own defaults
      -- (linked to standard hl groups like Special, Directory, etc.).
      snacks = { explorer = { enabled = false } },
    }
    vim.cmd.colorscheme 'jb'

    -- Disable all semantic tokens for Python — basedpyright's tokens
    -- override jb.nvim's treesitter highlights and make things worse.
    -- jb.nvim already defines good Python-specific treesitter groups.
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'basedpyright' then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
