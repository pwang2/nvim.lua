return {
	{ "numToStr/Comment.nvim" },
	{ "edkolev/tmuxline.vim" },
	{ "ggandor/lightspeed.nvim" },
	{ "stevearc/dressing.nvim" },
	{ "simeji/winresizer" },
	{ "sindrets/diffview.nvim" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "windwp/nvim-ts-autotag", opts = {} },
	{ "nvim-lualine/lualine.nvim", opts = {} },
	{ "folke/trouble.nvim", opts = { use_diagnostic_signs = true } },
	{ "akinsho/bufferline.nvim", opts = {} },
	{ "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
	{ "github/copilot.vim", enabled = false },
	{
		"valloric/MatchTagAlways",
		init = function()
			vim.g.mta_filetypes = { html = 1, xhtml = 1, xml = 1, vue = 1 }
		end,
	},
	{
		"alexghergh/nvim-tmux-navigation",
		opts = {
			disable_when_zoomed = true, -- defaults to false
		},
		keys = {
			{ "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>" },
			{ "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>" },
			{ "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>" },
			{ "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>" },
			{ "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<cr>" },
			{ "<C-Space>", "<cmd>NvimTmuxNavigateNext<cr>" },
		},
	},
}
