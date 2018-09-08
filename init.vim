call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-system-copy'
Plug 'vim-scripts/loremipsum'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-grepper'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'SirVer/ultisnips'


call plug#end()


syntax on
set nu
set autowrite
set smartindent
set cindent
set autoindent
set nobackup
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab
set expandtab
set nowrap
set nohlsearch

colorscheme angr

" Open terminal
nnoremap <C-t><C-t> :vsp<CR><C-w><C-w>40<C-w><:te<CR>a
nnoremap <C-t><C-r> :sp<CR><C-w><C-w>15<C-w>-:te<CR>a

" Close terminal
" tnoremap <C-w><C-q> <C-\><C-n>:close<CR>
" substitue by <C-d><C-d> which end the process

" Quick switch from terminal
tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>
tnoremap <C-w><C-e> <C-\><C-n>
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w>h <C-\><C-n><C-w>h

" Add new line above or below
nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" quick mark replacement
nnoremap <space><space> /<++><CR>:noh<CR>ca<

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" CtrlP
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'

" EasyMotion
let g:EasyMotion_do_mapping=0
let g:EasyMotion_smartcase=1
" Turn on case insensitive feature
let g:EasyMotion_smartcase=1
" JK motions: Line motions
let g:EasyMotion_startofline=1
nmap <Leader>s <Plug>(easymotion-s2)

" Grep search
nnoremap <Leader>g :Grepper -tool git -query 

" Ultisnips
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<Leader-j>"
let g:UltiSnipsJumpBackwardTrigger="<Leader-k>"
let g:UltiSnipsEditSplit="vertical"

" Ctags
nnoremap <Leader>, :!ctags -R .<CR>
nnoremap <leader>. :CtrlPTag<CR>

" Customize shortcut
:noremap <F4> :set hlsearch! hlsearch?<CR>

imap << </

imap HH <left>
imap JJ <down>
imap KK <up>
imap LL <right>
imap BB <Esc>bi
imap EE <Esc>ea

imap LOREM <Esc>o<Esc>:Loremipsum<CR>o
imap OREM <Esc>o<Esc>:Loremipsum!<CR>o

nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <up> gT
nnoremap <down> gt

nnoremap == mpggvG=`p

