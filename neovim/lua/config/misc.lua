require("neodev").setup {
	-- add any options here, or leave empty to use the default settings
}

require('Comment').setup {
	---Add a space b/w comment and the line
	padding = true,
	---Whether the cursor should stay at its position
	sticky = true,
	---Lines to be ignored while (un)comment
	ignore = nil,
	---LHS of toggle mappings in NORMAL mode
	toggler = {
		---Line-comment toggle keymap
		line = ',',
		---Block-comment toggle keymap
		-- block = 'gcb',
		block = nil,
	},
	---LHS of operator-pending mappings in NORMAL and VISUAL mode
	opleader = {
		---Line-comment keymap
		line = ',',
		---Block-comment keymap
		block = 'gb',
	},
	---LHS of extra mappings
	extra = {
		---Add comment on the line above
		above = 'cO',
		---Add comment on the line below
		below = 'co',
		---Add comment at the end of line
		eol = 'c;',
	},
	---Enable keybindings
	---NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		basic = true,
		---Extra mapping; `gco`, `gcO`, `gcA`
		extra = true,
	},
	---Function to call before (un)comment
	pre_hook = nil,
	---Function to call after (un)comment
	post_hook = nil,
}

vim.cmd([[autocmd FileType * set formatoptions-=o]])

