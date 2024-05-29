-- lualine, onedark/tokyo, cmdline

local function vim_link_hl(links)
	for group_f, group_t in pairs(links) do
		vim.api.nvim_set_hl(0, group_f, { link = group_t })
	end
end

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

local onedark = require('onedark')

onedark.setup {
	-- Main options --
	style = 'darker',             -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = false,          -- Show/hide background
	term_colors = true,           -- Change terminal color as per the selected theme style
	ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

	-- toggle theme style ---
	toggle_style_key = '<leader>d',                                                    -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
	toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

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
		-- https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/highlights.lua#L133-L257
		["@keyword.import"] = { fg = '$blue' },
		["@keyword.repeat"] = { fg = '$blue' },
		["@constructor"] = { fg = '$orange', fmt = 'none' },
		["@constant.builtin"] = { fg = '$blue' },
		["@boolean"] = { fg = '$blue' },
		["@type.builtin"] = { fg = '#3EB489' }, -- mint
		["@variable"] = { fg = '$fg' },
		["@variable.python"] = { fg = '$fg' },
		["@variable.parameter"] = { fg = '$cyan' },
		["@variable.member"] = { fg = '$fg' },
		["@variable.builtin"] = { fg = '#FF69Bf' }, -- pink
		["@punctuation.bracket"] = { fg = '$fg' },
		["@punctuation.delimiter"] = { fg = '$fg' },
		["@comment"] = { fg = '#41C9E2' }, -- something blue
		["@string"] = { fg = '#96E9C6' }, -- something green
		["@string.escape"] = { fg = '#7F00FF' }, -- something violet
		["@keyword"] = { fg = '$purple' },
	},                                   -- Override highlight groups

	-- Plugins Config --
	diagnostics = {
		darker = true,     -- darker colors for diagnostic
		undercurl = true,  -- use undercurl instead of underline for diagnostics
		background = true, -- use background color for virtual text
	},
}

onedark.load()
vim.api.nvim_set_hl(0, 'Visual', { bg = 'Grey' })

-- Modification for lsp
local lsp_links = {
	["@lsp.type.comment"] = "@comment",
	["@lsp.type.enum"] = "@type",
	["@lsp.type.enumMember"] = "@constant.builtin",
	["@lsp.type.interface"] = "@type",
	["@lsp.type.typeParameter"] = "@type",
	["@lsp.type.keyword"] = "@keyword",
	["@lsp.type.namespace"] = "@module",
	["@lsp.type.parameter"] = "@variable.parameter",
	["@lsp.type.property"] = "@property",
	["@lsp.type.variable"] = "@variable",
	["@lsp.type.macro"] = "@function.macro",
	["@lsp.type.method"] = "@function.method",
	["@lsp.type.number"] = "@number",
	["@lsp.type.generic"] = "@text",
	["@lsp.type.builtinType"] = "@type.builtin",
	["@lsp.typemod.method.defaultLibrary"] = "@function",
	["@lsp.typemod.function.defaultLibrary"] = "@function",
	["@lsp.typemod.operator.injected"] = "@operator",
	["@lsp.typemod.string.injected"] = "@string",
	["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",
	["@lsp.typemod.variable.injected"] = "@variable",
	["@lsp.typemod.variable.static"] = "@constant",
}
vim_link_hl(lsp_links)

-- local tokyo = require('tokyonight')

require("ibl").setup {
	-- Not configured yet
}
