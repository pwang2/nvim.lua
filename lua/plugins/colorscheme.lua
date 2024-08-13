return {
  -- {
  --   "sonph/onehalf",
  --   -- "tiagovla/tokyodark.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   rtp="vim/",
  --   config = function()
  --     vim.cmd([[colorscheme onehalfdark]])
  --   end,
  -- }
   {
    "tomasiser/vim-code-dark",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.opt.background = "dark"
      vim.cmd([[colorscheme codedark]])
    end,
  },
}
