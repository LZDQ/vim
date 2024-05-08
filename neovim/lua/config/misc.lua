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

require('nvim-autopairs').setup {
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    disable_in_macro = true,  -- disable when recording or executing a macro
    disable_in_visualblock = false, -- disable when insert after visual block mode
    disable_in_replace_mode = true,
    ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
    enable_moveright = true,
    enable_afterquote = true,  -- add bracket pairs after quote
    enable_check_bracket_line = true,  --- check bracket in same line
    enable_bracket_in_quote = true, --
    enable_abbr = false, -- trigger abbreviation
    break_undo = true, -- switch for basic rule break undo sequence
    check_ts = false,
    map_cr = true,
    map_bs = true,  -- map the <BS> key
    map_c_h = false,  -- Map the <C-h> key to delete a pair
    map_c_w = false, -- map <c-w> to delete a pair if possible
}

require("focus").setup()
