return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  lazy = false,
  opts = {},
  config = function()
    local refactoring = require 'refactoring'
    refactoring.setup {}

    -- EXTRACT (Requires Visual Selection)
    -- Visual Mode: <leader>rv (Extract Variable)
    vim.keymap.set('x', '<leader>rv', function()
      return require('refactoring').refactor 'Extract Variable'
    end, { desc = 'Extract Variable', expr = true })

    -- Visual Mode: <leader>rf (Extract Function/Method)
    vim.keymap.set('x', '<leader>rf', function()
      return require('refactoring').refactor 'Extract Function'
    end, { desc = 'Extract Function', expr = true })

    -- INLINE (Works in Normal Mode)
    -- Normal Mode: <leader>ri (Inline Variable/Function)
    vim.keymap.set('n', '<leader>ri', function()
      return require('refactoring').refactor 'Inline Variable'
    end, { desc = 'Inline Variable', expr = true })

    -- Inline Function usually targets the name under cursor
    vim.keymap.set('n', '<leader>rI', function()
      return require('refactoring').refactor 'Inline Function'
    end, { desc = 'Inline Function', expr = true })

    -- THE PICKER (The "I forgot the shortcut" menu)
    -- This will open in a Snacks.picker window if you have ui_select enabled
    vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
      return require('refactoring').select_refactor()
    end, { desc = 'Refactor Menu', expr = true })
  end,
}
