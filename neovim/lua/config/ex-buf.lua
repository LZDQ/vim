-- extra buffers
-- bufferline (at the top of screen)
-- neo-tree (not configured)
-- dirbuf
-- navic (not configured)

local bufferline = require('bufferline')
bufferline.setup{
	options = {
		-- Disable icons
		show_buffer_icons = false, -- to hide the buffer icons
		show_buffer_close_icons = false, -- to hide the close icons
		show_close_icon = false, -- to hide the close icon on the right side of the bufferline
		show_tab_indicators = true, -- to hide tab indicators (if you want)
		-- other options...
		style_preset = bufferline.style_preset.no_italic,
	}
}

require('neo-tree').setup{
	source_selector = {
		winbar = true,
		statusline = true
	},
}

require('dirbuf').setup {
	hash_padding = 2,
	show_hidden = true,
	sort_order = "default",
	write_cmd = "DirbufSync",
}

-- local navic = require('nvim-navic')
