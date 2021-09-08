call plug#begin('~/.config/nvim/plugged')

" UI
Plug 'iCyMind/NeoSolarized'
Plug 'jacoborus/tender.vim'
Plug 'Yggdroot/indentLine'

" Navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter' " comment code
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'mhinz/vim-startify'

" Seaching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Statusline
Plug 'itchyny/lightline.vim'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" JS support
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown',  'yaml', 'html'] }
Plug 'dense-analysis/ale'
Plug 'ap/vim-css-color'
Plug 'galooshi/vim-import-js'

" Ruby support
Plug 'vim-ruby/vim-ruby'

" Git support
Plug 'tpope/vim-fugitive'

" Flutter support
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

" Test support
Plug 'phthhieu/vim-test'
Plug 'benmills/vimux'

" Others
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'ntpeters/vim-better-whitespace'

" ReasonML
Plug 'reasonml-editor/vim-reason-plus'

call plug#end()

set ruler
set number
set hlsearch
set incsearch
set splitright
set splitbelow
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set cursorline
set clipboard+=unnamedplus
set hidden
set ignorecase
set smartcase
set relativenumber
set lazyredraw
set scrolloff=10
set background=dark
set mouse=a
set completeopt-=preview
set smarttab
set noswapfile
colorscheme NeoSolarized
set termguicolors

let $MYVIMRC = '$HOME/.config/nvim/init.vim'
let mapleader = ','

inoremap jj <Esc>
nnoremap <Space> :
nnoremap \ ,
nnoremap Y y$

" Config NERDTree
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1
let g:NERDTreeSyntaxEnabledExtensions = ['rb', 'js', 'html', 'haml', 'css', 'erb', 'jsx', 'scss', 'ts', 'json']
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeHighlightCursorline = 0
let NERDTreeShowHidden = 1

" Start NERDTree. If a file is specified, move the cursor to its window.
" Toggle NERDTree
let NERDTreeShowHidden = 1
function! OpenNerdTree()
  if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction

nnoremap <silent> <leader>n :call OpenNerdTree()<CR>
nnoremap <silent> <leader>N :NERDTreeToggle<CR>

" Commenter configs
let g:NERDCompactSexyComs = 1
let g:NERDSpaceDelims = 1


let $FZF_DEFAULT_COMMAND = 'rg --files  --hidden --follow --glob "!{.git, node_modules}"'
" FZF configs
nnoremap <leader>a :Ag<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <silent> <leader>ag :Ag <C-R><C-W><CR>


" Config Prettier
autocmd BufWritePre * StripWhitespace
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.yaml,*.html Prettier


" Ale configs
let g:ale_linters = {'javascript': ['eslint', 'flow'], 'ruby': ['rubocop']}
let g:ale_fixers = {'javascript': ['eslint', 'prettier', 'importjs'], 'ruby': ['rubocop']}


" EasyMotion configs
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)


" Test support config
let test#strategy = "vimux"
let g:test#javascript#jest#executable = 'yarn test'
let g:VimuxUseNearest = 0
let g:VimuxOrientation = "v"
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>
map <Leader>vi :VimuxInspectRunner<CR>
nmap <leader>t :TestNearest<CR>
nmap <leader>T :TestFile<CR>


" Edit and source configs
nnoremap <silent> <leader>i :ImportJSFix<CR>
nnoremap <silent>ss :w<CR>
nnoremap <silent> <leader>s :w!<CR>
nnoremap <silent>qq :q<CR>
nnoremap <silent> <leader>q :q!<CR>
nnoremap <silent> <leader>b o<ESC>


" Tmux navigation
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>


" Screen config
nnoremap <silent> <leader>l :nohlsearch<CR>
noremap <leader>v :vsplit<cr>
noremap <leader>h :split<cr>


" Copy current file / folder path
nnoremap cp :let @* = expand("%")<CR>
nnoremap cP :let @* = expand("%:p")<CR>


" Git config
noremap <leader>gu :Gpull<cr>
noremap <leader>gp :Gpush<cr>
noremap <leader>gb :Gblame<cr>


" Import JS config
nmap <leader>i :ImportJSFix<cr>

" Dart config
let g:dart_format_on_save = 1


" ==== START COC config
"" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" set nowritebackup
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
command! -nargs=0 Format :call CocAction('format')

let g:coc_global_extensions = [
\ 'coc-tsserver',
\ 'coc-snippets'
\ ]
" === END COC


" Disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
