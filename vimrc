set nocompatible
filetype off

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
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'racer-rust/vim-racer'
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'tomlion/vim-solidity'
Plug 'mileszs/ack.vim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'vimlab/split-term.vim'
"Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'yosssi/vim-ace'
Plug 'rhysd/vim-grammarous'
Plug 'tpope/vim-commentary'
Plug 'reedes/vim-wordy'
Plug 'davidhalter/jedi-vim'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'soywod/kronos.vim'
Plug 'rakr/vim-one'
Plug 'burner/vim-svelte'
call plug#end()


filetype plugin indent on
syntax enable

" Основные настройки
set encoding=UTF-8
set autoindent
set autoread " Reload files changed outside automatically
set backspace=indent,eol,start
set expandtab
set hlsearch
set incsearch " Show search matches while typing
set lazyredraw
set nobackup
set noshowmode
set shiftwidth=4
set showcmd
set showmatch
set smartindent
set smarttab
set tabstop=4
set title
set ttyfast
set tags=./tags;$HOME,tags;
set shortmess+=c
set diffopt+=algorithm:patience

" Use relative number hybrid mode
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set wildmenu
set wildmode=list:longest,list:full " Wildmenu configuration
set wildignore+=*.o,*.pyc,*.jpg,*.png,*.gif,*.db,*.obj,.git " Ignore compiled files
set exrc " enable reading .exrc files for each dir
set hidden

" Store swap, backup and undo files in fixed location
set dir=/var/tmp//,/tmp//,.
set backupdir=/var/tmp//,/tmp//,.
set history=64
set undolevels=128
set undodir=~/.vim/undodir/
set undofile
set undolevels=100
set undoreload=1000

" supertab config
function CommentTagContext()
  if (getline('.')[:col('.')-1] =~ '\.*\/\/\.*')
    return "\<c-x>\<c-p>"
  endif
endfunction
let g:SuperTabCompletionContexts =
    \ ['CommentTagContext', 's:ContextText', 's:ContextDiscover']
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType="<c-x><c-o>"

" enable hardtime mode everytime
let g:hardtime_default_on = 1

" настраиваем раскладку
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

" Настраиваем фуззифайндер
nmap <leader>fz :FZF<CR>

" Настраиваем ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" Настраиваем silversearch-ag для модуля ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" higlight but not jump
nnoremap * *N

" Подсвечивает по звёздочке выделенный блок во всём файле
vnoremap * y :execute ":let @/=@\""<CR> :execute "set hlsearch"<CR>

" Настройка цвета ограничительной линии
hi ColorColumn ctermbg=white

" Настраиваем syntastic
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']

" Настройка solirized темы
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif

set t_Co=256
set background=light
" colorscheme solarized
colorscheme PaperColor

" Настраиваем netrw
let g:netrw_liststyle=3
let g:netrw_list_hide= '^\..\?'
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"

" Настраиваем yaml
autocmd FileType yaml,yml setlocal shiftwidth=2
autocmd FileType yaml,yml setlocal tabstop=2

" Настраиваем bufexplorer
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerDetailedHelp=0      " Do not show detailed help.
let g:bufExplorerShowDirectories=0   " Don't show directories.
let g:bufExplorerSortBy='number'     " Sort by the buffer's name.

" Настраиваем JS
autocmd FileType javascript,js,html,svelte setlocal expandtab
autocmd FileType javascript,js,html,svelte setlocal tabstop=2
autocmd FileType javascript,js,html,svelte setlocal shiftwidth=2

" Настраиваем Python
let python_highlight_all = 1
autocmd FileType python setlocal colorcolumn=80
autocmd FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python inoremap <Nul> <C-x><C-o> " Auto completion via ctrl-space (instead of the nasty ctrl-x ctrl-o)
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Настраиваем Rust
let g:rustc_path=$HOME."/.cargo/bin/rustc"
let g:racer_cmd=$HOME."/.cargo/bin/racer"
let g:racer_experimantal_completer=1
au FileType rust nmap <leader>gg <Plug>(rust-def)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

"au FileType rust let g:syntastic_rust_checkers=['rustc']
au BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
au BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . getcwd() . "&"

" Setup clang autocomplete
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd-8'],
  \ }

" Настраиваем GO
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal tabstop=4
autocmd FileType go setlocal colorcolumn=120
autocmd FileType go setlocal foldmethod=syntax
autocmd FileType go setlocal foldnestmax=10
autocmd FileType go setlocal nofoldenable
autocmd FileType go setlocal foldlevel=0
autocmd FileType go nmap <leader>gi :GoImport
autocmd FileType go nmap <leader>gf :GoInfo<CR>
autocmd FileType go nmap <leader>gd :GoDoc<CR>
autocmd FileType go nmap <leader>gg :GoDef<CR>
autocmd FileType go nmap <leader>gr :GoRename
autocmd FileType go set completeopt-=preview
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_rename_command = 'gopls'

" Настраиваем Tagbar
nnoremap <leader>tb :TagbarToggle<CR>
let g:tagbar_autoclose=1
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
let g:tagbar_show_linenumbers=2

hi MatchParen cterm=bold ctermbg=black ctermfg=yellow
