" init.vim
"
" Author: Aaron Lucas
" Created On: 2022/07/22

" Plugins {{{

call plug#begin()

" Convenient Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-capslock'

" Source Control
Plug 'tpope/vim-fugitive'

" Colorschemes
Plug 'monsonjeremy/onedark.nvim'
Plug 'ellisonleao/gruvbox.nvim'

" Statusline + icons
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Fuzzy Finder
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" LSP & completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'fannheyward/telescope-coc.nvim'

" Filesystem Navigation
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()

" }}}

" Plugin Configuration {{{

lua << END

require('onedark').setup()

require('lualine').setup {
    options = {
        theme = 'onedark'
    }
}

require('telescope').setup()
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        -- disable = { "vim" },
        additional_vim_regex_highlighting = false
    },
    incremental_selection = { enable = true },
    textobjects = { enable = true }
}

END

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
    \ exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close NERDTree after opening a file
let g:NERDTreeQuitOnOpen = 1

" }}}

" Colorscheme & Highlighting {{{

hi! link TSVariable Normal
hi! link TSOperator Operator

" }}}

" Editor Settings {{{

" Tabs & Spacing
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set shiftround
set expandtab
set autoindent

" Make tabs and trailing spaces visible
set list
set listchars=tab:▶\ ,trail:·

" Misc. buffer stuff
set hidden
set autoread
set lazyredraw

" Search & Substitute
set ignorecase
set smartcase
set infercase
set incsearch
set showmatch
set hlsearch
set gdefault
set wrapscan
set report=0

" Line Number Column
set number
set relativenumber
set cursorline
set signcolumn=number

" Maximum Line Length
set textwidth=100
set formatoptions-=t

" Persistent Edit History
set undofile

" Cursor
"     * Block in normal mode
"     * Bar in insert mode
"     * Underscore in replace mode
let &t_SI="\<Esc>]50;CursorShape=1\x7"
let &t_SR="\<Esc>]50;CursorShape=2\x7"
let &t_EI="\<Esc>]50;CursorShape=0\x7"

" Code Folding
set foldmethod=marker

" Mouse Interaction
set mouse+=a

" Statusline
set noshowmode
set laststatus=3
set showcmd
set shortmess+=c

" Splitting
set splitbelow
set splitright
set noequalalways

" Allow external vimrc files
set exrc
set secure

" Other
set updatetime=300
set virtualedit+=block
set nrformats-=octal

" }}}

" General Mappings {{{

let mapleader=" "

" Substitute on last visual selection
nnoremap gs :'<,'>s/

" Keep flags on repeat substitutions
nnoremap & <cmd>&&<cr>
xnoremap & <cmd>&&<cr>

" Use proper regex when searching
nnoremap / /\v
nnoremap ? ?\v
vnoremap / /\v
vnoremap ? ?\v

" Paste directory of current file in command
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') : '%%'

" Switch to last used buffer (quicker)
nnoremap <leader>, <C-^>

" Navigate vertically using 'visual' lines rather than by line number
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Jump to next/previous number in file
nnoremap <silent> <leader>n <cmd>call search('\d\+')<cr>
nnoremap <silent> <leader>N <cmd>call search('\d\+', 'b')<cr>

" Change all occurrences of word under cursor
nnoremap <leader>* :%s/\<<C-R><C-W>\>/

" Repeat last macro
nnoremap Q @@

" Fix last spelling mistake
nmap <leader>s [s1z=``

" Faster paste from unnamed register in insert mode
inoremap <C-r><C-r> <C-r>"

" Re-select after indent in visual mode
vnoremap < <gv
vnoremap > >gv

" Toggle NERDTree
nnoremap <C-n> <Cmd>NERDTreeToggle<cr>

" Toggle fugitive
nnoremap <C-g> <Cmd>Git<cr>

" }}}

" Telescope Mappings {{{

" mnemonic for <leader>fx: find xxx
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>

nnoremap <leader>fs <cmd>Telescope coc workspace_symbols<cr>

" }}}

" COC Mappings {{{

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <leader>g <Cmd>CocDiagnostics<cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif


" Commands {{{

" Reload init.vim
command Init source ~/.config/nvim/init.vim

" View all active highlights
command HiTest source ${VIMRUNTIME}/syntax/hitest.vim

command Strip %s/\s\+$//

function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"}}}
