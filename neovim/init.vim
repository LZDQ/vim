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

nnoremap <leader>z z
nnoremap z %
onoremap z %
vnoremap z %
" nnoremap dz d%
" nnoremap =z =%
" nnoremap gz V%
nnoremap Z za
vnoremap Z zf
nnoremap + zR
nnoremap - zM
nnoremap <DEL> zD
set foldenable
set foldmethod=manual

nnoremap <C-C> gg"+yG
vnoremap <C-C> "+y
nnoremap <space> $
onoremap <space> $
nnoremap <BS> zz
nnoremap <PageUp> <C-U>
nnoremap <PageDown> <C-D>
nnoremap <HOME> <C-B>
nnoremap <END> <C-F>
nnoremap <UP> <C-Y>
nnoremap <DOWN> <C-E>
nnoremap <LEFT> zH
nnoremap <RIGHT> zL
nnoremap <silent> <TAB> :bn<CR>
nnoremap <silent>Q :q<CR>
nnoremap <leader>q q
nmap q <C-L>
vnoremap q <ESC>
nnoremap <silent>dv V%d

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
" Note: <S-Fx> is x+12, <C-Fx> is x+24, <S-C-Fx> is x+36, <A-Fx> is x+48
" Use insert mode to type them
au TermOpen * startinsert
au TermOpen * tnoremap <buffer> <leader><ESC> <C-\><C-N>
" nnoremap <silent><F12> :w<CR>:term bash run.sh<CR>
au FileType python nnoremap <buffer><F9> :w<CR>:term python %<CR>
au FileType python nnoremap <buffer><F33> :w<CR>:term python -i %<CR>
au FileType python nnoremap <buffer><F57> :w<CR>:term python -m pdb %<CR>
au FileType cpp nnoremap <buffer><F9> :w<CR>:term g++ % -o %< -std=c++17<CR>
" A-F9
au FileType cpp nnoremap <buffer><F57> :w<CR>:term g++ % -o %< -std=c++17 -O2<CR>
" C-F9
au FileType cpp nnoremap <buffer><F33> :w<CR>:term g++ % -o %< -std=c++17 -Wall -g -fsanitize=undefined<CR>
au FileType cpp nnoremap <buffer><F10> :term ./%<<CR>
" au FileType cpp nnoremap <buffer><F5> :term cf test %<CR>
" au FileType cpp nnoremap <buffer><F29> :term cf submit -f %<CR>
au FileType c nnoremap <buffer><F9> :w<CR>:term gcc % -o %<<CR>
au FileType c nnoremap <buffer><F10> :term ./%<<CR>
au FileType tex nnoremap <buffer><F9> :w<CR>:term xelatex %<CR>
au FileType sh nnoremap <buffer><F9> :w<CR>:term bash %<CR>
au FileType javascript nnoremap <buffer><F9> :w<CR>:term node %<CR>



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
autocmd FileType cpp nnoremap <F8> :r ~/OI/tem/

call plug#begin('~/.local/share/nvim/site/plugged')

"Skin, Buffer
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'LZDQ/umbra.nvim' " forked from 'navarasu/onedark.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'elihunter173/dirbuf.nvim'
" Plug 'nvim-neo-tree/neo-tree.nvim'
"Plug 'SmiteshP/nvim-navic'
Plug 'folke/noice.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'zaldih/themery.nvim'
Plug 'stevearc/dressing.nvim'

" lsp, highlight, completion
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'lukas-reineke/cmp-under-comparator'
Plug 'milisims/nvim-luaref'
"Plug 'folke/lua-dev.nvim'
" Plug 'folke/neodev.nvim'
Plug 'milisims/nvim-luaref'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'zbirenbaum/copilot.lua'

" Language specific
Plug 'cuducos/yaml.nvim'

" Run, Debug
Plug 'stevearc/overseer.nvim'
Plug 'sakhnik/nvim-gdb'
Plug 'mfussenegger/nvim-dap'

" Typefocus
Plug 'folke/zen-mode.nvim'
Plug 'folke/twilight.nvim'
Plug 'shortcuts/no-neck-pain.nvim'
Plug 'LZDQ/nvim-autocenter'
" Plug '/home/ldq/nvim-autocenter'

" Misc
Plug 'vim-scripts/restore_view.vim'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'kana/vim-smartword'
Plug '3rd/image.nvim'
"Plug 'andymass/vim-matchup'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-focus/focus.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'gaborvecsei/cryptoprice.nvim'
Plug 'rmagatti/auto-session'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'bkad/CamelCaseMotion'
Plug 'gaborvecsei/usage-tracker.nvim'
Plug 'xiyaowong/link-visitor.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'mistricky/codesnap.nvim', { 'do': 'make' }

" Jump
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ggandor/leap.nvim'
" Plug 'ggandor/flit.nvim'
Plug 'rhysd/clever-f.vim'
Plug 'nvim-telescope/telescope.nvim', " { 'tag': '0.1.6' }
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2'}

" interactive python
Plug 'benlubas/molten-nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

" textobj
Plug 'kana/vim-textobj-user'
Plug 'fvictorio/vim-textobj-backticks'  " `
"Plug 'D4KU/vim-textobj-chainmember'  " m
"Plug 'glts/vim-textobj-comment'  " c
Plug 'pianohacker/vim-textobj-indented-paragraph'  " r, g(  and g) for jump
Plug 'jceb/vim-textobj-uri'  " iu for URL, go to open the URL
Plug 'Julian/vim-textobj-variable-segment'  " v
Plug 'tkhren/vim-textobj-numeral'  " numbers.
Plug 'kana/vim-textobj-lastpat' " search pat

" Games
Plug 'ThePrimeagen/vim-be-good'
Plug 'alec-gibson/nvim-tetris'
Plug 'seandewar/nvimesweeper'
Plug 'seandewar/killersheep.nvim'
Plug 'rktjmp/playtime.nvim'
Plug 'Eandrju/cellular-automaton.nvim'
" Plug 'alanfortlink/blackjack.nvim'
Plug 'jim-fx/sudoku.nvim'

call plug#end()


let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlPMixed'


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
" nnoremap gnn <Plug>(textobj-numeral-n)
" nnoremap gpn <Plug>(textobj-numeral-p)

let g:clever_f_not_overwrites_standard_mappings = 1
let g:clever_f_across_no_line = 1
let g:clever_f_timeout_ms = 1500
let g:clever_f_highlight_timeout_ms = g:clever_f_timeout_ms
nnoremap f <Plug>(clever-f-f)
nnoremap F <Plug>(clever-f-F)


set cursorline
set cursorlineopt=number
set termguicolors
au FileType * set formatoptions-=o

nnoremap > <Plug>CamelCaseMotion_w
nnoremap < <Plug>CamelCaseMotion_b


" au TextChangedI * call v:lua.vim.notify("text changed I")
" au InsertEnter * call v:lua.vim.notify("insert enter")
" au InsertCharPre * call v:lua.vim.notify("insert char pre")

lua require('config')

