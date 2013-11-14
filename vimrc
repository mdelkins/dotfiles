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

" javascript
Bundle 'kchmck/vim-coffee-script'

" editor
Bundle 'tpope/vim-surround'
Bundle 'ervandew/supertab'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'myusuf3/numbers.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'koron/nyancat-vim'
Bundle 'elixir-lang/vim-elixir'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-foreplay'
Bundle 'tpope/vim-classpath'
Bundle 'guns/vim-clojure-static'

" =============================================================================
" initialization
" =============================================================================

" clear autocmds
autocmd!

" use vim settings, instead of vi settings (default when a vimrc exists)
set nocompatible

" enable file type detection
filetype plugin indent on

" load vimrc from current directory and disable unsafe commands in them
set exrc
set secure

" use UTF-8 without BOM
set encoding=utf-8 nobomb

" set comma ast <leader> instead of default backslash
let mapleader=','

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
