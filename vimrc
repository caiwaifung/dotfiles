""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu
set wildignore=*.o,*~,*.pyc
set ruler
set number

set so=2
set whichwrap+=<,>,h,l

set hlsearch
set incsearch

set noerrorbells
set visualbell

"""""""""""""""""""""""""""""""""""""""""""""""""
" => File
"""""""""""""""""""""""""""""""""""""""""""""""""
set nowb
set nobackup
set noswapfile
set autochdir
"set encoding=utf8

"""""""""""""""""""""""""""""""""""""""""""""""""
" => Display
"""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
colorscheme desert
set cursorline
hi CursorLine cterm=NONE ctermbg=black
hi MatchParen ctermbg=red

"""""""""""""""""""""""""""""""""""""""""""""""""
" => Text
"""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap
set ts=4
set sw=4
set expandtab
set smarttab
set autoindent
set smartindent
set nowrap

set list
set listchars=tab:\|\-
set backspace=indent,eol,start

set cinoptions=g0
set foldmethod=marker

"""""""""""""""""""""""""""""""""""""""""""""""""
" => Keys
"""""""""""""""""""""""""""""""""""""""""""""""""
map <C-C> <Esc>:noh<CR><Esc>
let mapleader=';'
let g:EasyMotion_leader_key='<Leader>' 

"""""""""""""""""""""""""""""""""""""""""""""""""
" => Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
function! Compile()
    execute 'w'
    if (&filetype == 'cpp' || &filetype == 'cc')
        execute '!g++ % -o %:t:r -Wall -Wconversion -Wextra -O2 --std=c++0x'
        return
    endif
    if (&filetype == 'c')
        execute '!gcc % -o %:t:r -Wall -Wconversion -Wextra -O2 --std=c99'
        return
    endif
    if (&filetype == 'tex')
        execute '!pdflatex %'
        execute '!rm %:t:r.aux %:t:r.nav %:t:r.out %:t:r.snm %:t:r.toc %:t:r.log'
        return
    endif
    if (&filetype == 'haskell')
        execute '!ghc %'
        execute '!rm %:t:r.hi'
        execute '!rm %:t:r.o'
        return
    endif
    echom 'Unable to compile! (unknown filetype [' . &filetype . '])'
endfunction

function! Run(arg)
    execute 'w'
    if (&filetype == 'c' || &filetype == 'cpp' || &filetype == 'cc')
        execute '!./%:t:r' . a:arg
        return
    endif
    if (&filetype == 'python')
        execute '!python %' . a:arg
        return
    endif
    if (&filetype == 'haskell')
        "execute '!runhaskell %' . a:arg
        execute '!./%:t:r' . a:arg
        return
    endif
    if (&filetype == 'sh')
        execute '!bash %'
    endif
    echom 'Unable to run! (unknown filetype [' . &filetype . '])'
endfunction
" }}}

if has("win32")
    nmap <F8>  :call Compile()<CR>
    nmap <F5>  :call Run("")<CR>
endif
if has("unix")
    nmap <F3>  :!make<CR>
    nmap <F4>  :!make run<CR>
    nmap <F5>  :!open %<CR>
    nmap <F8>  :call Compile()<CR>
    nmap <F9>  :call Run("")<CR>
    nmap <F10> :call Run(" <%:t:r.in")<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_cpp_compiler_options=" -Wall -Wextra -Wconversion -std=c++0x"
