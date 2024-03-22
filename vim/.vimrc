set cpo-=<
set rnu
set nu

set nowrap
set noeb

syntax on

set nobackup
set noswapfile
set noundofile

inoremap jk <ESC>

inoremap <TAB> <C-P>
inoremap <S-TAB> <TAB>

let grader=0
function Compile(g)
	if a:g==0
		!clear; g++ % -o %< -std=c++17
	elseif a:g==1
		!clear; g++ grader.cpp % -o % -std=c++17
	elseif a:g==2
		!clear; ./compile.sh
	endif
endfunction
inoremap <C-V> <ESC>"+pa
"set backspace=indent,eol,start
autocmd FileType tex nnoremap <F9> :w<CR>:!clear; xelatex %<CR>
autocmd FileType tex nnoremap <C-F9> :w<CR>:!clear; pdflatex %<CR>
autocmd FileType c nnoremap <F9> :w<CR>:!clear; gcc % -o %<<CR>
autocmd FileType c nnoremap <C-F9> :w<CR>:!clear; gcc % -o %< -fno-stack-protector -no-pie -g<CR>
autocmd FileType c nnoremap <F12> :!clear; ./%<<CR>
autocmd FileType cpp nnoremap <F9> :w<CR>:!clear; g++ % -o %< -std=c++14<CR>
autocmd FileType cpp nnoremap <F9> :w<CR>:call Compile(grader)<CR>
autocmd FileType cpp nnoremap <A-F9> :w<CR>:!clear; g++ % -o %< -std=c++17 -O2<CR>
autocmd FileType cpp nnoremap <C-F9> :w<CR>:!clear; g++ % -o %< -g -Wall -std=c++17 -fsanitize=address,leak,undefined<CR>
autocmd FileType cpp nnoremap <F12> :!clear; ./%<<CR>
autocmd FileType python nnoremap <F9> :w<CR>:!clear; python %<CR>
autocmd FileType python nnoremap <C-F9> :w<CR>:!clear; python -i %<CR>
autocmd FileType python nnoremap <A-F9> :w<CR>:!clear; python -m pdb %<CR>
autocmd FileType python nnoremap <F12> :w<CR>:!clear; bash run.sh<CR>
autocmd FileType sh nnoremap <F9> :w<CR>:!clear; bash %<CR>
autocmd FileType cpp nnoremap <F5> :!clear; cf test %<CR>
autocmd FileType cpp nnoremap <F6> :!clear; cf submit -f %<CR>
"autocmd FileType html nnoremap <F9> :w<CR>:!tidy -m -i -html -wrap 0 %<CR>:e<CR>
autocmd FileType php nnoremap <F9> :w<CR>:!clear; php %<CR>
" echo &filetype
nnoremap <tab> 4l
nnoremap <S-tab> 4h
nnoremap z %
nnoremap <C-RIGHT> 8zl
nnoremap <RIGHT> zL
nnoremap <C-LEFT> 8zh
nnoremap <LEFT> zH
nnoremap <UP> <C-Y>
nnoremap <DOWN> <C-E>
nnoremap <HOME> <C-B>
nnoremap <END> <C-F>
nnoremap <PageUp> <C-U>
nnoremap <PageDown> <C-D>
vnoremap <HOME> <C-B>
vnoremap <END> <C-F>
vnoremap <PageUp> <C-U>
vnoremap <PageDown> <C-D>
nnoremap <BS> zz
nnoremap dz d%
nnoremap dv V%d
nnoremap =z =%
nnoremap yz V%y$%
set foldenable
set foldmethod=manual
nnoremap Z za
vnoremap z %
vnoremap Z zf
nnoremap ` V%zf
nnoremap + zR
nnoremap - zM
nnoremap <DEL> zD
nnoremap <C-C> gg"+yG
vnoremap <C-C> "+y
nnoremap <space> $
vnoremap <space> $
nnoremap <silent> Q :q<CR>
set tabstop=4
set shiftwidth=4
set softtabstop=4
set mouse=a
"set cindent
set autoindent
set smartindent
filetype plugin indent on
silent !if [ $(tput lines) -lt 28 ]; then resize -s 28 110; fi > /dev/null

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
autocmd FileType cpp inoremap UU <ESC>ccusing namespace std;
autocmd FileType cpp inoremap TY <ESC>cctypedef long long ll;
autocmd FileType cpp nnoremap <F8> :r ~/OI/tem/
set noexpandtab
%retab!
set ic
colorscheme mycyberpunk
"set termguicolors
"set encoding=utf-8


set viewoptions=cursor,folds,slash,unix
set laststatus=2
nmap <2-LeftMouse> <leader>d

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/restore_view.vim'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'machakann/vim-swap'
Plug 'vim-python/python-syntax'
Plug 'davidhalter/jedi-vim'
"Plug 'tpope/vim-pathogen'
"Plug 'TaDaa/vimade'
"Plug 'https://github.com/junegunn/fzf.git'
"Plug 'https://github.com/ycm-core/YouCompleteMe.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()

"let g:airline_theme='deus'

let g:AutoPairsFlyMode = 0

let g:python_highlight_builtins = 1
let g:python_highlight_string_format = 1
let g:python_highlight_string_templates = 1

let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures_delay = 0

let g:pyindent_open_paren = 'shiftwidth()'
"autocmd FileType python call jedi#configure_call_signatures()
