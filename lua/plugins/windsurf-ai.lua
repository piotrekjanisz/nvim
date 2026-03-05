return {
  'monkoose/neocodeium',
  event = 'VeryLazy',
  config = function()
    local neocodeium = require 'neocodeium'
    local cmp = require 'cmp'

    cmp.event:on('menu_opened', function()
      neocodeium.clear()
    end)

    neocodeium.setup {
      filter = function()
        return not cmp.visible()
      end,
    }

    vim.keymap.set('i', '<A-f>', neocodeium.accept)
  end,
}
