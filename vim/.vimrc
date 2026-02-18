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

" --- Auto Reload ---
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Reloaded." | echohl None

" --- Highlight Yank ---
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END

set number 
set relativenumber
set scrolloff=8
set termguicolors

colorscheme tokyonight
let g:tokyonight_style = 'night' " options: night, storm
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

" --- Persistent Undo ---
if has("undofile")
  set undodir=~/.vim/undodir
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

let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1

let g:UltiSnipsExpandTrigger="<C-l>"

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

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
nnoremap <leader>t :botright split +terminal \| resize 10<CR>
tnoremap <Esc> <C-\><C-n>

" --- Buffer Navigation ---
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
nnoremap <leader>x :bd<CR>

" --- Movement ---
nnoremap J 10j
nnoremap K 10k
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
