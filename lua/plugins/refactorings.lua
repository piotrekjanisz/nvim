return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    -- Since the "new user facing interface" rewrite, refactoring.nvim requires
    -- lewis6991/async.nvim (`require "async"`) and no longer uses plenary or
    -- nvim-treesitter (it relies on Neovim 0.12 built-in tree-sitter + LSP).
    'lewis6991/async.nvim',
  },
  lazy = false,
  config = function()
    local refactoring = require 'refactoring'

    -- EXTRACT
    -- The refactors are operators (they return `g@`), so the same keymap works
    -- in normal mode (waits for a motion/textobject) and visual mode.
    vim.keymap.set({ 'n', 'x' }, '<leader>rv', function()
      return refactoring.extract_var()
    end, { desc = 'Extract Variable', expr = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>rf', function()
      return refactoring.extract_func()
    end, { desc = 'Extract Function', expr = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>rF', function()
      return refactoring.extract_func_to_file()
    end, { desc = 'Extract Function To File', expr = true })

    -- INLINE
    vim.keymap.set({ 'n', 'x' }, '<leader>ri', function()
      return refactoring.inline_var()
    end, { desc = 'Inline Variable', expr = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>rI', function()
      return refactoring.inline_func()
    end, { desc = 'Inline Function', expr = true })

    -- THE PICKER (The "I forgot the shortcut" menu)
    -- Uses vim.ui.select, so it opens in a Snacks.picker window.
    vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
      refactoring.select_refactor()
    end, { desc = 'Refactor Menu' })
  end,
}
