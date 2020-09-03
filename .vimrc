" dein settings
if &compatible
  set nocompatible
endif
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.vim/bundle')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set  runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('Shougo/dein.vim')
  call dein#add('tomasr/molokai')
  call dein#add('mechatroner/rainbow_csv')
  " ファイル構造見れるやつ
  call dein#add('scrooloose/nerdtree')
  " 補完
  call dein#add('prabirshrestha/vim-lsp')
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/asyncomplete.vim')
  call dein#add('prabirshrestha/asyncomplete-lsp.vim')

  " for go
  " call dein#add('fatih/vim-go')

  " status line
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('ryanoasis/vim-devicons')

  " for markdown
  " call dein#add('plasticboy/vim-markdown')
  " mardown preview
  " call dein#add('previm/previm')

  " インデントの可視化
  call dein#add( 'Yggdroot/indentLine')
  " 末尾の全角半角空白文字を赤くハイライト
  call dein#add( 'bronson/vim-trailing-whitespace')
  " インデントに色を付けて見やすくする
  call dein#add( 'nathanaelkane/vim-indent-guides')


  " Rails向けのコマンドを提供する
  " call dein#add( 'tpope/vim-rails')
  " Ruby向けにendを自動挿入してくれる
  call dein#add( 'tpope/vim-endwise')

  " for clang-format
  " call dein#add('rhysd/vim-clang-format')

  " for git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')

  " 閉じカッコなど補完
  call dein#add('mattn/vim-lexiv')

  " テキストを囲む
  call dein#add('tpope/vim-surround')

  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" ノーマルモード時だけ ; と : を入れ替える
" nnoremap ; :
" nnoremap : ;


" language server protocol shortcut
" leaderはデフォルトでバックスラッシュ,
" 自由に設定ができる
let mapleader=","
nnoremap <Leader>a :echo "Hello"<CR>
nnoremap <silent> <Leader>d ;LspDefinition<CR>
nnoremap <silent> <Leader>h ;LspHover<CR>
nnoremap <silent> <Leader>r ;LspReferences<CR>
nnoremap <silent> <Leader>i ;LspImplementation<CR>
nnoremap <silent> <Leader>n ;LspNextError<CR>
nnoremap <silent> <Leader>s ;split \| ;LspDefinition <CR>
nnoremap <silent> <Leader>v ;vsplit \| ;LspDefinition <CR>

" ファイルバッファの前後に行く
nnoremap <silent> bp :bprevious<CR>
nnoremap <silent> bn :bnext<CR>

" using icon
let g:airline_theme = 'wombat'
set laststatus=2
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
let g:airline_section_c = '%t'
let g:airline_section_x = '%{&filetype}'
" let g:airline_section_z = '%3l:%2v %{airline#extensions#ale#get_warning()} %{airline#extensions#ale#get_error()}'
" let g:airline#extensions#ale#error_symbol = ' '
" let g:airline#extensions#ale#warning_symbol = ' '
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#whitespace#enabled = 1

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_signs_error = {'text': ' '}
let g:lsp_signs_warning = {'text': ' '}
let g:lsp_signs_hint = {'text': ''}

" NERDTree settings
map <C-n> ;NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable  = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'

" setting
"文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
set relativenumber
" カーソル位置の行数と列を表示
set ruler
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable
colorscheme molokai

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> ;nohlsearch<CR><Esc>

set backspace=indent,eol,start

" ファイル形式の検出の有効化する
" ファイル形式別プラグインのロードを有効化する
" ファイル形式別インデントのロードを有効化する
filetype plugin indent on

if has('vim_starting')
  " 挿入モード時に非点滅の縦棒タイプのカーソル
  let &t_SI .= "\e[6 q"
  " ノーマルモード時に非点滅のブロックタイプのカーソル
  let &t_EI .= "\e[2 q"
  " 置換モード時に非点滅の下線タイプのカーソル
  let &t_SR .= "\e[4 q"
endif

au BufNewFile,BufRead Dockerfile* setf Dockerfile
set clipboard+=unnamed
