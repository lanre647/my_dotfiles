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
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ghifarit53/tokyonight-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" --- Navigation & Search ---
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- Language Support ---
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'

" --- Wizard & Git Tools ---
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
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

" ---- format command shortcut
command! F :%!prettier --stdin-filepath %
" --- Auto Reload ---
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Reloaded." | echohl None

" --- Highlight Yank ---
augroup highlight_yank
  autocmd!
  if has('nvim')
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
  endif
augroup END

set number 
set relativenumber
set scrolloff=8
set termguicolors

let g:tokyonight_style = 'night' " options: night, storm
colorscheme tokyonight
let g:airline_theme = 'tokyonight'

set clipboard=unnamed,unnamedplus
set pastetoggle=<F2>

set foldmethod=indent
set foldlevel=99

set autoindent
set smartindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
" Performance
set hidden
set updatetime=300
set signcolumn=yes
set noswapfile
set ttyfast
set lazyredraw
" Better searching
set ignorecase
set smartcase
set incsearch
set hlsearch

" Better splits
set splitright
set splitbelow

" Command line completion
set wildmenu
set wildmode=longest:full,full
set shortmess+=c

"" --- Persistent Undo ---
if has("persistent_undo")
  let target_path = expand('~/.vim/undodir')

  if !isdirectory(target_path)
    call mkdir(target_path, "p", 0700)
  endif

  let &undodir = target_path
  set undofile
endif
" =========================================================
" 4. PLUGIN CONFIGURATION
" =========================================================
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

let g:user_emmet_leader_key=','
let g:user_emmet_settings = { 'javascript' : { 'extends' : 'jsx' } }

let g:ale_sign_column_always = 1

let g:UltiSnipsExpandTrigger="<C-l>"

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" ALE improvements
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1

let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'json': ['prettier'],
\}

let $FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

" =========================================================
" 5. KEY MAPPINGS
" =========================================================
let mapleader = " "

" --- Undotree ---
nnoremap <leader>u :UndotreeToggle<CR>

" --- FZF ---
nnoremap <leader>p :Files<CR>
nnoremap <leader>s :Rg<CR>

" --- Terminal ---

tnoremap <Esc> <C-\><C-n>
" nnoremap <leader>t :botright 10split | terminal<CR>
" startinsert

" --- Buffer Navigation ---
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
nnoremap <leader>x :bd<CR>

" --- Movement ---
nnoremap <leader>j 10j
nnoremap <leader>k 10k
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <Tab> %
vnoremap <Tab> %

" --- Window Movement ---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" --- Toggles & Utils ---
nnoremap <leader>n :set relativenumber!<CR>
nnoremap <leader>w :w<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader><space> :noh<CR>
nnoremap <leader>g :Git blame<CR>

" --- Folding ---
nnoremap <leader>f za
nnoremap <leader>F zM
nnoremap <leader>a zR

" --- Editing ---
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==


"----------------------------------------------------
" --- Termux Quality Of Life Setup ---
" Copy to Android clipboard
" vnoremap <C-c> :w !termux-clipboard-set<CR>
"----------------------------------------------------
" Paste from Android clipboard
" nnoremap <C-v> :read !termux-clipboard-get<CR>
" ----------------------------------------------------
" Paste from Android clipboard into the current cursor position
nnoremap <C-v> i<C-r>=system('termux-clipboard-get')<CR><Esc>
" Copy EXACT selection to Android clipboard
vnoremap <C-c> "ay:call system('termux-clipboard-set', @a)<CR>
"
"----------------------------------------------------
