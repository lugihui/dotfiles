set nocompatible
set t_Co=16 " Anzahl Farben des Terminals angeben

" Einbinden der Plugins in ~/.vim/bundle mit Pathogen
execute pathogen#infect()

" Einbinden der Lilypond-spezifischen Files:
filetype off
set runtimepath+=/home/dl/lilypond/usr/share/lilypond/current/vim
filetype plugin indent on
syntax on

" Einbinden der Abkürzungen
source ~/.vim/abbrev.vim

" Leertaste anstatt backlash als leader...
let mapleader = " "

" Kursive Schrift in Tmux
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

" Optionen für Plugin ~/.vim/bundle/vim-colors-solarized
set background=dark " dark | light "
let g:solarized_termtrans = 1
colorscheme solarized
call togglebg#map("<F5>")

" Kopfzeile im File-Browser ausblenden
let g:netrw_banner = 0

" Titel des Files auch bei nur einem Fenster anzeigen:
set laststatus=2

" Nummern, Umbruch und Cursor
set relativenumber " zeigt relative statt effektive Nummern
set number " zeigt effektive Nummer der aktuellen Zeile
set lbr
set textwidth=74
set cursorline
set colorcolumn=+1

" Matches bei Suchen laufend markieren
set incsearch

"Tabstops
set tabstop=2 " Tabstops nur 2 Zeichen lang zeigen (default: 8)
set shiftwidth=2 " Standard für Indents (default: 8)
set expandtab " Leerzeichen statt Tabstops einfügen, kann mühsam sein...

" Leerzeichen etc. anzeigen, nbsp=non-breakable space character
set listchars=tab:-->,nbsp:°,trail:·
set list

" Buffer
set splitbelow " Splits unter aktuellem Buffer (default: oberhalb)
set splitright " Vertikale Splits rechs (defalt: links)

" Spezifische Styles
let g:tex_flavor='latex'
let g:markdown_folding=1 "aktiviert Faltung bei Markdown

" Rechtschreibeprüfung, mit <F7> ein- und und mit <F8> ausschalten
setlocal spell spelllang=de_ch
map <F8> :setlocal nospell! <return>
map <F7> :setlocal spell spelllang=de_ch <return>

" Darstellung Rechtschreibefehler
hi clear SpellBad
hi SpellBad cterm=underline

" Methode zum verschlüsseln von Text
set cm=blowfish2

"Einbinden der Plugins in ~/.vim/plugged mit vim-plug
call plug#begin()
" Für Distraction free vim:
Plug 'junegunn/goyo.vim'
" Für farbige Darstellung von csv-Files etc.:
Plug 'mechatroner/rainbow_csv'
call plug#end()

" Mappings
inoremap kj <Esc>
nnoremap H 0
vnoremap H 0
onoremap H 0
nnoremap L $
vnoremap L $
onoremap L $
nnoremap / /\v
nnoremap ? ?\v
nnoremap <leader>l <C-W>l
nnoremap <leader>k <C-W>k
nnoremap <leader>j <C-W>j
nnoremap <leader>h <C-W>h
nnoremap <leader><space> za
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Mappings für vmath-Plugin
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

" LaTex Commands - Gruppe verhindert Duplikate beim Sourcen des vimrc
augroup filetype_tex
  autocmd!
  autocmd FileType tex inoremap ;fn \footnote{} <++><Esc>T{i
  autocmd FileType tex inoremap ;fc \footcite{} <++><Esc>T{i
  autocmd FileType tex inoremap ;fcp \footcite[]{<++>} <++><Esc>T[i
  autocmd FileType tex inoremap ;enq \enquote{} <++><Esc>T{i
  autocmd FileType tex inoremap ;sing \enquote*{} <++><Esc>T{i
  autocmd FileType tex inoremap ;em \emph{} <++><Esc>T{i
  autocmd FileType tex inoremap ;bf \bfseries{} <++><Esc>T{i
  autocmd FileType tex vnoremap enq <Esc>`>a}<Esc>`<i\enquote{<Esc>
  autocmd FileType tex vnoremap sing <Esc>`>a}<Esc>`<i\enquote*{<Esc>
  autocmd FileType tex vnoremap em <Esc>`>a}<Esc>`<i\emph{<Esc>
  autocmd FileType tex vnoremap bf <Esc>`>a}<Esc>`<i\textbf{<Esc>
augroup END

" Markdown Commands
augroup filetype_md
  autocmd!
  autocmd FileType markdown inoremap ;fn ^[] <++><Esc>T[i
  autocmd FileType markdown inoremap ;fc ^[@] <++><Esc>T@i
  autocmd FileType markdown inoremap ;com <!--  --> <++><Esc>T!lla
  autocmd FileType markdown inoremap ;em ** <++><Esc>T*hi
  autocmd FileType markdown inoremap ;bf **** <++><Esc>T*hhi
  autocmd FileType markdown inoremap ;img ![](<++>)<Esc>T[i
  autocmd FileType markdown vnoremap com <Esc>`>a--><Esc>`<i<!--<Esc>
  autocmd FileType markdown vnoremap em <Esc>`>a*<Esc>`<i*<Esc>
  autocmd FileType markdown vnoremap bf <Esc>`>a**<Esc>`<i**<Esc>
augroup END

" HTML Commands, optimiert für Reveal-Präsentationen
augroup filetype_html
  autocmd!
  autocmd FileType html setlocal textwidth=0
  autocmd FileType html inoremap ;h1 <h1></h1><Esc>T<hi
  autocmd FileType html inoremap ;h2 <h2></h2><Esc>T<hi
  autocmd FileType html inoremap ;h3 <h3></h3><Esc>T<hi
  autocmd FileType html inoremap ;h4 <h4></h4><Esc>T<hi
  autocmd FileType html inoremap ;h5 <h5></h5><Esc>T<hi
  autocmd FileType html inoremap ;p <p></p><Esc>T<hi
  autocmd FileType html inoremap ;div <div><cr></div><Esc>O
  autocmd FileType html inoremap ;ul <ul><cr></ul><Esc>O
  autocmd FileType html inoremap ;ol <ol><cr></ol><Esc>O
  autocmd FileType html inoremap ;li <li><p></p></li><Esc>Tphhhi
  autocmd FileType html inoremap ;lif <li class="fragment"><p></p></li><Esc>Tphhhi
  autocmd FileType html inoremap ;sec <section><cr></section><Esc>O<h2></h2><Esc>T<hi
  autocmd FileType html inoremap ;note <aside class="notes"><cr></aside><Esc>O
  autocmd FileType html inoremap ;fig <figure class=""><cr></figure><Esc>O<img data-src="<++>"/><cr><figcaption><++></figcaption><Esc>2kT"hi
  autocmd FileType html inoremap ;back data-background=""<Esc>i
  autocmd FileType html vnoremap com <Esc>`>a--><Esc>`<i<!--<Esc>
augroup END

" Python Commands
augroup filetype_python
  autocmd!
  autocmd FileType python setlocal textwidth=0
  autocmd FileType python setlocal nospell
augroup END
