" ----------------------------
" ------- Vim settings -------
" ----------------------------
set nocompatible
filetype off

" -------------------------
" Vundle
" -------------------------
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Quramy/tsuquyomi'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/MatchTagAlways'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gilgigilgil/anderson.vim'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-syncopate'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/seoul256.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-signify'
Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/scratch.vim'
Plugin 'xolox/vim-misc'

call vundle#end()
filetype plugin indent on

call glaive#Install()

" -------------------------
" CtrlP
" -------------------------
" Use AG for CtrlP.
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = '/usr/bin/ag %s -i --nocolor --nogroup --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore "**/*.pyc"
    \ --ignore .git5_specs
    \ --ignore review
    \ -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" -------------------------
" TypeScript plugin setup (Tsuquyomi)
" -------------------------
let g:tsuquyomi_use_dev_node_module = 2
let g:tsuquyomi_use_vimproc = 1

nnoremap <silent> <leader>h :echo tsuquyomi#hint()<CR>

" -------------------------
" Syncopate
" -------------------------
" Glaive syncopate colorscheme='beauty256'
let g:html_font = ["DejaVu Sans Mono", "Consolas"]

" -------------------------
" vim-codefmt
" -------------------------
Glaive codefmt plugin[mappings]
vnoremap <leader>f :FormatLines<CR>

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
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardsTrigger = '<c-k>'

" -------------------------
" vim-airline
" -------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'zenburn'

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
" vim-commentary
" -------------------------
" Always use single-line commenting in C/C++.
autocmd FileType c,cpp setlocal commentstring=//\ %s
xnoremap <C-\> gc

" -------------------------
" vim-easymotion
" -------------------------
" Use EasyMotion work with the '/' operator.
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
"
" " Make n/N work through EasyMotion.
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" -------------------------
" vim-gitgutter
" -------------------------
" Diff from branch 'main'.
let g:gitgutter_diff_args='main'
" Reduce the updatetime to ensure the gutter is updated quickfast.
set updatetime=100

" -------------------------
" vim-signify
" -------------------------
let g:signify_vcs_list=['hg', 'git']
let g:signify_vcs_cmds = {
  \ 'hg': 'hg diff -r .^ --color never --config defaults.diff= --nodates -U0 -- %f',
  \ }

" -------------------------
" vim-go
" -------------------------
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" -------------------------
" vim-session
" -------------------------
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" -------------------------
" Formatting
"
" Color themes from:
"     https://github.com/xonecas/vim-colors-256
" Color themes you seem to have liked:
"   * anderson
"   * 256-grayvim
"   * 256-jungle
"   * jellybeans
"   * seoul256
" -------------------------
syntax enable

color seoul256
" Fix termguicolors.
" https://stackoverflow.com/questions/62702766/termguicolors-in-vim-makes-everything-black-and-white
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
set termguicolors
set expandtab
set hlsearch
set incsearch
set ignorecase
set smartcase
set laststatus=2
set nu
set relativenumber
set shiftwidth=2
set softtabstop=2
set tabstop=2
set title
set t_Co=256     " Force 256 colors so that Powerline/Solarized work.
set tw=79
set wildmode=longest,list,full

set colorcolumn=81
highlight ColorColumn ctermbg=8

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" Save undo's after a file is closed.
set undofile
set undodir=$HOME/.vim/undo

" -------------------------
" Solarized color scheme.
" Disabled for now in order to try something new.
" -------------------------
" let g:solarized_termcolors=256
" let g:solarized_background='dark'
" set background=dark
" colorscheme solarized
" 
" " Allow for quickly toggling between dark/light.
" function! ToggleSolarizedBackground()
"   if g:solarized_background == 'dark'
"     set background=light
"     let g:solarized_background = 'light'
"   else
"     set background=dark
"     let g:solarized_background = 'dark'
"   endif
"   colorscheme solarized
" endfunction
" 
" nnoremap <F5> :call ToggleSolarizedBackground()<CR>
" inoremap <F5> <ESC>:call ToggleSolarizedBackground()<CR>a
" vnoremap <F5> <ESC>:call ToggleSolarizedBackground()<CR>

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

" Create a new (empty) file with the name of the item under the cursor.
map <silent> <leader>cf :call writefile([], expand("<cfile>"), "t")<cr>

" Move between windows with Ctrl+(hjkl).
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>

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
  if line("'\"") <= line('$')
    normal! g`"
    return 1
  endif
endfunction

augroup res_cur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

augroup cron_config
  autocmd!
  autocmd FileType crontab setlocal foldmethod=marker
  autocmd FileType crontab setlocal formatoptions-=t
augroup END

" Auto-format settings.
augroup autoformat_settings
  au FileType rust AutoFormatBuffer rustfmt
  au FileType typescript AutoFormatBuffer clang-format
augroup END

" Automatically change the working path to the path of the current file
autocmd BufNewFile,BufEnter * silent! lcd %:p:h

" Fix C++ commenting for vim-commentary.
autocmd FileType c,cpp setlocal commentstring=//\ %s

" -------------------------
" Spelling.
" -------------------------
noremap <leader>ss :setlocal spell! spelllang=en_us<cr>

" -------------------------
" swp Files.
" -------------------------
set directory=~/.vimswp

" Read environment-specific settings from .vimrc_local.
if filereadable(expand('~') . '/.vimrc_local')
  source ~/.vimrc_local
endif
