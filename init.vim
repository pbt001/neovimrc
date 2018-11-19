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
Plug 'rafi/awesome-vim-colorschemes'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/taglist.vim'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'unblevable/quick-scope' 

call plug#end()

syntax on
set nu
set autowrite
set smartindent
set cindent
set autoindent
set nobackup
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set expandtab
set nowrap
set nohlsearch

colorscheme angr

" Quick navigate to config file
nnoremap <F11> :w<CR>:e$MYVIMRC<CR>

" Quick navigate to cur terminal path
tnoremap <F9> pwd\|xclip -selection clipboard<CR><C-\><C-n><C-w><C-w>:cd <C-r>+<CR>

" Close terminal
tnoremap <C-w><C-q> <C-\><C-n>:close<CR>

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

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" ctaglist
map ,m :TlistToggle<CR>

" Ctags
nnoremap <Leader>, :!ctags -R *<CR>

" NERDTree
map <C-n> :NERDTreeFind<CR>
map ,n :NERDTreeToggle<CR>

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
nmap <Leader><Leader> <Plug>(easymotion-s2)

" Ultisnips
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsEditSplit="vertical"

" Jedi
autocmd FileType python setlocal completeopt-=preview
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<F4>"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>g"
let g:jedi#completions_command = "<C-space>"
let g:jedi#rename_command = "<leader>r"

" Customize shortcut
:noremap <F8> :set hlsearch! hlsearch?<CR>
imap << </
imap JJ <down>
imap KK <up>
imap HH <Esc>bi
imap LL <Esc>ea
imap LOREM <Esc>o<Esc>:Loremipsum<CR>o
imap OREM <Esc>o<Esc>:Loremipsum!<CR>o
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <up> gT
nnoremap <down> gt
nnoremap ZX :bd<CR>
nnoremap == mpgg=G`p
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap viw viwp

" borrow from ram535
" With this function you can reuse the same terminal in neovim.
" You can toggle the terminal and also send a command to the same terminal.

let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1

function! MonkeyTerminalOpen()
    " Check if buffer exists, if not create a window and a buffer
    if !bufexists(s:monkey_terminal_buffer)
        " Creates a window call monkey_terminal
        new monkey_terminal
        " Moves to the window the right the current one
        wincmd L
        let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })

        " Change the name of the buffer to "Terminal 1"
        silent file Terminal\ 1
        " Gets the id of the terminal window
        let s:monkey_terminal_window = win_getid()
        let s:monkey_terminal_buffer = bufnr('%')

        " The buffer of the terminal won't appear in the list of the buffers
        " when calling :buffers command
        set nobuflisted
    else
        if !win_gotoid(s:monkey_terminal_window)
            sp
            " Moves to the window below the current one
            wincmd L
            buffer Terminal\ 1
            " Gets the id of the terminal window
            let s:monkey_terminal_window = win_getid()
        endif
    endif
endfunction

function! MonkeyTerminalToggle()
    if win_gotoid(s:monkey_terminal_window)
        call MonkeyTerminalClose()
    else
        call MonkeyTerminalOpen()
    endif
endfunction

function! MonkeyTerminalClose()
    if win_gotoid(s:monkey_terminal_window)
        " close the current window
        hide
    endif
endfunction

function! MonkeyTerminalExec(cmd)
    if !win_gotoid(s:monkey_terminal_window)
        call MonkeyTerminalOpen()
    endif

    " clear current input
    call jobsend(s:monkey_terminal_job_id, "clear\n")

    " run cmd
    call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
    normal! G
    wincmd p
endfunction

" With this maps you can now toggle the terminal
nnoremap <F7> :call MonkeyTerminalToggle()<cr>
tnoremap <F7> <C-\><C-n>:call MonkeyTerminalToggle()<cr>

" This an example on how specify command with different types of files.
augroup go
    autocmd!
    autocmd BufRead,BufNewFile *.go set filetype=go
    autocmd FileType go nnoremap <F5> :call MonkeyTerminalExec('go run ' . expand('%'))<cr>
augroup END
