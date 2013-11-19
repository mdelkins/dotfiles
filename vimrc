" vim: ts=2 sts=2 sw=2 expandtab:
"
" customization and orgainization inspired by gregstallings
"
" special thanks to:
" @r00k
" @garybernhardt
" @tpope
" @JEG2
" @avdi
"
" =============================================================================
" vundle
" =============================================================================

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" color schemes
Bundle 'flazz/vim-colorschemes'

" ruby
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'

" javascript
Bundle 'kchmck/vim-coffee-script'

" editor
Bundle 'tpope/vim-surround'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'myusuf3/numbers.vim'
Bundle 'koron/nyancat-vim'
Bundle 'ggreer/the_silver_searcher'
Bundle 'Syntastic'
Bundle 'duff/vim-scratch'

" =============================================================================
" initialization
" =============================================================================

" clear autocmds
autocmd!

execute pathogen#infect()

" use vim settings, instead of vi settings (default when a vimrc exists)
set nocompatible
set hidden

" remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" allow backspacing over everything in insert mode
set backspace=indent,eol,start


" enable file type detection
syntax on
filetype plugin indent on

" set tabs for file types
augroup myfiletypes
  " clear old auto comds in group
  autocmd!

  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml,javascript,sass,cumber,haml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
augroup END

" load vimrc from current directory and disable unsafe commands in them
set exrc
set secure

" use UTF-8 without BOM
set encoding=utf-8 nobomb

" set comma ast <leader> instead of default backslash
let mapleader=','


"custom leader commands
map  <leader>ac  :sp app/controllers/application_controller.rb<cr>
map  <leader>bb  :!bundle install<cr>
nmap <leader>bi  :source ~/.vimrc<cr>:BundleInstall<cr>
map  <leader>gst :Gstatus<cr>
map  <leader>gv  :ClearCtrlPCache<cr>\|:CtrlP app/views<cr>
map  <leader>gc  :ClearCtrlPCache<cr>\|:CtrlP app/controllers<cr>
map  <leader>gm  :ClearCtrlPCache<cr>\|:CtrlP app/models<cr>
map  <leader>gmm :ClearCtrlPCache<cr>\|:CtrlP app/mailers<cr>
map  <leader>gb  :ClearCtrlPCache<cr>\|:CtrlP app/behaviors<cr>
map  <leader>gd  :ClearCtrlPCache<cr>\|:CtrlP app/decorators<cr>
map  <leader>gl  :ClearCtrlPCache<cr>\|:CtrlP lib<cr>
map  <leader>gj  :ClearCtrlPCache<cr>\|:CtrlP app/assets/javascript<cr>
map  <leader>gjb :ClearCtrlPCache<cr>\|:CtrlP app/jobs<cr>
map  <leader>gs  :ClearCtrlPCache<cr>\|:CtrlP app/assets/stylesheets<cr>
map  <leader>gsp :ClearCtrlPCache<cr>\|:CtrlP app/specifications<cr>
map  <leader>gg  :topleft 100 :split Gemfile<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
    :topleft 100 :split __Routes__
    :set buftype=nofile
    :normal 1GdG
    :0r! rake -s routes
    :exec ":normal " .line$("$") . "_ "
    :normal 1GG
    :normal dd
endfunction

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" =============================================================================
" appearance
" =============================================================================

set scrolloff=5      " Keep more buffer context when scrolling
set showtabline=2    " Always show the tab bar
set cmdheight=1      " Set command line height (default)
set title            " Show the filename in the window titlebar
set t_Co=256         " 256 colors
set background=dark  " Dark background
syntax on            " Enable syntax highlighting
colorscheme obsidian " Set the default colorscheme
set noerrorbells     " Disable error bells
set shortmess=atI    " Don't show the Vim intro message
set number           " Show line numbers

" Use relative line numbers - This is now handled by numbers.vim
if exists("&relativenumber")
  set relativenumber
"  au BufReadPost * set relativenumber
endif

"" status Line
if has('statusline') && !&cp
  set laststatus=2                  " windows always have status line
  set statusline=%f\ %y\%m\%r       " filename [type][modified][readonly]
  set stl+=%{fugitive#statusline()} " git via fugitive.vim
  " buffer number / buffer count
  set stl+=\[b%n/%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}\]
  set stl+=\ %l/%L[%p%%]\,%v        " line/total[%],column
endif
