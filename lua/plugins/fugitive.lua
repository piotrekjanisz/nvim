return {
  'tpope/vim-fugitive',
  dependencies = {
    'tpope/vim-rhubarb',
  },
  cmd = { 'Git', 'G', 'Gclog', 'GBrowse', 'Gvdiffsplit', 'Gread', 'Gwrite' },
  keys = {
    { '<leader>gs', '<cmd>Git<cr>', desc = 'Git Status' },
    { '<leader>gb', '<cmd>GBrowse<cr>', desc = 'Open in browser', mode = { 'n', 'v' } },
  },
}
