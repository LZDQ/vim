set rnu
set nu

set nowrap
set noeb

set nobackup
set noswapfile
set noundofile

inoremap jk <ESC>

inoremap <TAB> <C-P>
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
au FileType cpp nnoremap <F5> :term cf test %<CR>
au FileType cpp nnoremap <F6> :term cf submit -f %<CR>
au FileType tex nnoremap <F9> :w<CR>:term xelatex %<CR>
au FileType sh nnoremap <F9> :w<CR>:term bash %<CR>


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
"Plug 'SmiteshP/nvim-navic'
Plug 'elihunter173/dirbuf.nvim'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-swap'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
"Plug 'davidhalter/jedi-vim'
Plug 'kana/vim-smartword'
Plug 'Fildo7525/pretty_hover'
"Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }
Plug '3rd/image.nvim'
Plug 'benlubas/molten-nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'andymass/vim-matchup'

" -- Start of textobj --
Plug 'kana/vim-textobj-user'
Plug 'fvictorio/vim-textobj-backticks'  " `
"Plug 'D4KU/vim-textobj-chainmember'  " m
"Plug 'glts/vim-textobj-comment'  " c
"Plug 'rhysd/vim-textobj-continuous-line'  " v
"Plug 'kana/vim-textobj-function'  " f
"Plug 'kana/vim-textobj-indent'  " i, I
Plug 'pianohacker/vim-textobj-indented-paragraph'  " r, g(  and g) for jump
"Plug 'vimtaku/vim-textobj-keyvalue'  " ak for key, iv for value
Plug 'kana/vim-textobj-lastpat'  " /
Plug 'sgur/vim-textobj-parameter'  " ,
"Plug 'lucapette/vim-textobj-underscore'  " _
Plug 'jceb/vim-textobj-uri'  " iu for URL, go to open the URL
Plug 'Julian/vim-textobj-variable-segment'  " v
Plug 'bps/vim-textobj-python'  " python specific. af if for function, [pf, ]pf for jump function
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
