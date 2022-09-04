call plug#begin(stdpath('data') . '/plugged')

Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'mattn/emmet-vim'
Plug 'itchyny/lightline.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'justinmk/vim-sneak'
Plug 'qpkorr/vim-renamer'

" Initialize plugin system
call plug#end()

" Install coc extensions
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-angular', 'coc-eslint', 'coc-prettier', 'coc-css', 'coc-vetur' ]

" If on windows, always use cmd.exe even if nvim was opened in bash (like in Git Bash)
if has('win32') || has('win64')
    let &shell='cmd.exe'
endif

let mapleader = ','

" Theme
set background=dark 
colorscheme gruvbox

" Filename at the bottom
set laststatus=2
set statusline+=%{coc#status()}

" TextEdit might fail if hidden is not set.
set hidden

" highlight current cursor line
set cursorline

filetype plugin indent on
set autoindent

" auto reload file when it changes
set autoread
au CursorHold * checktime 

set timeoutlen=300
set updatetime=200

set nobackup
set nowritebackup

" more natural split opening
set splitbelow
set splitright

" exclude node_modules from search
set path+=**                                                                    
set wildignore+=**/node_modules/** 

" Give more space for displaying messages.
set cmdheight=2

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

set termguicolors
set background=dark

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

" Center cursor vertically when eg. searching
set so=10
set number relativenumber

" include '-' in what vim sees as 1 word
" setlocal iskeyword+=-

" https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode
set backspace=indent,eol,start

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enabled smart search in ripgrep.
" With smart case turned on, if you do a search using all lowercase letters, ripgrep will do a case insensitive search. 
" If you use any capital letters, it assumes that you want that specific query and will keep it case sensitive.
let g:rg_command = 'rg --vimgrep -S'

" In :Explore if you'd like to have relative numbering instead, try >
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"

" Trigger emmet when pressing leader key
let g:user_emmet_leader_key=','

" Error status line icon
let g:coc_status_error_sign = '❌ '
let g:coc_status_warning_sign = '⚠ '

" Change cursor when in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Set up :Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>p :Prettier<CR>

" Open vertical Git
nmap <leader>gg :vertical G<CR>

" Set up support for scss
autocmd FileType scss setl iskeyword+=@-@,-

" Organize imports
command! -nargs=0 OI :CocCommand editor.action.organizeImport

" prev tab
nnoremap H gT
" next tab
nnoremap L gt

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]g <Plug>(coc-diagnostic-next-error)
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references-used)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>as v<Plug>(coc-codeaction-selected)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Scroll in float window or popup
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
	execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
	call CocActionAsync('doHover')
  else
	execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <C-p> :GFiles<CR>

" Edit vimr configuration file
nnoremap confe :e $MYVIMRC<CR>
" Reload vims configuration file
nnoremap confr :source $MYVIMRC<CR>

" Rename in the current file's parent folder
nnoremap <leader>r :execute "Ren " . expand('%:p:h')<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ********* macbook remaps ***********
" <M- means command key
" Cycle between last 2 buffers 
nnoremap <M-z> <C-^>
" Visual block mode
nnoremap <M-b> <C-v>

" Clearing search highlight
nnoremap <silent> <esc> :noh<cr><esc>

let g:lightline = {
	  \ 'colorscheme': 'wombat',
	  \ 'active': {
		\   'left': [ [ 'mode', 'paste' ],
		\             [ 'gitbranch', 'readonly', 'filename', 'cocstatus', 'modified' ] ]
		\ },
        \ 'component': {
        \   'filename': '%n:%t'
        \  },
		\ 'component_function': {
		\   'cocstatus': 'coc#status',
		\   'gitbranch': 'FugitiveHead',
		\ },
		\ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

