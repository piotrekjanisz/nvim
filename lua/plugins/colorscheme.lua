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
return {
  {
    'EdenEast/nightfox.nvim',
    priority = 1000, -- Load early
    config = function()
      require('nightfox').setup {
        options = {
          -- Compiled themes are faster to load
          compile_path = vim.fn.stdpath 'cache' .. '/nightfox',
          compile_file_suffix = '_compiled',

          transparent = false, -- Set to true if you like transparency
          terminal_colors = true, -- Use nightfox colors in :terminal
          dim_inactive = false, -- Dims non-active windows

          styles = { -- Style customization
            comments = 'italic',
            keywords = 'bold',
            types = 'italic,bold',
          },
        },
      }

      -- You can change "nightfox" to "duskfox", "nordfox", etc.
      vim.cmd 'colorscheme nightfox'
    end,
  },
}
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
-- return {
--   'nickkadutskyi/jb.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('jb').setup {
--       -- Optional: enable transparency if your terminal has a blur effect
--       -- transparent = true,
--     }
--     vim.cmd.colorscheme 'jb'
--   end,
-- }

-- vim: ts=2 sts=2 sw=2 et
