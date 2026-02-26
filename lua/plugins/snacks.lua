return {
  'folke/snacks.nvim',
  opts = {
    picker = {
      enabled = true,
      -- Equivalent to telescope-ui-select
      ui_select = true,
    },
    gitbrowse = {},
  },
  keys = {
    -- Basic Pickers
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Search Help',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Search Keymaps',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = 'Search Files',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual Selection or Word',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },

    -- Fuzzily search in current buffer (Your <leader>/)
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },

    -- Grep in Open Files (Your <leader>s/)
    {
      '<leader>s/',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Files',
    },

    -- Search Neovim Config (Your <leader>sn)
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Search Config',
    },

    -- Git File History (Your extension replacement)
    {
      '<leader>gs',
      function()
        Snacks.picker.git_log { follow = true, current_file = true }
      end,
      desc = 'Git File History',
    },
    {
      '<leader>gb',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Open in repository browser',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    vim.keymap.set('n', '<leader>sp', function()
      Snacks.picker.smart()
    end, { desc = 'Smart Search (Files/Buffers/Recent)' }),
  },
}
