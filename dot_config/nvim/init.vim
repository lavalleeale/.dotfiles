" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync
\| endif

call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'numToStr/Comment.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'AlphaTechnolog/pywal.nvim', { 'as': 'pywal' }
Plug 'rmagatti/auto-session'
Plug 'nvim-tree/nvim-tree.lua'
call plug#end()

lua require('init')
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fs <cmd>SessionSearch<cr>
nnoremap <leader>t <cmd>:NvimTreeToggle<cr>
autocmd CursorHold * silent call <SID>show_documentation()
function! s:show_documentation()
  silent! call CocAction('definitionHover')
endfunction
set number
set showtabline=2
set mouse=
runtime ./coc.vim
