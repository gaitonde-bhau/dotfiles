"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader commands                                                                                                   {{{1
"""""""""""""""""""

""" S
nnoremap <silent> <leader>so :so $MYVIMRC<BAR>so $MYGVIMRC<CR>
nnoremap <leader>sr :reg<CR>
nnoremap <leader>sm :marks<CR>
" Set size
nnoremap <silent> <expr> <leader>sd ':set lines=' . (tabpagenr("$") == 1 ? '67' : '65') . ' columns=319<CR>'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GOTO commands                                                                                                     {{{1
"""""""""""""""""

execute 'nnoremap <silent> govv :e ' . g:dotvim . '/vimrc<CR>'
execute 'nnoremap <silent> govg :e ' . g:dotvim . '/gvimrc<CR>'
execute 'nnoremap <silent> govf :e ' . g:dotvim . '/autoload/my.vim<CR>'
execute 'nnoremap <silent> govm :e ' . g:dotvim . '/plugin/mappings.vim<CR>'
execute 'nnoremap <silent> govb :e ' . g:dotvim . '/bundle.vim<CR>'

nnoremap <silent> gosa :e ~/.dotfiles/aliases<CR>
nnoremap <silent> gosf :e ~/.dotfiles/bash/bashrc-func<CR>
nnoremap <silent> gosp :e ~/.dotfiles/bash/bashrc-prompt<CR>
nnoremap <silent> gosc :e ~/.bashrc<CR>
nnoremap <silent> gost :e ~/.dotfiles/tmux/tmux.conf<CR>
nnoremap <silent> gosw :e ~/.dotfiles/aliases-work<CR>
nnoremap <silent> gosx :e ~/.Xresources<CR>
nnoremap <silent> gosi :e ~/.config/i3/config<CR>
nnoremap <silent> gon  :e ~/Notes<CR>

""" Redirect F1 to list of all commands which is more useful than the default help page
noremap <F1> :vert bo h index<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Re-mapping for convenience                                                                                        {{{1
""""""""""""""""""""""""""""""

""" Netrw
"nnoremap - :Ex<CR>
"autocmd FileType netrw nnoremap qq :Rex<CR>

""" Remap w to behave as 'w' should in all cases (:h cw). Use ce to do what 'cw' used to
onoremap <silent> <expr> w (v:count > 1 ? ":normal! " . v:count . "w<CR>" : ":normal! w<CR>")
onoremap <silent> <expr> W (v:count > 1 ? ":normal! " . v:count . "W<CR>" : ":normal! W<CR>")

""" Save read-only files with sudo
command! W w !sudo tee % > /dev/null

""" Show full file path while opening file
cabbrev %% <C-R>=fnameescape( expand( '%:p' ))<CR>
nnoremap <leader>s% :source <C-R>=fnameescape( expand( '%:p' ))<CR><CR>
cabbrev <expr> E (( getcmdtype() == ':' && getcmdpos() <= 2 ) ? 'e <C-R>=fnameescape( expand( "%:p:h" ))."/"<CR><C-R>=my#EatChar("\\s")<CR>' : 'E' )

""" Display full path and filename
nnoremap <C-G> 2<C-G>

""" Copy the file name to unix visual select buffer
nnoremap <expr> y<C-G> ':let @' . (has('win_32') ? '+' : '*') . '="' . expand("%:p") . '"<CR>'

""" Open help in a vertically split window. Use `:set splitright` to open on the right
cabbrev <expr> h (( getcmdtype() == ':' && getcmdpos() <= 2 ) ? 'vert bo h' : 'h' )

""" Persistent paste in visual mode
" By default, p/P in visual mode pastes the contents of the default register and replaces it with the visual selection.
" This will preserve the original contents of the default register. For the default behavior, P can be used
" For named registers, it will behave like default
xnoremap <expr> p v:register=='"'?'pgvy':'p'

""" Jumping to next/previous start/end of Methods
noremap <silent> ][ :call my#SectionJump('next', 'start')<CR>
noremap <silent> ]] :call my#SectionJump('next', 'end'  )<CR>
noremap <silent> [[ :call my#SectionJump('prev', 'start')<CR>
noremap <silent> [] :call my#SectionJump('prev', 'end'  )<CR>

noremap <silent> ]m :call my#MethodJump(']m')<CR>
noremap <silent> ]M :call my#MethodJump(']M')<CR>
noremap <silent> [m :call my#MethodJump('[m')<CR>
noremap <silent> [M :call my#MethodJump('[M')<CR>

""" Make Y consistent with C and D
nnoremap Y y$

""" Split line (sister to [J]oin lines)
nnoremap S i<CR><ESC>:call my#Preserve('-1s/\s\+$//')<CR>

""" Break undo-sequence before deleting till start of line
inoremap <C-U> <C-G>u<C-U>

""" Remap ZQ to quit everything. I can always use :bd to delete a single buffer
nnoremap ZQ :qall!<CR>

""" Make the repeat operator accept a count (repeat.vim does this too)
" nnoremap . :<C-U>execute 'normal! ' . repeat('.', v:count1)<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation and styling                                                                                           {{{1
"""""""""""""""""""""""""""

""" Tab
""" Preserve visual block after indenting
vnoremap > >gv
vnoremap < <gv

""" Briefly show CursorLine and CursorColumn
nnoremap <silent> <F5> :call my#CursorBlind()<cr>

""" Panic Mode (rot13)
nnoremap <silent> <F9> :call my#Preserve('normal! ggg?G')<CR>

""" Change font-size, line-spacing, window-size (May be set by vim-submode, hence the maparg() check)
nnoremap <silent> >l  :<C-U>execute 'let &lines     += ' . v:count1<CR>
nnoremap <silent> <l  :<C-U>execute 'let &lines     -= ' . v:count1<CR>
nnoremap <silent> >c  :<C-U>execute 'let &columns   += ' . v:count1<CR>
nnoremap <silent> <c  :<C-U>execute 'let &columns   -= ' . v:count1<CR>
nnoremap <silent> >s  :<C-U>execute 'let &linespace += ' . v:count1<CR>
nnoremap <silent> <s  :<C-U>execute 'let &linespace  = ' . (&linespace - v:count1)<CR>
nnoremap <silent> >f  :<C-U>IncFontSize<CR>
nnoremap <silent> <f  :<C-U>DecFontSize<CR>
" Note: This overrides the default functionality of =fx. However, the same thing can be done by =_ or ==
nnoremap =f :set guifont=*<CR>

""" Fill Text Width
nnoremap <silent> <leader>fw :FTW<CR>

""" Toggle ColorColumn
nnoremap <silent> <expr> cok ':set colorcolumn=' . (&colorcolumn=='0' ? '+1' : 0) . '<CR>'



"
" Navigation                                                                                                        {{{1
"

" % jumps from if-else-end while g% reverse jumps
nmap <A-%> g%

""" cscope mappings
" The following maps all invoke one of the following cscope search types:
"   'y'   symbol:   find all references to the token under cursor
"   'g'   global:   find global definition(s) of the token under cursor
"   'c'   calls:    find all calls to the function name under cursor
"   't'   text:     find all instances of the text under cursor
"   'e'   egrep:    egrep search for the word under cursor
"   'f'   file:     open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called:   find functions that function under cursor calls
nnoremap <silent>  <C-\> :call my#CscopeMap('l', 1)<CR>
nnoremap <silent> g<C-\> :call my#CscopeMap('l', 0)<CR>

""" Move by visual lines
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
noremap gj j
noremap gk k

nnoremap gm :call cursor(0, virtcol('$')/2)<CR>

"imap <C-Left>  <C-O>B
"imap <C-Right> <C-O>W

""" View/scrolling
nnoremap zh    3zh
nnoremap zl    3zl
nnoremap <C-E> 3<C-E>
nnoremap <C-Y> 3<C-Y>

" Toggle the cursor line to be fixed in the middle of the screen
nnoremap <silent> <leader>zz :let &scrolloff=999-&scrolloff<CR>

nnoremap <expr> <CR> foldlevel('.') ? 'za' : '<CR>'

""" Cycle between absolute/relative numbering
noremap <silent> <F2> :call my#CycleNumbering()<CR>

" Visually select the text that was last edited/pasted
nnoremap gV `[v`]



"
" Buffers, Windows, Tabs                                                                                            {{{1
"

""" Buffers
"nnoremap gb :<C-U>exec (v:count ? 'b '.v:count : 'bn')<cr>
nnoremap <S-Del>  :bd<CR>
nnoremap <S-BS>   :bp<BAR>bd#<CR>
"nnoremap <Space>b :ls<CR>:b<Space>


""" Windows
" Swap Windows
nnoremap <silent> <C-W><C-X> :call my#WindowSwap()<CR>

" Force close and re-split
nnoremap <silent> <C-W><S-V> <C-W><C-O><C-W><C-V>
nnoremap <silent> <C-W><S-S> <C-W><C-O><C-W><C-S>

" Close windows above/below/to the left/right of the current one
nnoremap <silent> <C-W><S-C>h <C-W><C-H><C-W>c
nnoremap <silent> <C-W><S-C>j <C-W><C-J><C-W>c
nnoremap <silent> <C-W><S-C>k <C-W><C-K><C-W>c
nnoremap <silent> <C-W><S-C>l <C-W><C-L><C-W>c

" Toggle Zoom
nnoremap + :<C-U>call my#WindowToggleZoom()<CR>


""" Tab operations
if v:version >= 700
  " Open file in new tab next to current tab
  "nnoremap <silent> gt :let tabnum=tabpagenr()<CR><C-W>gf:execute 'silent! tabmove '.tabnum<CR>

  " Move to
  nnoremap <C-Home>  :tabfirst<CR>
  nnoremap <C-End>   :tablast<CR>
  "nnoremap <C-Tab>   :tabnext<CR>
  "nnoremap <C-S-Tab> :tabprev<CR>

  " Move current tab to first position
  nnoremap <C-S-Home> :tabmove 0<CR>
  " Move current tab to last position
  nnoremap <C-S-End> :tabmove<CR>
  " Move current tab to the left
  nnoremap <silent> <C-S-PageUp> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
  " Move current tab to the right
  nnoremap <silent> <C-S-PageDown> :execute 'silent! tabmove ' . tabpagenr()<CR>

  " Toggle between all buffers and all tabs
  nnoremap <silent> <expr> <F8> ( tabpagenr('$') == 1 ? ':tab ball<Bar>tabn' : ':tabo' ) . '<CR>'
endif


""" Command-line Window ( :h c_CTRL-F )
" Make Vim start in Insert mode in the command-line window.
"autocmd CmdwinEnter [/?] startinsert
" Make closing cmdline-window easier
autocmd CmdwinEnter * noremap <buffer> <ESC> <C-C><C-C>
" Persistent command-line window
autocmd CmdwinEnter * noremap <buffer> <S-CR> <CR>q:


""" To make traversing up the directory tree easier in cmd-mode
cnoremap <C-W> <C-R>=my#CmdIsk(1)<CR><C-W><C-R>=my#CmdIsk(0)<CR>


"
" Search and replace                                                                                                {{{1
"
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Mode   | Map        | Description                                                                             |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Normal | *    #     | Search word under cursor                                                                |
" |        | g*   g#    | Search whole-word under cursor                                                          |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Normal | <leader>*  | Set search pattern to word under cursor                                                 |
" |        | <leader>g* | Set search pattern to whole-word under cursor                                           |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Normal | <leader>/  | Display all lines in current buffer containing the search term in a location-list       |
" |        | <leader>g/ | Display all lines in all buffers containing the search term in a quickfix-list          |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Normal | g/         | Grep all files containing the search term and show results in a quickfix-list           |
" |        | K          | Grep all files containing the word under the cursor and show results in a quickfix-list |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Visual | /    ?     | Open search with visual selection but don't start searching                             |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Visual | *    #     | Start search with visual selection                                                      |
" |        | g*   g#    | Start searching whole-word with visual selection                                        |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Visual | &          | Open substitute with visual selection                                                   |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Visual | <leader>*  | Set visual selection as the search pattern                                              |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Visual | <leader>/  | Display all lines in current buffer containing the visual selection in a location-list  |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Visual | <leader>g/ | Display all lines in window containing the visual selection in a quickfix-list          |
" |--------+------------+-----------------------------------------------------------------------------------------|
" | Visual | g/         | Grep all files containing the visual selection and show results in a quickfix-list      |
" |--------+------------+-----------------------------------------------------------------------------------------|

""" Use very-magic while searching (Perl-style regex)
nnoremap / /\v
nnoremap ? ?\v
cnoremap %s/ %s/\v
cnoremap .s/ .s/\v
xnoremap :s/ :s/\%V\v

""" Search with visual selection
vnoremap *  <ESC>/\<<C-R>=escape( @*, '$*[]\/' )<CR>\>
vnoremap g* <ESC>/<C-R>=escape( @*, '$*[]\/' )<CR>
vnoremap #  <ESC>?\<<C-R>=escape( @*, '$*[]\/' )<CR>\>
vnoremap g# <ESC>?<C-R>=escape( @*, '$*[]\/' )<CR>

""" Start substitute with visual selection
" This escape function is meant for use with normal substitution
vnoremap & <ESC>:%s/<C-R>=escape( @*, '$*[]\\|\/' )<CR>/
" This escape function is meant only for use with verymagic substitution
"vnoremap & <ESC>:%s/\v<C-R>=escape( @*, '$%^*=+<>()[]{}&/' )<CR>/

""" Set search pattern without moving the cursor
nnoremap <silent> <leader>*  :let @/='\<'.escape(expand('<cword>'),'$*[]/').'\>'<CR>
nnoremap <silent> <leader>g* :let @/=escape(expand('<cword>'),'$*[]/')<CR>
vnoremap <silent> <leader>*  :<C-U>let @/='\<'.escape(@*,'$*[]/').'\>'<CR>
vnoremap <silent> <leader>g* :<C-U>let @/=escape(@*,'$*[]/')<CR>

""" Find and show results in a LocationList (Buffer-specific)
nnoremap <silent> <leader>/ :call my#FindAndList('local', 'normal')<CR>
vnoremap <silent> <leader>/ :<C-U>call my#FindAndList('local', 'visual')<CR>

""" Find and show results in a QuickfixList
nnoremap <silent> <leader>g/ :call my#FindAndList('global', 'normal')<CR>
vnoremap <silent> <leader>g/ :<C-U>call my#FindAndList('global', 'visual')<CR>

""" Grep
command! -nargs=+ -complete=file -bar Grep silent grep! <args>|cwindow 20|redraw!
nnoremap g/ :Grep<Space>
nnoremap K  :Grep <C-R><C-W><CR>

""" Keep searches in middle of screen
nnoremap <silent> n :call my#SearchSaveAndRestore()<CR>/<CR>zvzz
nnoremap <silent> N :call my#SearchSaveAndRestore()<CR>?<CR>zvzz

""" Jump to corresponding <Tag> (AMD)
nmap <leader>< va><ESC>:<C-U>/<C-R>*<CR>

""" Clear search string itself ( Save before clearing )
nnoremap <silent> <C-L> :call my#SearchSaveAndRestore()<Bar>let @/=""<CR><C-L>
"nnoremap <S-F5> :set hlsearch!<CR>:set hlsearch?<cr>   " Use coh from Unimpaired

""" Remove trailing whitespace
nnoremap <silent> <leader>s<Space> :call my#Preserve('%s/\v\s+$//')<CR>

""" Replace word under the cursor. Type replacement, press <ESC>. Use . to jump to next occurence of the word and repeat
""" Works only on recent patches, > 7xx
nnoremap c*  *<C-O>cgn
nnoremap cg* g*<C-O>cgn



"
" Misc                                                                                                              {{{1
"

""" Show help on the word below cursor (Note: :h has be remapped to 'vert bo h')
nnoremap <silent> <S-F1> :h <C-R><C-W><CR>
imap     <S-F1> <C-\><C-O><S-F1>

""" Ctrl+S functionality for save
nnoremap <silent> <C-S> :execute ':silent :wall!'<CR>
imap     <silent> <C-S> <C-\><C-O><C-S>

""" Fullscreen
nnoremap <silent> <F11> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

""" Copy-paste to system register
nnoremap <silent> <A-y> "+y
vnoremap <silent> <A-y> "+y
nnoremap <silent> <A-p> "+p

""" Deleting to black hole register
nnoremap <silent> <A-d> "_d
vnoremap <silent> <A-d> "_d

""" Generate ctags
nnoremap <F12> :call my#UpdateTags()<CR>

""" Execute selection as vimscript
vnoremap g: <Esc>:@*<CR>
