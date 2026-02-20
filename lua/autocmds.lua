-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ZelliJ open scrollback fix
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '/tmp/*.dump',
  callback = function()
    local pane_id = os.getenv 'ZELLIJ_PANE_ID'
    if pane_id then
      local cwd_file = '/tmp/zj-cwd-' .. pane_id
      local f = io.open(cwd_file, 'r')
      if f then
        local actual_cwd = f:read '*l'
        f:close()
        if actual_cwd and vim.fn.isdirectory(actual_cwd) == 1 then
          vim.cmd('cd ' .. actual_cwd)
        end
      end
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et
