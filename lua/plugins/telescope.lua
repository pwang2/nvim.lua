return {
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      local trouble = require('trouble.sources.telescope')
      local troublemaker = trouble.open

      require 'telescope'.setup {
        defaults = {
          mappings = {
            i = { ['<leader>t'] = troublemaker },
            n = { ['<leader>t'] = troublemaker },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            file_ignore_patterns = { '.git', 'node_modules' },
          },
        },
      }
      vim.cmd([[
      nnoremap <C-p>      <cmd>Telescope find_files<CR>
      nnoremap <leader>f  <cmd>Telescope resume<CR>
      nnoremap <leader>ff <cmd>Telescope find_files<CR>
      nnoremap <leader>fg <cmd>Telescope live_grep<CR>
      nnoremap <leader>fb <cmd>Telescope buffers<CR>
      nnoremap <leader>fh <cmd>Telescope help_tags<CR>
      ]])
    end,
  }
}
