" ----------------------------
" ------- Vim settings -------
" ----------------------------
set nocompatible
filetype off


" -------------------------
" Determine if we are at a Google workstation.
" -------------------------
let google_path = $HOME . '/google/google_vim_settings.vim'
let at_google = filereadable( google_path )


" -------------------------
" Vundle
" -------------------------
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/MatchTagAlways'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-syncopate'
Plugin 'honza/vim-snippets'
Plugin 'jnwhiteh/vim-golang'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/scratch.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'


" If we are not at a Google workstation, use the public version of YCM.
if at_google == 0
  Plugin 'Valloric/YouCompleteMe'
endif

call vundle#end()
filetype plugin indent on


" -------------------------
" Golang
" -------------------------
set rtp+=/usr/lib/google-golang/misc/vim
augroup go_setup
  autocmd!
  autocmd FileType go autocmd BufWritePre <buffer> Fmt
augroup END


" -------------------------
" NERDTree
" -------------------------
map <C-n> : NERDTreeToggle<CR>


" -------------------------
" Powerline
" -------------------------
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set encoding=utf-8
let g:Powerline_symbols = 'fancy'


" -------------------------
" Tagbar
" -------------------------
nnoremap <F8> :TagbarToggle<CR>
nnoremap \tp :TagbarTogglePause<CR>
let g:tagbar_sort = 0


" -------------------------
" UltiSnips
" -------------------------
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardsTrigger = "<c-k>"


" -------------------------
" Vim-Airline
" -------------------------
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" Powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


" -------------------------
" Vim Session
" -------------------------
let g:session_autosave = 'no'


" -------------------------
" Formatting
" -------------------------
syntax enable
set expandtab
set hlsearch
set incsearch
set ignorecase
set smartcase
set laststatus=2
set nu
set shiftwidth=2
set softtabstop=2
set tabstop=2
set title
set t_Co=256     " Force 256 colors so that Powerline/Solarized work.
set tw=79
set wildmode=longest,list,full

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo


" -------------------------
" Solarized color scheme
" -------------------------
let g:solarized_termcolors=256
let g:solarized_background='dark'
set background=dark
colorscheme solarized

" Allow for quickly toggling between dark/light.
function! ToggleSolarizedBackground()
  if g:solarized_background == "dark"
    set background=light
    let g:solarized_background = "light"
  else
    set background=dark
    let g:solarized_background = "dark"
  endif
  colorscheme solarized
endfunction

nnoremap <F5> :call ToggleSolarizedBackground()<CR>
inoremap <F5> <ESC>:call ToggleSolarizedBackground()<CR>a
vnoremap <F5> <ESC>:call ToggleSolarizedBackground()<CR>


" -------------------------
" Mappings
" -------------------------
nnoremap \o :set paste!<CR>
nnoremap <F10> :set relativenumber!<CR>

" Keep search matches in the middle of the window.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" Make j/k work row-wise instead of line-wise
nnoremap j gj
nnoremap k gk

" These create newlines like o and O but stay in normal mode
nnoremap zj o<Esc>k
nnoremap zk O<Esc>j


" -------------------------
" Buffer actions.
" -------------------------
" Trim trailing whitespace on save
function! TrimSpace()
  let l:currview = winsaveview()
  %s/\s\+$//e
  call winrestview(l:currview)
endfunction

augroup trim_space
  autocmd!
  autocmd FileType java,python autocmd BufWritePre * :call TrimSpace()
augroup END

" Restore the cursor position upon entering the buffer.
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup res_cur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" -------------------------
" @Google
" -------------------------
" If we are on a Google workstation, load alternative settings.
if at_google
  exec 'source '. google_path
else
  " Still use Google's style settings for Python. In the default python.vim,
  " the following is included:
  " setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
  " First, source the standard version.
  source $VIMRUNTIME/ftplugin/python.vim

  " Then change our settings.
  setlocal tabstop=8 shiftwidth=2 softtabstop=2 textwidth=80 expandtab
endif
