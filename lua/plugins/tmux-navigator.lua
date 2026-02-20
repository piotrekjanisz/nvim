return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },
  keys = {
    { '<A-h>', '<cmd>TmuxNavigateLeft<cr>' },
    { '<A-j>', '<cmd>TmuxNavigateDown<cr>' },
    { '<A-k>', '<cmd>TmuxNavigateUp<cr>' },
    { '<A-l>', '<cmd>TmuxNavigateRight<cr>' },
    { '<A-\\>', '<cmd>TmuxNavigatePrevious<cr>' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
