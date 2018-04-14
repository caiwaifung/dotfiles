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

set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""
" => File
"""""""""""""""""""""""""""""""""""""""""""""""""
set nowb
set nobackup
set noswapfile
set autochdir
"set encoding=utf8
au BufNewFile,BufRead *.rs set filetype=rust
au BufNewFile,BufRead *.scala set filetype=scala
au Filetype scala setlocal ts=2 sts=2 sw=2
au Filetype make setlocal noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""
" => Display
"""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
colorscheme molokai
set cursorline
hi CursorLine cterm=NONE ctermbg=black
hi MatchParen ctermbg=yellow
hi SyntasticError cterm=NONE ctermbg=green
hi SyntasticWarning cterm=NONE ctermbg=green

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
noremap <C-C> <Esc>:noh<CR><Esc>
let mapleader=' '
let g:EasyMotion_leader_key='<Leader>' 
nnoremap ,f :FormatCode<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""
" => Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
function! Compile()
    execute 'w'
    if (&filetype == 'cpp' || &filetype == 'cc')
        execute '!time g++ % -o %:t:r -Wall -Wconversion -Wextra -Wshadow -O2 -DDEBUG --std=c++0x'
        return
    endif
    if (&filetype == 'c')
        execute '!time gcc % -o %:t:r -Wall -Wconversion -Wextra -Wshadow -O2 -DDEBUG --std=c99'
        return
    endif
    if (&filetype == 'rust')
        execute '!time rustc %'
        return
    endif
    if (&filetype == 'scala')
        execute '!time scalac %'
        return
    endif
    if (&filetype == 'tex')
        execute '!time pdflatex %'
        execute '!rm %:t:r.aux %:t:r.nav %:t:r.out %:t:r.snm %:t:r.toc %:t:r.log'
        return
    endif
    if (&filetype == 'haskell')
        execute '!time ghc % ; rm %:t:r.hi ; rm %:t:r.o'
        return
    endif
    echom 'Unable to compile! (unknown filetype [' . &filetype . '])'
endfunction

function! Run(arg)
    execute 'w'
    if (&filetype == 'c' || &filetype == 'cpp' || &filetype == 'cc' || &filetype == 'rust')
        execute '!./%:t:r' . a:arg
        return
    endif
    if (&filetype == 'scala')
        execute '!scala %:t:r' . a:arg
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
        execute '!bash %' . a:arg
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

"let g:syntastic_cpp_compiler_options=" -Wall -Wextra -Wconversion -std=c++0x"
"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
"Plugin 'scrooloose/syntastic'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
call vundle#end()
filetype plugin indent on
call glaive#Install()

Glaive codefmt clang_format_style='{IndentWidth: 4}'

"
"let g:ycm_global_ycm_extra_conf = '/Users/fqw/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
""let g:ycm_confirm_extra_conf = 0
""let g:syntastic_always_populate_loc_list = 1
""let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_register_as_syntastic_checker = 0
""set tags+=./.tags
