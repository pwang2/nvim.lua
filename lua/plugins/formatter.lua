return {
	"mhartington/formatter.nvim",
	lazy = false,
	config = function()
		require("formatter").setup({
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				typescript = {
					require("formatter.defaults.prettier"),
				},
				javascript = {
					require("formatter.defaults.prettier"),
				},
				css = {
					require("formatter.defaults.prettier"),
				},
				vue = {
					require("formatter.defaults.prettier"),
				},
				html = {
					require("formatter.defaults.prettier"),
				},
			},
		})

		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", { group = "__formatter__", command = ":FormatWrite" })
	end,

	keys = {
		{ "<leader>f", "<cmd>FormatWrite<CR>", { silent = true } },
		{ "<localleader>f", "<cmd>FormatWrite<CR>", { silent = true } },
	},
}
