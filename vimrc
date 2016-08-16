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
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" color plugins
Plugin 'flazz/vim-colorschemes'

" ruby plugins
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'

" csharp plugins
Plugin 'OrangeT/vim-csharp'

" exlir plugins
Plugin 'elixir-lang/vim-elixir'
Plugin 'mattreduce/vim-mix'

" javascript
Plugin 'pangloss/vim-javascript'
Plugin 'Shutnik/jshint2.vim'

" handlebars
Plugin 'mustache/vim-mustache-handlebars'

" editor plugins
Plugin 'duff/vim-scratch'
Plugin 'ervandew/supertab'
Plugin 'garbas/vim-snipmate'
Plugin 'godlygeek/csapprox'
Plugin 'honza/vim-snippets'
Plugin 'kien/ctrlp.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'myusuf3/numbers.vim'
Plugin 'roman/golden-ratio'
Plugin 'Syntastic'
Plugin 'tomtom/tlib_vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'

call vundle#end()
filetype plugin indent on

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

" use vims spell checking
set spell

" tab settings
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

set cmdheight=1
set switchbuf=useopen
set showtabline=2
set winwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" enable file type detection
syntax on
filetype plugin indent on
filetype plugin on

let g:OmniSharp_selector_ui = 'ctrlp'
let g:OmniSharp_timeout = 1
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
let g:syntastic_javascript_checkers = ['jsxhint']
let g:mustache_abbreviations = 1

set noshowmatch
set completeopt=longest,menuone,preview


" set tabs for file types
augroup myfiletypes
  " clear old auto comds in group
  autocmd!

  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml,javascript,sass,cumber,haml,html.handlebars setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType python,cs set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd! FileType mkd setlocal syn=off

  "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

  "show type information automatically when the cursor stops moving
  autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

  "The following commands are contextual, based on the current cursor position.
  autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
  autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
  autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
  autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
  autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>

  "finds members in the current buffer
  autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>

  "cursor can be anywhere on the line containing an issue
  autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
  autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
  autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
  autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>

augroup END

" load vimrc from current directory and disable unsafe commands in them
set exrc
set secure
set updatetime=500
set cmdheight=2

" use UTF-8 without BOM
set encoding=utf-8 nobomb
set spelllang=en_us

" set comma ast <leader> instead of default backslash
let mapleader=','

"custom leader commands
nmap <leader>bi  :source ~/.vimrc<cr>:PluginInstall<cr>
nmap <silent> <leader>s :set spell!<cr>
map  <leader>ac  :sp app/controllers/application_controller.rb<cr>
map  <leader>bb  :!bundle install<cr>
map  <leader>gst :Gstatus<cr>
map  <leader>gv  :CtrlP app/views<cr>
map  <leader>gc  :CtrlP app/controllers<cr>
map  <leader>gm  :CtrlP app/models<cr>
map  <leader>gb  :CtrlP app/behaviors<cr>
map  <leader>gd  :CtrlP domain<cr>
map  <leader>gl  :CtrlP lib<cr>
map  <leader>ga  :CtrlP app/assets<cr>
map  <leader>gs  :CtrlP app/specifications<cr>
map  <leader>gg  :topleft 100 :split Gemfile<cr>
map  <leader>gr  :topleft :split config/routes.rb<cr>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

imap <c-l> <space>=><space>

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

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
colorscheme zazen    " Set the default colorscheme
set noerrorbells     " Disable error bells
set shortmess=atI    " Don't show the Vim intro message
set number           " Show line numbers

" Use relative line numbers - This is now handled by numbers.vim
if exists("&relativenumber")
  set relativenumber
endif

" Override grep infavor of the silver searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough to turn off CtrlP cache
    let g:ctrlp_use_caching = 0
endif

"" status Line
if has('statusline') && !&cp
  set laststatus=2                  " windows always have status line
  set statusline=%f\ %y\%m\%r       " filename [type][modified][readonly]
  set stl+=%{fugitive#statusline()} " git via fugitive.vim
  set stl+=\[b%n/%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}\]
  set stl+=\ %l/%L[%p%%]\,%v        " line/total[%],column
endif
