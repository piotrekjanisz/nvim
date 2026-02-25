return {
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',

    dependencies = { 'rafamadriz/friendly-snippets' },

    config = function()
      local ls = require 'luasnip'
      ls.filetype_extend('javascript', { 'jsdoc' })
      require('luasnip.loaders.from_vscode').lazy_load()

      ls.config.set_config {
        history = true, -- Keep the last snippet around to jump back into it
        updateevents = 'TextChanged,TextChangedI', -- Update dynamic snippets as you type
        enable_autosnippets = true,
      }
      --- TODO: What is expand?
      vim.keymap.set({ 'i' }, '<A-e>', function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ 'i', 's' }, '<A-w>', function()
        ls.jump(-1)
      end, { silent = true })

      vim.keymap.set({ 'i', 's' }, '<C-E>', function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  },
}
