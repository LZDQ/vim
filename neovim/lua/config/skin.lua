-- lualine, onedark/tokyo, cmdline

require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'ayu_mirage',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

local umbra = require('umbra')

umbra.setup {
	-- Main options --
	style = 'moonlight',             -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = false,          -- Show/hide background
	term_colors = true,           -- Change terminal color as per the selected theme style
	ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

	-- toggle theme style ---
	toggle_style_key = '!',                                                    -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
	toggle_style_list = {
		'bloodmoon',
		'moonlight',
		'darkest',
		-- 'deep',
		-- 'warm',
		'warmer',
		-- 'dark',
		-- 'darker',
		'cool',
		'light',
	}, -- List of styles to toggle between

	-- Change code style ---
	-- Options are italic, bold, underline, none
	-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
	code_style = {
		comments = 'italic',
		keywords = 'none',
		functions = 'none',
		strings = 'none',
		variables = 'none'
	},

	-- Lualine options --
	lualine = {
		transparent = false, -- lualine center bar transparency
	},

	-- Custom Highlights --
	colors = {}, -- Override default colors
	highlights = {
		-- For all options, see
	},                                   -- Override highlight groups

	-- Plugins Config --
	diagnostics = {
		darker = true,     -- darker colors for diagnostic
		undercurl = true,  -- use undercurl instead of underline for diagnostics
		background = true, -- use background color for virtual text
	},
}

umbra.load()

-- local tokyo = require('tokyonight')

require("ibl").setup {
	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
		exclude = {
			language = { "python" }
		}
	},
	-- whitespace = { highlight = { "Normal", "Whitespace",  } },
	-- indent = { highlight = { "Normal" } },
}

-- Minimal config
require("themery").setup {
	themes = {
		"tokyonight-storm",
		"tokyonight-moon",
		-- "onedark",
	},      -- Your list of installed colorschemes
	-- themeConfigFile = "~/.config/nvim/lua/settings/theme.lua", -- Described below
	livePreview = true, -- Apply theme while browsing. Default to true.
}
