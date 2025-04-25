" Install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===========
" | Plugins |
" ===========
call plug#begin()
" Fuzzy search
" Enable 'Ag' command: 'sudo apt-get install siversearch'
" Enable 'Rg' command: 'snap install ripgrep'
" Install fd-find: cargo install fd-find
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Linter
" Plug 'dense-analysis/ale'

" Syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'build': './install.sh'}

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rakr/vim-one'
Plug 'arzg/vim-colors-xcode'
Plug 'lifepillar/vim-solarized8'
Plug 'skbolton/embark'
"Plug 'arcticicestudio/nord-vim'
Plug 'nordtheme/vim'

" Display status
Plug 'bling/vim-airline'

" Airline theme for status bar
Plug 'vim-airline/vim-airline-themes'

" Display buffer number in command bar
Plug 'mihaifm/bufstop'

" Visually sees indent
" Plug 'Yggdroot/indentLine'

" Csv extension
Plug 'chrisbra/csv.vim'

" Git extension
Plug 'tpope/vim-fugitive'

" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

" Intellisense
" Need to install nodejs, npm (sudo apt install nodejs npm)
" Requires most recent version of nvim
" Run :checkhealth and check what's missing
" Then do the following:
" :CocInstall coc-pyright
" :CocInstall coc-json
" :CocInstall coc-tsserver
" :CocInstall coc-sh
" :CocInstall coc-lua
" :CocCommand<CR> then python.setInterpreter, then set python.enableLinting to False
" :CocConfig or :CocLocalConfig, place settings in JSON
" See https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file#configuration-file-resolve
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vim Wiki
Plug 'vimwiki/vimwiki'

" Vimspector (for debugging)
" Plug 'puremourning/vimspector'

" File explorer
Plug 'lambdalisue/fern.vim', {'branch': 'main'}

Plug 'liuchengxu/space-vim-theme'

Plug 'easymotion/vim-easymotion'

Plug 'github/copilot.vim'

call plug#end()


set nocompatible

filetype plugin indent on

syntax on

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
" inoremap <expr> <tab> InsertTabWrapper()
" inoremap <s-tab> <c-n>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic — @amix3k
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
" set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=0

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Show line numbers
set number

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
" set nobackup
" set nowb
" set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Be smart when using tabs ;)
set smarttab

" Use tabs 
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal expandtab

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quick job pause
map <leader>z <C-Z>
" Save and pause/quit
map <leader>ww :w<cr>
map <leader>wz :w<cr><C-Z>
map <leader>wq :wq<cr>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Map two spaces to switch to last buffer
map <space><space> :b#<cr>
" - Switch to specific buffer
map <leader><space> :b<space>
" Close buffer
map <leader>c :Bclose<cr>
" Quit vim
map <leader>q :q<cr>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows (splits/panes)
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Close the current buffer
map <leader>bc :Bclose<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>j :bprevious<cr>
"map <leader>l :bnext<cr>
map <leader>k :bnext<cr>
"map <leader>h :bprevious<cr>
" for splits again: add these similar to move buffer maps for a smoooth experience
map <leader>l <C-W>l
map <leader>h <C-W>h


" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
" map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
let g:coc_node_path = '/usr/local/bin/node'

" Airline theme

" remove last column of airline (bottom bar) with num. trailing spaces etc.
let g:airline_extensions=['tabline']
let g:airline#extensions#tabline#enabled = 1  " Show buffers in tabs
let g:airline_theme='deus'

" Coc Intellisense
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
let g:coc_disable_startup_warning = 1

nmap <leader>e :e 
nnoremap <leader>f :Fern . -drawer -width=25<CR>
" keep quickfix list (find results) open when selecting a file
" autocmd FileType qf nnoremap <buffer> <CR> <CR>:copen<CR>
"  search in files
nnoremap <leader>ss :vim  **/*.py<Left><Left><Left><Left><Left><Left><Left><Left>
" open quickfix list, ie. search results
nnoremap <leader>cc :copen<CR>
" cycle between search results
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>

" quick reload vimrc
nnoremap <leader>src :source $MYVIMRC<CR>
nnoremap <leader>erc :e $MYVIMRC<CR>

" fix option-b key. must add one entry for each combination
execute "set <M-b>=\<Esc>b"
" fix option-w key
execute "set <M-w>=\<Esc>w"

" jump one word in command mode
" cnoremap <M-b> <S-Left>
" above doesn't work. below does the same thing
cnoremap ∫ <S-Left>
cnoremap <C-I> <S-Left>
"cnoremap <M-w> <S-Right>
" above doesn't work. below does the same thing
cnoremap ∑ <S-Right>
cnoremap <C-O> <S-Right>

" For auto complete
" For vim: Ctrl Space, Ctrl `
" inoremap <NUL> <C-n>
" For nvim: Ctrl Space, Ctrl `
" inoremap <C-Space> <C-n>
" inoremap <C-n> <Nop>

" For fuzzy search
" nnoremap <C-p>. :FZF<Space>/opt/ff/<CR>
nnoremap <C-p> :FZF<Space>.<CR>
nnoremap ff :FZF<Space>

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <C-Space>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Copilot setup
" imap <silent><script><expr> <C-L> copilot#Accept("")
" let g:copilot_no_tab_map = v:true

" debugging statement in python
inoremap ffjj print("FARZAD++++++++++++++++++++++++++++++++++++++++++++++++")

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

cunmap <TAB>

" run :VimspectorInstall to install these gadgets
" let g:vimspector_install_gadgets = ['debugpy']


" vimspector mappings
" "d" stands for debugger
" step
" nmap <leader>ds <Plug>VimspectorStepInto
" nmap <leader>do <Plug>VimspectorStepOver
" nmap <leader>dc <Plug>VimspectorContinue
" nmap <leader>dp <Plug>VimspectorPause
" nmap <leader>dS <Plug>VimspectorStop
" nmap <leader>dC <Plug>VimspectorRunToCursor
" nmap <leader>dO <Plug>VimspectorStepOut	
" " for normal mode - the word under the cursor
" nmap <Leader>di <Plug>VimspectorBalloonEval
" " for visual mode, the visually selected text
" xmap <Leader>di <Plug>VimspectorBalloonEval
" 

" fix highlight color of selected lines in visual model
highlight Visual ctermbg=darkgrey guibg=#D3D3D3

set t_Co=256
try
    colorscheme space_vim_theme
catch
endtry

set background=dark

" colorscheme gruvbox
highlight CopilotSuggestion guifg=#7bbf30 ctermfg=114

