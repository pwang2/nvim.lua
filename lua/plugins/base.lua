return {
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require('nvim-tmux-navigation')
      nvim_tmux_nav.setup {
        disable_when_zoomed = true -- defaults to false
      }
      vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end
  },
  {
    'folke/trouble.nvim',
    config = function()
      require 'trouble'.setup{}
    end
  },
  { 'numToStr/Comment.nvim', },
  { 'edkolev/tmuxline.vim' },
  { 'ggandor/lightspeed.nvim', },
  { 'stevearc/dressing.nvim' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config=function()
      require('lualine').setup()
    end
  },
  {
    'akinsho/bufferline.nvim',
    config=function()
      require("bufferline").setup{}
    end
  },
}

