return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'python',
      'rust',
      'go',
      -- React 19 / TypeScript
      'javascript',
      'typescript',
      'tsx',
      'css',
      'jsdoc',
      'json',
    },
    auto_install = true,
    highlight = {
      enable = true,
      disable = {},
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-i>',
        node_incremental = '<C-i>',
        scope_incremental = false,
        node_decremental = '<C-o>',
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
