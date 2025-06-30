"----------------------------------------
" Base設定
"----------------------------------------
" Vimモード
set nocompatible
" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'preservim/nerdtree'
  Plugin 'vim-ruby/vim-ruby'
  Plugin 'tpope/vim-rails.git'
  Plugin 'tpope/vim-endwise'
  Plugin 'slim-template/vim-slim.git'
  Plugin 'tyru/caw.vim.git'
  Plugin 'itchyny/lightline.vim'
  " Plugin 'Shougo/neocomplcache'
  Plugin 'ekalinin/Dockerfile.vim'
call vundle#end()
filetype plugin indent on

"----------------------------------------
" nerdtree
"----------------------------------------
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

"----------------------------------------
" caw
"----------------------------------------
map <C-c> <Plug>(caw:hatpos:toggle)

"----------------------------------------
" lightline
"----------------------------------------
set guifont=Ricty-RegularForPowerline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'inactive': {
      \   'right': [  ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ }
      \ }

"----------------------------------------
" neocomplecache
"----------------------------------------
let g:neocomplcache_enable_at_startup = 1

"----------------------------------------
" 表示設定
"----------------------------------------
" 行番号
set number
" ステータス行を常に表示
set laststatus=2
" テーマカラー
let g:rehash256 = 1
" コマンドラインの履歴を10000件保存するV
set history=10000
" シンタックスハイライト
syntax on
colorscheme custom
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" 行末のスペースを可視化
set listchars=tab:>\ ,eol:$
" 現在の行を強調表示
set cursorline
" 対応する括弧の強調表示
set showmatch
" ESC連打でハイライト解除

"----------------------------------------
" 検索設定
"----------------------------------------
" 検索するときに大文字小文字を区別しない
set ignorecase
" 小文字で検索すると大文字と小文字を無視して検索
set smartcase
" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索
set wrapscan
" インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set incsearch
" 検索結果をハイライト表示
set hlsearch
" :vim 検索後自動的にリスト表示
autocmd QuickFixCmdPost *grep* cwindow

"----------------------------------------
" その他設定
"----------------------------------------
" UTF-8化
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 保存時に行末のゴミ空白を削除
autocmd BufWritePre * :%s/\s\+$//ge

"----------------------------------------
" 操作設定
"----------------------------------------
" tabを半角スペース化
set expandtab
" 行頭以外のtabをスペース2個分にする
set tabstop=2
" 行頭以外のtabをスペース2個分にする
set shiftwidth=2
set softtabstop=2
" 自動インデント2
set autoindent
" バックスペースキー有効
set backspace=start,eol,indent
" ヤンクでクリップボードにコピー
set clipboard=unnamed,autoselect
" 削除キーでyankしない
nnoremap x "_x
nnoremap d "_d
" マウス操作の有効化 & ホイール操作の有効化
set mouse=a
" set ttymouse=xterm2
