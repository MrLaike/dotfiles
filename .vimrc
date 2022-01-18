"  ______                   
" (____  \                  
"  ____)  )_____  ___ _____ 
" |  __  ((____ |/___) ___ |
" | |__)  ) ___ |___ | ____|
" |______/\_____(___/|_____)
"                           
set nocompatible

filetype on
filetype plugin on
filetype indent on
"syntax on 

" Сетим тему
syntax enable
syntax enable
set background=dark
"let g:airline_theme='one'
"colorscheme one
"colorscheme solarize


" Отображать цифры
set number

set cursorline

" 1 таб 4 пробела
set shiftwidth=4
" 1 таб 4 пробела
set tabstop=4
" Не сохроняем back'ап файл
set nobackup

" Непереносить строки
set nowrap

set incsearch
" Игнорируем заглавные буквы при поиске
set ignorecase


" История изменений
set history=2000

" Автодополнение для меню 
set wildmenu

" Игнорировать файлы со следующими расширениями
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx




"  ______  _              _            
" (_____ \| |            (_)           
"  _____) ) | _   _  ____ _ ____   ___ 
" |  ____/| || | | |/ _  | |  _ \ /___)
" | |     | || |_| ( (_| | | | | |___ |
" |_|      \_)____/ \___ |_|_| |_(___/ 
"                  (_____|             


call plug#begin('~/.vim/plugged')

Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'terryma/vim-multiple-cursors'
Plug 'rakr/vim-one'
Plug 'edkolev/tmuxline.vim'
Plug 'ap/vim-css-color'

call plug#end()


"  _     _             _     _           _      
" (_)   | |           | |   (_)         | |     
"  _____| |_____ _   _| |__  _ ____   __| | ___ 
" |  _   _) ___ | | | |  _ \| |  _ \ / _  |/___)
" | |  \ \| ____| |_| | |_) ) | | | ( (_| |___ |
" |_|   \_)_____)\__  |____/|_|_| |_|\____(___/ 
"               (____/                          

" Копируем выделенную строку в буфер
vmap <C-c> :<c-u>silent '<,'>w !xclip -selection clipboard<cr>
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
