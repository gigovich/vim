set nocompatible
filetype off

call pathogen#helptags()
call pathogen#infect()

filetype plugin indent on
syntax enable

" Основные настройки
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
set number
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

" indentLine config
set list lcs=tab:\┊\ 
let g:indentLine_enabled = 0
let g:indentLine_bgcolor_term = 202
let g:indentLine_bgcolor_gui = '#FF5F00'

" настраиваем раскладку
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

" Настраиваем фуззифайндер
set rtp+=~/.fzf
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
hi ColorColumn ctermbg=red

" Настраиваем syntastic
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']

" Настройка solirized темы
colorscheme solarized
let g:solarized_termcolors=256
set t_Co=256
set background=dark

" Настраиваем netrw
let g:netrw_liststyle=3
let g:netrw_list_hide= '.*\.swp$,.*\.pyc$,^\..*'

" Настраиваем yaml
autocmd FileType yaml,yml setlocal shiftwidth=2
autocmd FileType yaml,yml setlocal tabstop=2

" Настраиваем bufexplorer
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerDetailedHelp=0      " Do not show detailed help.
let g:bufExplorerShowDirectories=0   " Don't show directories.
let g:bufExplorerSortBy='number'     " Sort by the buffer's name.

" Настраиваем JS
autocmd FileType javascript,js setlocal expandtab
autocmd FileType javascript,js setlocal tabstop=4
autocmd FileType javascript,js setlocal shiftwidth=4

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
let g:go_list_type = "quickfix"

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
