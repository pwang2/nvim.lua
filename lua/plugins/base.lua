return {
	{ "numToStr/Comment.nvim" },
	{ "edkolev/tmuxline.vim" },
	{ "ggandor/lightspeed.nvim" },
	{ "simeji/winresizer" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "windwp/nvim-ts-autotag", lazy = "true", event = { "BufReadPre", "BufNewFile" }, opts = {} },
	{ "akinsho/bufferline.nvim", event = "BufReadPost", opts = {} },
	{ "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "sindrets/diffview.nvim", cmd = { "DiffviewOpen" }, keys = {
		{ "<leader>df", "<cmd>DiffviewOpen<cr>" },
	} },
	{
		"valloric/MatchTagAlways",
		ft = { "html", "xml", "vue" },
		init = function()
			vim.g.mta_filetypes = { html = 1, xml = 1, vue = 1 }
		end,
	},
	{
		"alexghergh/nvim-tmux-navigation",
		opts = {},
		keys = {
			{ "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>" },
			{ "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>" },
			{ "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>" },
			{ "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>" },
		},
	},
	{
		"folke/trouble.nvim",
		opts = { use_diagnostic_signs = true },
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("QuickFixCmdPost", {
				callback = function()
					vim.cmd([[Trouble qflist open]])
				end,
			})
		end,
	},
}
