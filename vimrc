filetype plugin indent on
syntax enable

set autoindent
set autoread
set background=dark
set backspace=2
set balloondelay=250
set encoding=UTF-8
set expandtab
set exrc
set hidden
set history=200
set hlsearch
set iminsert=0
set imsearch=0
set incsearch
set lazyredraw
set nobackup
set nocompatible
set noshowmode
set noswapfile
set nowritebackup
set number relativenumber
set shiftwidth=4
set shortmess+=c
set showcmd
set showmatch
set signcolumn=yes
set smartindent
set smarttab
set tabstop=4
set tags=./tags;$HOME,tags;
set termguicolors
set title
set ttyfast
set ttymouse=sgr
set undodir=~/.vim/undodir/
set undofile
set undolevels=128
set undoreload=1000
set updatetime=500
set wildignore+=*.o,*.pyc,*.jpg,*.png,*.gif,*.db,*.obj,.git
set wildmenu
set wildmode=list:longest,list:full

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go'
Plug 'cespare/vim-toml'
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'moll/vim-node'
Plug 'mileszs/ack.vim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'davidhalter/jedi-vim'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'rakr/vim-one'
Plug 'burner/vim-svelte'
Plug 'pechorin/any-jump.vim'
Plug 'Quramy/tsuquyomi'
Plug 'jparise/vim-graphql'
Plug 'cocopon/iceberg.vim'
Plug 'kamykn/spelunker.vim'
call plug#end()

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Iceberg
colorscheme iceberg

" Fuzzyfinder
nmap <leader>fz :FZF<CR>

" ACK and silversearch-ag
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" higlight but not jump
nnoremap * *N

" higlight block in whole file
vnoremap * y :execute ":let @/=@\""<CR> :execute "set hlsearch"<CR>

" setup line length limit line
hi ColorColumn ctermbg=white

" Syntastic
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']

" Netrw
let g:netrw_liststyle=3
let g:netrw_list_hide= '^\..\?'
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"

" Yaml
autocmd FileType yaml,yml setlocal shiftwidth=2
autocmd FileType yaml,yml setlocal tabstop=2

" Bufexplorer
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerDetailedHelp=0      " Do not show detailed help.
let g:bufExplorerShowDirectories=0   " Don't show directories.
let g:bufExplorerSortBy='number'     " Sort by the buffer's name.

" JS
autocmd FileType javascript,javascriptreact setlocal expandtab
autocmd FileType typescript,typescriptcommon,typescriptreact setlocal expandtab
autocmd FileType html,css,svelte setlocal expandtab

autocmd FileType javascript,javascriptreact setlocal tabstop=2
autocmd FileType typescript,typescriptcommon,typescriptreact setlocal tabstop=2
autocmd FileType html,css,svelte setlocal tabstop=2

autocmd FileType javascript,javascriptreact setlocal shiftwidth=2
autocmd FileType typescript,typescriptcommon,typescriptreact setlocal shiftwidth=2
autocmd FileType html,css,svelte setlocal shiftwidth=2
autocmd BufEnter *.svelte :syntax sync fromstart

" Python
let python_highlight_all = 1
autocmd FileType python setlocal colorcolumn=80
autocmd FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python inoremap <Nul> <C-x><C-o> " Auto completion via ctrl-space (instead of the nasty ctrl-x ctrl-o)
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Rust
let g:rustc_path=$HOME."/.cargo/bin/rustc"
let g:racer_cmd=$HOME."/.cargo/bin/racer"
let g:racer_experimantal_completer=1
au FileType rust nmap <leader>gg <Plug>(rust-def)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

au BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
au BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . getcwd() . "&"

" Clang autocomplete
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd-8'],
  \ }

" Tagbar
nnoremap <leader>tb :TagbarToggle<CR>
let g:tagbar_autoclose=1
let g:tagbar_show_linenumbers=2


" GO
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal tabstop=4
autocmd FileType go setlocal colorcolumn=120
autocmd FileType go setlocal foldmethod=syntax
autocmd FileType go setlocal foldnestmax=10
autocmd FileType go setlocal nofoldenable
autocmd FileType go setlocal foldlevel=0
autocmd FileType go nmap <leader>gi :GoImport 
autocmd FileType go nmap <leader>gn :GoRename 
autocmd FileType go nmap <silent> <buffer> <leader>gf :GoInfo<CR>
autocmd FileType go nmap <silent> <buffer> <leader>gd :GoDoc<CR>
autocmd FileType go nmap <silent> <buffer> <leader>gg :GoDef<CR>
autocmd FileType go nmap <silent> <buffer> <leader>gr :GoReference<CR>
autocmd FileType go set completeopt-=preview
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_rename_command = 'gopls'
