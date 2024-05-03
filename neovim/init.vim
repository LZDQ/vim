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
nnoremap <leader>z z
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
vnoremap <space> $
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
nnoremap Q :q<CR>
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
au FileType cpp nnoremap <F33> :w<CR>:term g++ % -o %< -std=c++17 -Wall -g -fsanitize=undefined<CR>
au FileType cpp nnoremap <F10> :w<CR>:term ./%<<CR>
au FileType cpp nnoremap <F4> :term cf test %<CR>
au FileType cpp nnoremap <F5> :term cf submit -f %<CR>
au FileType cpp tnoremap <F4> <CR>:term cf test %<CR>
au FileType cpp tnoremap <F5> <CR>:term cf submit -f %<CR>
"au FileType cpp tnoremap <F9> <CR>:term g++ % -o %< -std=c++17<CR>
au FileType cpp tnoremap <F10> <CR>:term ./%<<CR>
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

"Skin, Buffer
Plug 'nvim-lualine/lualine.nvim'
"Plug 'nvim-tree/nvim-web-devicons'
Plug 'navarasu/onedark.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'elihunter173/dirbuf.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'
"Plug 'SmiteshP/nvim-navic'
Plug 'folke/noice.nvim'
Plug 'rcarriga/nvim-notify'

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
Plug 'folke/neodev.nvim'
Plug 'milisims/nvim-luaref'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

" Misc
Plug 'vim-scripts/restore_view.vim'
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-surround'
Plug 'kana/vim-smartword'
Plug '3rd/image.nvim'
"Plug 'andymass/vim-matchup'

" Jump
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ggandor/leap.nvim'

" interactive python
Plug 'benlubas/molten-nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

" textobj
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
"Plug 'sgur/vim-textobj-parameter'  " ,
"Plug 'lucapette/vim-textobj-underscore'  " _
Plug 'jceb/vim-textobj-uri'  " iu for URL, go to open the URL
Plug 'Julian/vim-textobj-variable-segment'  " v
"Plug 'bps/vim-textobj-python'  " python specific. af if for function, [pf, ]pf for jump function
Plug 'tkhren/vim-textobj-numeral'  " numbers.
call plug#end()


let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlPMixed'

" fzf current buffer
nnoremap gl :Lines<CR>
nnoremap gf :Files<CR>

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

" Custom lua configs (packaged)
lua require('config')
