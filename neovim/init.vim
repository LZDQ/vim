set rnu
set nu

set nowrap
set noeb

set nobackup
set noswapfile
set noundofile

inoremap jk <ESC>

"inoremap <TAB> <C-P>
inoremap <S-TAB> <TAB>

inoremap <C-V> <ESC>"+pa

nnoremap z %
nnoremap dz d%
nnoremap dv V%d
nnoremap =z =%
nnoremap yz V%y$%
set foldenable
set foldmethod=manual

nnoremap Z za
vnoremap z %
vnoremap Z zf
nnoremap + zR
nnoremap - zM
nnoremap <DEL> zD
nnoremap <C-C> gg"+yG
vnoremap <C-C> "+y
nnoremap <space> $
nnoremap <BS> zz
nnoremap <PageUp> <C-U>
nnoremap <PageDown> <C-D>
nnoremap <HOME> <C-B>
nnoremap <END> <C-F>
nnoremap <UP> <C-Y>
nnoremap <DOWN> <C-E>
nnoremap <LEFT> zH
nnoremap <C-LEFT> 8zh
nnoremap <RIGHT> zL
nnoremap <C-RIGHT> 8zl
nnoremap <TAB> <C-W><C-W>
nnoremap <silent> <S-TAB> :bn<CR>
nnoremap <silent> Q :q<CR>
nnoremap <C-Q> q
nmap q <C-L>
vnoremap q <ESC>

set tabstop=4
set shiftwidth=4
set softtabstop=4
set mouse=a
set mousemodel=extend

filetype plugin indent on
set autoindent
set smartindent

set noexpandtab
set ic
set viewoptions=cursor,folds,slash,unix
nnoremap w <Plug>(smartword-w)
nnoremap b <Plug>(smartword-b)

set guicursor=n-v-c-i:block

" Compile
" Note: <S-Fx> is x+12, <C-Fx> is x+24, <S-C-Fx> is x+36, <A-Fx> is x_48
" Use insert mode to type them
au TermOpen * startinsert
au FileType * nnoremap <F12> :w<CR>:term bash run.sh<CR>
au FileType python nnoremap <F9> :w<CR>:term python %<CR>
au FileType python nnoremap <F33> :w<CR>:term python -i %<CR>
au FileType python nnoremap <F57> :w<CR>:term python -m pdb %<CR>
au FileType cpp nnoremap <F9> :w<CR>:term g++ % -o %< -std=c++17<CR>
au FileType cpp nnoremap <F57> :w<CR>:term g++ % -o %< -std=c++17 -O2<CR>
au FileType cpp nnoremap <F33> :w<CR>:term g++ % -o %< -std=c++17 -Wall -g -fsanitize=address,leak,undefined<CR>
au FileType cpp nnoremap <F10> :w<CR>:term ./%<<CR>
au FileType cpp nnoremap <F4> :term cf test %<CR>
au FileType cpp nnoremap <F5> :term cf submit -f %<CR>
au FileType cpp tnoremap <F4> <CR>:term cf test %<CR>
au FileType cpp tnoremap <F5> <CR>:term cf submit -f %<CR>
au FileType tex nnoremap <F9> :w<CR>:term xelatex %<CR>
au FileType sh nnoremap <F9> :w<CR>:term bash %<CR>


function WriteFor(str)
	let a=""
	let b=""
	let c=""
	if strlen(a:str)==3
		let a=a:str[0]
		let b=a:str[1]
		let c=a:str[2]
	else
		" a=b; a<=c; a++
		let w=1
		let s1=0
		let s2=0
		for i in range(0,strlen(a:str)-1)
			if a:str[i]==',' && s1==0 && s2==0
				let w=w+1
			else
				if w==1
					let a = a . a:str[i]
					" echo a:str[i] . ' ' . a
				elseif w==2
					let b = b . a:str[i]
				else
					let c = c . a:str[i]
				endif
				if a:str[i]=='('
					let s1=s1+1
				elseif a:str[i]==')'
					let s1=s1-1
				elseif a:str[i]=='['
					let s2=s2+1
				elseif a:str[i]==']'
					let s2=s2-1
				endif
			endif
		endfor
	endif
	if b=="-"
		let outputstr = "for(int " . a . "=" . "0; ". a . "<"
	else
		let outputstr = "for(int " . a . "=" . b . "; " . a  . "<"
	endif
	if b!="0"
		let outputstr = outputstr . "="
	endif
	let outputstr = outputstr . c . "; " . a . "++)"
	execute "normal! cc" . outputstr
endfunction

function WriteEdge(str)
	"iu
	let outputstr = "for(int " . a:str[0] . "=h[" . a:str[1] . "]; " . a:str[0] . "; " . a:str[0] . "=nx[" . a:str[0] . "])"
	execute "normal! cc" . outputstr
endfunction

function WriteScanf(str)
	"n,m
	let s1 = "scanf(\"%d"
	let s2 = " &"
	for i in range(0, strlen(a:str)-1)
		let s2 = s2 . a:str[i]
		if a:str[i]==','
			let s1 = s1 . "%d"
			let s2 = s2 . " &"
		endif
	endfor
	let ans = s1 . "\"," . s2 . ");"
	execute "normal! cc" . ans
endfunction

autocmd FileType cpp inoremap <C-F> <esc>:call WriteFor("")<left><left>
autocmd FileType cpp inoremap <C-U> <esc>:call WriteEdge("")<left><left>
autocmd FileType cpp inoremap <C-C> <esc>:call WriteScanf("")<left><left>
autocmd FileType cpp nnoremap <F8> :r ~/cf/template/

call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'nvim-lualine/lualine.nvim'
"Plug 'nvim-tree/nvim-web-devicons'
Plug 'navarasu/onedark.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'vim-scripts/restore_view.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
"Plug 'SmiteshP/nvim-navic'
Plug 'elihunter173/dirbuf.nvim'
Plug 'tpope/vim-surround'
"Plug 'machakann/vim-swap'
"Plug 'davidhalter/jedi-vim'
Plug 'kana/vim-smartword'
Plug 'Fildo7525/pretty_hover'
"Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }
Plug '3rd/image.nvim'
Plug 'benlubas/molten-nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'andymass/vim-matchup'
"Plug 'PeterRincker/vim-argumentative'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" -- Start of textobj --
Plug 'kana/vim-textobj-user'
Plug 'fvictorio/vim-textobj-backticks'  " `
Plug 'D4KU/vim-textobj-chainmember'  " m
"Plug 'glts/vim-textobj-comment'  " c
"Plug 'rhysd/vim-textobj-continuous-line'  " v
"Plug 'kana/vim-textobj-function'  " f
"Plug 'kana/vim-textobj-indent'  " i, I
Plug 'pianohacker/vim-textobj-indented-paragraph'  " r, g(  and g) for jump
"Plug 'vimtaku/vim-textobj-keyvalue'  " ak for key, iv for value
Plug 'kana/vim-textobj-lastpat'  " /
"Plug 'sgur/vim-textobj-parameter'  " ,
"Plug 'lucapette/vim-textobj-underscore'  " _
Plug 'jceb/vim-textobj-uri'  " iu for URL, go to open the URL
Plug 'Julian/vim-textobj-variable-segment'  " v
"Plug 'bps/vim-textobj-python'  " python specific. af if for function, [pf, ]pf for jump function
Plug 'tkhren/vim-textobj-numeral'  " numbers.
call plug#end()


let g:AutoPairsFlyMode = 0

" textobj for numbers.
" in  is for all numbers except hex
" ix  is for hex digits
" ax  is for hex digits with prefix (#, 0x)
let g:textobj_numeral_no_default_key_mappings = 1
let g:textobj_numeral_strict_mode = 1  " Only under cursor

vnoremap an	<Plug>(textobj-numeral-a)
onoremap an	<Plug>(textobj-numeral-a)
vnoremap in	<Plug>(textobj-numeral-i)
onoremap in	<Plug>(textobj-numeral-i)
vnoremap ix <Plug>(textobj-numeral-hex-i)
onoremap ix <Plug>(textobj-numeral-hex-i)
vnoremap ax <Plug>(textobj-numeral-hex-a)
onoremap ax <Plug>(textobj-numeral-hex-a)
nnoremap gnn <Plug>(textobj-numeral-n)
nnoremap gpn <Plug>(textobj-numeral-p)


"let g:jedi#show_call_signatures = 0
"let g:jedi#popup_on_dot = 0
"let g:jedi#popup_select_first = 0
"let g:jedi#show_call_signatures_delay = 0


set cursorline
set cursorlineopt=number
set termguicolors

lua << END

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'ayu_mirage',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
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
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

local onedark = require('onedark')

onedark.setup  {
    -- Main options --
    style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

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
		["@keyword.import"] = {fg = '$blue'},
		["@keyword.repeat"] = {fg = '$blue'},
		["@constructor"] = {fg = '$orange', fmt = 'none'},
		["@constant.builtin"] = {fg = '$blue'},
		["@boolean"] = {fg = '$blue'},
		["@type.builtin"] = {fg = '#3EB489'}, -- mint
		["@variable"] = {fg = '$fg'},
		["@variable.python"] = {fg = '$fg'},
		["@variable.parameter"] = {fg = '$cyan'},
		["@variable.member"] = {fg = '$fg'},
		["@variable.builtin"] = {fg = '#FF69Bf'},  -- pink
		["@punctuation.bracket"] = {fg = '$fg'},
		["@punctuation.delimiter"] = {fg = '$fg'},
		["@comment"] = {fg = '#41C9E2'},  -- something blue
		["@string"] = {fg = '#96E9C6'},  -- something green
		["@string.escape"] = {fg = '#7F00FF'},  -- something violet
		["@keyword"] = {fg = '$purple'},
	}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}

onedark.load()
vim.api.nvim_set_hl(0, 'Visual', {bg = 'Grey'})

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

require('dirbuf').setup {
    hash_padding = 2,
    show_hidden = true,
    sort_order = "default",
    write_cmd = "DirbufSync",
}

require('neo-tree').setup{
        source_selector = {
            winbar = true,
            statusline = true
        },
    }

require('nvim-treesitter.configs').setup {
    -- A directory to install the parsers into.
    -- If this is excluded or nil parsers are installed
    -- to either the package dir, or the "site" dir.
    -- If a custom path is used (not nil) it must be added to the runtimepath.
    -- parser_install_dir = "/some/path/to/store/parsers",

    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "python" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- list of language that will be disabled
      disable = {},

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
	  additional_vim_regex_highlighting = false,
    },

	textobjects = {
		-- Configs for select, swap, jump
		select = {
			enable = true,
			lookahead = false,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["i,"] = "@parameter.inner",
				["a,"] = "@parameter.outer",
				[","] = "@parameter.inner",
			},
			selection_modes = {
				['@parameter.inner'] = 'v', -- charwise
				['@function.outer'] = 'V', -- linewise
				['@function.inner'] = 'V', -- linewise
				['@class.outer'] = 'V', -- linewise
				['@class.inner'] = 'V', -- linewise
			},
			include_surrounding_whitespace = false,
		},

		swap = {
			enable = true,
			swap_next = {
				["g>"] = "@parameter.inner",
			},
			swap_previous = {
				["g<"] = "@parameter.inner",
			},
		},

		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				--
				-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
				--["]o"] = "@loop.*",
				-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
				--
				-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
				-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
				["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
				--["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
				[")"] = "@parameter.inner",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				["("] = "@parameter.inner",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
			},
			-- Below will go to either the start or the end, whichever is closer.
			-- Use if you want more granular movements
			-- Make it even more gradual by adding multiple queries and regex.
			goto_next = {
				--["]d"] = "@conditional.outer",
			},
			goto_previous = {
				--["[d"] = "@conditional.outer",
			},
		},
	},
}

--local navic = require('nvim-navic')

vim.diagnostic.disable()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Disable signs
    signs = false,
    -- Disable virtual text
    virtual_text = false,
    -- Keep the update in insert mode
    update_in_insert = false,
    -- Show diagnostics in the quickfix window
    severity_sort = true,
  }
)
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<F2>', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {
	autostart = true,
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    --vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wl', function()
      --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, opts)
    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<F18>', vim.lsp.buf.rename, opts)
    --vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    --vim.keymap.set('n', '<space>f', function()
      --vim.lsp.buf.format { async = true }
    --end, opts)
  end,
})

local pretty_hover = require('pretty_hover')
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover()
  vim.lsp.buf.hover()
end)

local cmp = require'cmp'

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

-- following is from https://github.com/hrsh7th/nvim-cmp/discussions/1834
local lspkind_comparator = function(conf)
	local lsp_types = require("cmp.types").lsp
	return function(entry1, entry2)
		if entry1.source.name ~= "nvim_lsp" then
			if entry2.source.name == "nvim_lsp" then
				return false
			else
				return nil
			end
		end
		local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
		local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]
		if kind1 == "Variable" and entry1:get_completion_item().label:match("%w*=") then
			kind1 = "Parameter"
		end
		if kind2 == "Variable" and entry2:get_completion_item().label:match("%w*=") then
			kind2 = "Parameter"
		end

		local priority1 = conf.kind_priority[kind1] or 0
		local priority2 = conf.kind_priority[kind2] or 0
		if priority1 == priority2 then
			return nil
		end
		return priority2 < priority1
	end
end

local label_comparator = function(entry1, entry2)
	return entry1.completion_item.label < entry2.completion_item.label
end


cmp.setup{
  snippet = {
	-- REQUIRED - you must specify a snippet engine
	expand = function(args)
	  vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
	end,
  },
  window = {
	  -- completion = cmp.config.window.bordered(),
	  -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-10),
	['<C-f>'] = cmp.mapping.scroll_docs(10),
	-- ['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
	['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	["<Tab>"] = cmp.mapping(function()
	  if cmp.visible() then
		  cmp.select_next_item()
		  --elseif vim.fn["vsnip#available"](1) == 1 then
		  --feedkey("<Plug>(vsnip-expand-or-jump)", "")
	  --elseif has_words_before() then
		  --cmp.complete()
	  else
		  cmp.complete() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
	  end
	end, { "i", "s" }),
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		else
			fallback()
		--elseif vim.fn["vsnip#jumpable"](-1) == 1 then
			--feedkey("<Plug>(vsnip-jump-prev)", "")
		end
	end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', max_item_count = 10 },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
	  { name = 'buffer', max_item_count = 10},
  }),
  sorting = {
	  -- From github
	  comparators = {
		  lspkind_comparator({
		      kind_priority = {
				  Parameter = 14,
				  Variable = 12,
				  Field = 11,
				  Property = 11,
				  Constant = 5,
				  Enum = 10,
				  EnumMember = 10,
				  Event = 10,
				  Function = 10,
				  Method = 10,
				  Operator = 5,
				  Reference = 5,
				  Struct = 10,
				  File = 8,
				  Folder = 8,
				  Class = 5,
				  Color = 5,
				  Module = 5,
				  Keyword = 1,
				  Constructor = 1,
				  Interface = 1,
				  Snippet = 14,
				  Text = 1,
				  TypeParameter = 1,
				  Unit = 1,
				  Value = 1,
			  },
		  }),
		  -- label_comparator,
	  }
  }
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
	{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
	{ name = 'path' }
	}, {
		{ name = 'cmdline' }
		}),
		matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
--local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
lspconfig.pyright.setup {
	capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- jupyter
vim.keymap.set("n", "mi", ":MoltenInit<CR>",
    { silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "me", ":MoltenEvaluateOperator<CR>",
    { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "ml", ":MoltenEvaluateLine<CR>",
    { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "mr", ":MoltenReevaluateCell<CR>",
    { silent = true, desc = "re-evaluate cell" })
vim.keymap.set("v", "m", ":<C-u>MoltenEvaluateVisual<CR>",
    { silent = true, desc = "evaluate visual selection" })
vim.keymap.set("n", "md", ":MoltenDelete<CR>",
    { silent = true, desc = "delete current cell" })
vim.keymap.set("n", "mh", ":MoltenHideOutput<CR>",
    { silent = true, desc = "hide output of current cell" })




END
