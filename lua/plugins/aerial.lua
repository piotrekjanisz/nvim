return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>at', '<cmd>AerialToggle!<cr>', desc = 'Aerial: Toggle outline' },
    { '{', '<cmd>AerialPrev<cr>', desc = 'Aerial: Previous symbol' },
    { '}', '<cmd>AerialNext<cr>', desc = 'Aerial: Next symbol' },
  },
  opts = {
    highlight_on_hover = true,
    attach_mode = 'window',
    icons = {},
  },
}

-- vim: ts=2 sts=2 sw=2 et
