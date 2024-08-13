return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind-nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp-signature-help",

			"SirVer/ultisnips",
			"honza/vim-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			local t = function(str)
				return vim.api.nvim_replace_termcodes(str, true, true, true)
			end

			local fk = vim.api.nvim_feedkeys
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true
			vim.g.copilot_tab_fallback = ""

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["UltiSnips#Anon"](args.body)
					end,
				},
				formatting = {
					-- format = lspkind.cmp_format({ mode = 'symbol_text' })
					format = function(entry, vim_item)
						vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol_text" })
						vim_item.menu = entry.source.name
						if entry.source.name == "cmp_tabnine" then
							local detail = (entry.completion_item.data or {}).detail
							vim_item.kind = ""
							if detail and detail:find(".*%%.*") then
								vim_item.kind = vim_item.kind .. " " .. detail
							end

							if (entry.completion_item.data or {}).multiline then
								vim_item.kind = vim_item.kind .. " " .. "[ML]"
							end
						elseif entry.source.name == "nvim_lsp" then
							vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol_text" })
						end
						local maxwidth = 80
						vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
						return vim_item
					end,
				},
				-- preselect = cmp.PreselectMode.Item,
				mapping = {
					["<Tab>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
							elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
								fk(t("<Plug>(ultisnips_jump_forward)"), "m", true)
							else
								fallback()
							end
						end,
						s = function(fallback)
							if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
								fk(t("<Plug>(ultisnips_jump_forward)"), "m", true)
							else
								fallback()
							end
						end,
					}),
					["<S-Tab>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() then
								cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
							elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
								fk(t("<Plug>(ultisnips_jump_backward)"), "m", true)
							else
								fallback()
							end
						end,
						s = function(fallback)
							if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
								fk(t("<Plug>(ultisnips_jump_backward)"), "m", true)
							else
								fallback()
							end
						end,
					}),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable,
					["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					["<C-k>"] = cmp.mapping.confirm({ select = true }),
					["<C-j>"] = cmp.mapping(function(fallback)
						cmp.mapping.abort()
						local copilot_keys = vim.fn["copilot#Accept"]()
						if copilot_keys ~= "" then
							vim.api.nvim_feedkeys(copilot_keys, "i", true)
						else
							fallback()
						end
					end),
				},
				sources = cmp.config.sources({
					-- { name = "ultisnips" },  -- not working
					{ name = "nvim_lsp", max_item_count = 10, priority = 100 },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer", max_item_count = 5, priority = 10 },
					{ name = "emoji" },
				}),
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				window = {
					documentation = {
						border = "rounded",
						winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
					},
					completion = {
						border = "rounded",
						winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
					},
				},
				experimental = {
					ghost_text = true,
				},
			})
		end,
	},
}
