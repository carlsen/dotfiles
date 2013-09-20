" Set this first thing, flipping the vi-compatibility 
set nocompatible

set encoding=utf-8

set nobackup noswapfile

" Default 20
set history=100

" Default 1000
set undolevels=1000

set number
set tabstop=4
set shiftwidth=4
set noexpandtab

set hlsearch
set incsearch
set ignorecase
set smartcase

set autoindent
set smartindent
set backspace=indent,eol,start

" Terminal colors
set t_Co=256

"no bells, no whistles
"set visualbell
"set noerrorbells
set visualbell t_vb=

" Use mouse in terminal if applicable
set mouse=a

" Keep the cursor 2 lines off the top/bottom
set scrolloff=2

" Don't highlight current line
set nocursorline

" Show commands as they're typed
set showcmd

" Show current mode
set showmode

" Set statusline
set laststatus=2
set statusline=%f\ %m\ \(%P\)%=%y
set guitablabel=%t\ %M

" Auto complete for files
set wildmode=list:longest,full
set wildmenu

" Allow block selection beyond line-boundaries
set virtualedit=block

" Don't truncate long lines
set display+=lastline

" Use proper slashes
set shellslash

" Skip splash screen
set shortmess+=I

" Don't redraw screen during macro execution
set lazyredraw

" Don't wrap text
set nowrap

" Allow buffers to be hidden
set hidden

" Show invisibles
",extends:…
set listchars=tab:»\ ,eol:¬
set list

" Use unix line endings (LF) unless the file already has DOS line endings
set fileformats=unix,dos,mac

" Set the initial buffer to unix line endings
set fileformat=unix

filetype indent on

if has('gui_running')
	set guioptions=egmrt
	set lines=42
	set columns=100
endif

if has('gui_gtk2')
	"cp zevvpeep.bdf /usr/share/fonts/X11/misc/
	"xset +fp /usr/share/fonts/X11/misc
	set gfn=peep\ 8
endif

if has('x11')
	"NOWORK
	"set gfn=-zevv-peep-medium-r-normal--16-140-75-75-c-80-iso8859-1
endif

if has('gui_macvim')
	set gfn=GohuFont-Medium:h14
endif

" Seems to hold for Win8 as well...
if has('gui_win32')
	"mv zevvpeep.fon c:\windows\fonts\
	set gfn=peep:h11:cOEM
endif

if exists('+colorcolumn')
	"set cc=80
endif

" 
let mapleader = ','
let g:user_zen_expandabbr_key = '<C-g>'

noremap <silent> <tab> :tabnext<cr>
noremap <silent> <S-tab> :tabprev<cr>
noremap <silent> <C-b>n :b#<cr>
inoremap <C-q> “”<esc>i

" Copy & paste to clipboard
inoremap <C-v> <C-r>*
vnoremap <C-c> "*y

" Home/end in insert mode
inoremap <C-e> <esc>A
inoremap <C-a> <esc>I

" Move current line up or down
noremap <silent> + :m+1<cr>
noremap <silent> - :m-2<cr>

" Shorter for current dir
cnoremap %% <C-r>=expand('%:h').'/'<cr>
cnoremap <C-a> <S-left>

" Windows
nnoremap <C-h> <C-W>h
inoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
inoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
inoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
inoremap <C-l> <C-W>l

" Tabs like windows
noremap <silent> <C-t>n :tabnew<cr>
noremap <C-t>e :tabe %%
noremap <silent> <C-t>t :tabfirst<cr>
noremap <silent> <C-t>l :tabnext<cr>
noremap <silent> <C-t>h :tabprev<cr>
noremap <silent> <C-t>c :tabclose<cr>
noremap <C-t>m :tabmove
noremap <silent> <C-t>b :tablast<cr>
noremap _ :Explore<cr>

" <esc> in normal mode clears search highlight
nnoremap <silent> <esc> :noh<cr><esc>

" Editing files
nnoremap <leader>v :tabedit $MYVIMRC<cr>
nnoremap <leader>p "*p
nnoremap <leader>P "*P
nnoremap <leader>y "*y
nnoremap <leader>Y "*yy
nnoremap <leader>j :JSHint %<cr>
nnoremap <leader>g :!grunt --no-color<cr>
nnoremap <leader>w :set wrap!<cr>
nnoremap <leader>i :set list!<cr>

" Auto completion
function! CompleteOrIndent()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-N>"
	else
		return "\<Tab>"
	endif
endfunction
inoremap <tab> <C-r>=CompleteOrIndent()<cr>
inoremap <s-tab> <C-p>

if has('autocmd')

	"Hmmmmmmmmm
	"autocmd BufNewFile,BufRead *.less set filetype=less

	"Treat handlebars templates as HTML
	autocmd BufNewFile,BufRead *.handlebars set filetype=html
	autocmd BufNewFile,BufRead *.hb set filetype=html

	"Remove linenumbers and colorcolumn from quickfix windows
	autocmd BufReadPost quickfix setlocal colorcolumn=0
	autocmd BufReadPost quickfix setlocal nonumber

	"Set working directory to match that of local file
	autocmd BufEnter * silent! lcd %:p:h

	"JSON is Javascript too!
	autocmd BufNewFile,BufRead *.json setf javascript

endif

nmap <C-S-p> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists('*synstack')
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

set background=
hi clear
if exists('syntax_on')
	syntax reset
endif
"let g:colors_name = 'tobi'
syntax on

" GUI Colors
" hi Normal guibg=#0B1022 railscast blueish
hi Normal guifg=White guibg=Black ctermfg=White ctermbg=Black
hi Cursor guifg=Black guibg=Yellow ctermfg=Black ctermbg=Yellow
hi LineNr guifg=#666666 ctermfg=238
hi Folded guifg=#666666 ctermfg=238
hi Pmenu guibg=White guifg=Black ctermbg=White ctermfg=Black
hi PmenuSel guibg=Green guifg=Black ctermbg=Green ctermfg=Black
hi StatusLine guibg=#CCCCCC guifg=Black gui=NONE cterm=NONE ctermbg=White ctermfg=Black
hi StatusLineNC guibg=#222222 guifg=#999999 gui=NONE cterm=NONE ctermbg=235 ctermfg=242
hi Visual gui=NONE guifg=Black guibg=#666666 ctermbg=238

" hi clear Search
hi Search guibg=#00FF00 guifg=Black ctermbg=Green
hi Special guifg=#FF66FF ctermfg=201
hi Parens ctermfg=White
hi CursorLine guibg=#222222

" Tabs in terminal
hi TabLine gui=NONE cterm=NONE ctermbg=White ctermfg=238
hi TabLineSel gui=NONE cterm=NONE ctermbg=Black ctermfg=White
hi TabLineFill gui=NONE cterm=NONE ctermbg=White

" General Language Colors
hi Comment guifg=#666666 ctermfg=242
hi Constant gui=NONE guifg=#FFFF5F ctermfg=227
hi String guifg=#00D42D ctermfg=76
hi link Character String
hi Operator guifg=Yellow ctermfg=Yellow
hi Type gui=NONE guifg=#ACACFF ctermfg=63
hi Structure guifg=#ACACFF ctermfg=63
hi Identifier guifg=#FF5600 ctermfg=202
hi Function gui=NONE guifg=#FF5600 ctermfg=202
hi Statement gui=NONE guifg=#FFFF5F ctermfg=227
hi link Keyword Statement
hi PreProc gui=NONE guifg=#FF5600 ctermfg=202
hi Repeat guifg=#FF5600 ctermfg=202

" Invisibles (namely the EOL character)
hi NonText gui=NONE guifg=#333333 ctermfg=232
" Tab character
hi SpecialKey guifg=#333333 ctermfg=232

" HTML Colors
hi link htmlTag Type
hi link htmlEndTag htmlTag
hi link htmlTagName htmlTag
hi Title gui=NONE

" JS
hi link JavaScriptValue Number
hi link JavaScriptParens Parens
hi link JavaScriptMember Type
hi link JavaScriptGlobal Type
hi link JavaScript Normal
syntax keyword jsGlobalObjects window document
