return {
  'folke/snacks.nvim',
  opts = {
    picker = {
      enabled = true,
      -- Equivalent to telescope-ui-select
      ui_select = true,
    },
    notifier = {},
    lazygit = {},
    terminal = {},
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

    -- Git
    {
      '<leader>gf',
      function()
        Snacks.picker.git_log { follow = true, current_file = true }
      end,
      desc = 'Git File History',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit()
      end,
      desc = 'Open lazygit',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Search (Files/Buffers/Recent)',
    },
    {
      '<C-_>',
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },
    {
      '<leader>fT',
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'Terminal (Root Dir)',
    },
    {
      '<leader>gw',
      function()
        local word = vim.fn.expand '<cword>'
        Snacks.picker.grep { search = '\\<' .. word .. '\\>' }
      end,
      desc = 'Grep word',
    },
    {
      '<leader>gc',
      function()
        local word = vim.fn.expand '<cword>'
        Snacks.picker.grep { search = 'class ' .. word .. '\\>' }
      end,
      desc = 'Grep class definition',
    },
    {
      '<leader>gi',
      function()
        local word = vim.fn.expand '<cword>'
        Snacks.picker.grep { search = '\\<' .. word .. '\\(' }
      end,
      desc = 'Grep instantiation',
    },
    {
      '<leader>gd',
      function()
        local word = vim.fn.expand '<cword>'
        Snacks.picker.grep { search = 'def ' .. word .. '\\>' }
      end,
      desc = 'Grep definition',
    },
  },
}
