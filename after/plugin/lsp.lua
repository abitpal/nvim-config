-- example using `opts` for defining servers
local opts = {
	servers = {
		lua_ls = {},
	},
}
local lspconfig = require("lspconfig")
for server, config in pairs(opts.servers) do
	-- passing config.capabilities to blink.cmp merges with the capabilities in your
	-- `opts[server].capabilities, if you've defined it
	config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
	config.capabilities.textDocument = config.capabilities.textDocument or {}
	config.capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	lspconfig[server].setup(config)
end

require("mason").setup()

require("mason-lspconfig").setup({
	automatic_enable = {
		exclude = { "rust_analyzer" },
	},
})

require("blink.cmp").setup({
	-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
	-- 'super-tab' for mappings similar to vscode (tab to accept)
	-- 'enter' for enter to accept
	-- 'none' for no mappings
	--
	-- All presets have the following mappings:
	-- C-space: Open menu or open docs if already open
	-- C-n/C-p or Up/Down: Select next/previous item
	-- C-e: Hide menu
	-- C-k: Toggle signature help (if signature.enabled = true)
	--
	-- See :h blink-cmp-config-keymap for defining your own keymap
	enabled = function()
		-- Disable blink-cmp in NvimTree
		if vim.g.blink_active then
			return true
		end
		return false
	end,
	keymap = {
		preset = "default",
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide" },
		["<CR>"] = { "select_and_accept", "fallback" },

		["<M-k>"] = { "select_prev", "fallback" },
		["<M-j>"] = { "select_next", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },

		-- ["<C-j>"] = { "scroll_documentation_up", "fallback" },
		-- ["<C-k>"] = { "scroll_documentation_down", "fallback" },

		-- ["<Tab>"] = { "snippet_forward", "fallback" },
		-- ["<S-Tab>"] = { "snippet_backward", "fallback" },

		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},

	appearance = {
		-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},

	completion = {
		trigger = {
			show_on_keyword = true, -- Show completion menu on keyword
			show_on_blocked_trigger_characters = function()
				if vim.bo.filetype == "python" then
					return { " ", "\n", "\t", ":" }
				else
					return { " ", "\n", "\t" }
				end
			end,
		},
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							local icon = ctx.kind_icon
							if vim.tbl_contains({ "Path" }, ctx.source_name) then
								local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
								if dev_icon then
									icon = dev_icon
								end
							else
								icon = require("lspkind").symbolic(ctx.kind, {
									mode = "symbol",
								})
							end

							return icon .. ctx.icon_gap
						end,

						-- Optionally, use the highlight groups from nvim-web-devicons
						-- You can also add the same function for `kind.highlight` if you want to
						-- keep the highlight groups in sync with the icons.
						highlight = function(ctx)
							local hl = ctx.kind_hl
							if vim.tbl_contains({ "Path" }, ctx.source_name) then
								local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
								if dev_icon then
									hl = dev_hl
								end
							end
							return hl
						end,
					},
				},
			},
		},
		documentation = { auto_show = false },
	},
	signature = { enabled = true, window = { border = "single" } },

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	snippets = { preset = "luasnip" },
	sources = {
		default = function(ctx)
			local success, node = pcall(vim.treesitter.get_node)
			if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
				return { "buffer" }
			else
				return { "lsp", "path", "snippets", "buffer", "codecompanion" }
			end
		end,
	},

	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`jre
	--
	-- See the fuzzy documentation for more information require  req require require
	fuzzy = {
		implementation = "prefer_rust_with_warning",
		sorts = {
			"exact",
			-- defaults
			"score",
			"sort_text",
		},
	},
})

local function blink_active()
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(buf)

	-- Check if in floating window (Lspsaga rename, etc.)
	local win_config = vim.api.nvim_win_get_config(win)
	if win_config.relative ~= "" then
		print("Floating window detected:", bufname)
		vim.g.blink_active = false
		return
	end

	local syn_id = vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1)
	local syn_name = vim.fn.synIDattr(syn_id, "name")
	if syn_name:lower():find("comment") then
		vim.g.blink_active = false
		return
	end
	-- Check if the current buffer is NvimTree
	local bufnr = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	if bufname:match("NvimTree_") then
		vim.g.blink_active = false
		return
	end
	vim.g.blink_active = true
end

vim.api.nvim_create_autocmd({ "CursorMoved" }, {
	callback = function()
		blink_active()
	end,
})

vim.o.updatetime = 300 -- how fast the hover shows (ms)

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = "rounded",
			source = "always",
			prefix = "",
			scope = "cursor",
		})
	end,
})

local function make_italic(group)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
	if ok then
		hl.italic = true
		vim.api.nvim_set_hl(0, group, hl)
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		make_italic("@keyword")
		make_italic("@keyword.repeat")
		make_italic("@keyword.function")
		make_italic("@keyword.conditional")
		make_italic("@keyword.import")
		make_italic("@keyword.exception")
		make_italic("@function.builtin")
	end,
})
