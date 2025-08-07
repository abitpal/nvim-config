require("codecompanion").setup({
	display = {
		chat = {
			window = {
				position = "right",
			},
			auto_scroll = true,
		},
	},
	strategies = {
		chat = {
			opts = {
				completion_provider = "cmp", -- blink|cmp|coc|default
			},
			tools = {
				["cmd_runner"] = {
					requires_approval = true,
				},
			},
		},
		inline = {
			keymaps = {
				accept_change = {
					modes = { n = "ga" },
					description = "Accept the suggested change",
				},
				reject_change = {
					modes = { n = "gr" },
					opts = { nowait = true },
					description = "Reject the suggested change",
				},
			},
		},
	},
})
