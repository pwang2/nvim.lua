return {
	{
		"sonph/onehalf",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.opt.runtimepath:append("/home/pwang2/.local/share/nvim/lazy/onehalf/vim")
			vim.cmd([[colorscheme onehalfdark]])
		end,
	},
}
