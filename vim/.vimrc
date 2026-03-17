" =========================================================
" 1. BOOTSTRAP VIM-PLUG
" =========================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" =========================================================
" 2. PLUGINS
" =========================================================
call plug#begin('~/.vim/plugged')

" --- Theme & UI ---
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sainnhe/gruvbox-material'


" --- Navigation & Search ---
Plug 'preservim/nerdtree'
" Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- command suggestions ---
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }

" --- Language Support ---
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'

" --- Wizard & Git Tools ---
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" --- Snippets & Linting ---
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dense-analysis/ale'

call plug#end()

" =========================================================
" 3. GENERAL SETTINGS
" =========================================================
syntax on
filetype plugin indent on

" --- Auto Reload ---
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" --- Highlight Yank (Improved for Vim) ---
if !has('nvim')
    map y <Plug>(highlight-yank)
endif
" If using Neovim, this is the Lua version:
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END

set cursorline
set number 
set relativenumber
highlight CursorLineNr cterm=bold ctermfg=Yellow gui=bold guifg=#FFD700
highlight GitGutterAdd ctermfg=Green guifg=#a9b665
highlight GitGutterChange ctermfg=Yellow guifg=#d8a657
highlight GitGutterDelete ctermfg=Red guifg=#ea6962 
hi MatchParen cterm=bold ctermbg=NONE ctermfg=cyan gui=bold guibg=NONE guifg=#83a598

set scrolloff=8
set termguicolors
set background=dark

 " let g:PaperColor_Theme_Options = {
 "  \   'theme': {
 "  \     'default': {
 "  \       'transparent_background': 0,
 "  \       'allow_bold': 1,
 "  \       'allow_italic': 1
 "  \     }
 "  \   }
 "  \ }

" colorscheme PaperColor
" hi Normal guibg=NONE ctermbg=NONE
" let g:airline_theme='papercolor'
colorscheme gruvbox-material
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_better_performance = 1
let g:airline_theme='gruvbox_material'
set clipboard=unnamed,unnamedplus
set pastetoggle=<F2>
set foldmethod=indent
set foldlevel=99

set autoindent
set smarttab
set smartindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" --- Performance & UX ---
set hidden
set updatetime=300
set signcolumn=yes
set noswapfile
set ttyfast
set lazyredraw
set ignorecase
set smartcase
set incsearch
set hlsearch
set splitright
set splitbelow

" --- Persistent Undo ---
if has("persistent_undo")
  let target_path = expand('~/.vim/undodir')
  if !isdirectory(target_path) | call mkdir(target_path, "p", 0700) | endif
  let &undodir = target_path
  set undofile
endif

" =========================================================
" 4. PLUGIN CONFIGURATION
" =========================================================
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" Dirvish Sidebar logic: Hide dotfiles & sort folders first
let g:dirvish_mode = ':sort ,^.*[\/],'

" GitGutter (Optimized for speed)
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
autocmd BufWritePost * GitGutter 

" ALE (The Formatter)
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_global = 1
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'json': ['prettier'],
\ 'html': ['prettier'],
\}

" --- Wilder.nvim Config (Vim-Safe Version) ---
call wilder#setup({'modes': [':', '/', '?']})

" Use a simpler popup menu that doesn't rely on mask functions
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ }))

" Keybinds to navigate the Wilder menu with Tab / Shift-Tab
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

" =========================================================
" 5. KEY MAPPINGS
" =========================================================
let mapleader = " "

" --- Terminal (Auto-clean UI) ---
nnoremap <leader>t :terminal<CR>
tnoremap <Esc> <C-\><C-n>
" autocmd TermOpen * setlocal nonumber norelativenumber " Clean terminal look
"
" Auto-clean UI for Terminal (Vim Version)
if has('terminal')
  augroup terminal_settings
    autocmd!
    autocmd TerminalOpen * setlocal nonumber norelativenumber signcolumn=no
  augroup END
endif

" --- Navigation ---
nnoremap <leader>p :Files<CR>
nnoremap <leader>s :Rg<CR>
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
nnoremap <leader>x :bd<CR>

" --- Super Movement ---
nnoremap <leader>j 10j
nnoremap <leader>k 10k
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
" Keep the cursor centered when searching (THIS IS HUGE)
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <Tab> %

" --- Window Movement ---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" --- Ultimate Sidebar Jumps ---
nnoremap <leader>1 :1wincmd w<CR>
nnoremap <leader>2 :2wincmd w<CR>

" Save the current session (splits, tabs, etc.)
nnoremap <leader>SS :mksession! ~/.vim/session.vim<CR>
" Reload the last saved session
nnoremap <leader>RL :source ~/.vim/session.vim<CR>


" --- Dirvish Sidebar (New & Improved) ---
" function! OpenDirvishSidebar()
"     topleft vertical 30split
"     execute 'Dirvish %:p:h'
"     setlocal winfixwidth
" endfunction
" nnoremap <C-n> :call OpenDirvishSidebar()<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

" --- Utils ---
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>u :UndotreeToggle<CR>
" nnoremap <leader>a :silent !live-server --port=8080 &<CR>:redraw!<CR>
nnoremap <leader>g :Git blame<CR>
nnoremap <leader><space> :noh<CR>

" --- Copy/Paste (Termux Specific) ---
nnoremap <C-v> i<C-r>=system('termux-clipboard-get')<CR><Esc>
vnoremap <C-c> "ay:call system('termux-clipboard-set', @a)<CR>
" Toggle the UI for extra space
nnoremap <leader>z :set laststatus=0 showtabline=0 signcolumn=no<CR>
" Restore the UI
nnoremap <leader>Z :set laststatus=2 showtabline=2 signcolumn=yes<CR>

