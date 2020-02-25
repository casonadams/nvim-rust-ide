" Installs Plug Plugin Manager

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'w0rp/ale'
  Plug 'racer-rust/vim-racer'
  Plug 'rust-lang/rust.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'ervandew/supertab'
  Plug 'majutsushi/tagbar'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  Plug 'morhetz/gruvbox'
  Plug 'kien/ctrlp.vim'
  Plug 'junegunn/vim-easy-align'
call plug#end()

let mapleader = "\<Space>" 

" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

syntax on
set hidden
set title
set number
set mouse=a
set background=dark
set noswapfile
set cursorline
set wrap
set completeopt=longest,menuone
set list
set listchars=tab:»·,trail:·
colorscheme gruvbox

" Racer
let g:racer_cmd = '$HOME/.cargo/bin/racer'
let g:racer_experimental_completer = 1
au FileType rust nmap <leader>rx <Plug>(rust-doc)
au FileType rust nmap <leader>rd <Plug>(rust-def)
au FileType rust nmap <leader>rs <Plug>(rust-def-split)

let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_extensions = ['branch', 'tabline']
let g:airline_powerline_fonts = 1

nmap = :bn<CR>
nmap - :bp<CR>

nmap <silent> <F3> :NERDTreeToggle<CR>
nmap <silent> <F2> :TagbarToggle<CR>

function! UpdateCtags()
    silent call system("ctags -R -f ./tags .")
endfunction

nmap <silent> <F1> :call UpdateCtags()<CR>

let g:SuperTabDefaultCompletionType = "<c-n>"

let g:ale_fixers = {
      \   'rust': ['rustfmt'],
      \}

let g:ale_linters = {
      \'rust': ['rls'],
      \}

let g:ale_rust_rls_toolchain = 'stable'

let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {'rust': ['ale', 'racer']}


" ToggleComment
let s:comment_map = { 
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "lua": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "python": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " " 
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else 
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction

nnoremap <silent> <leader>/ :call ToggleComment()<cr>
vnoremap <silent> <leader>/ :call ToggleComment()<cr>
" end ToggleComment
