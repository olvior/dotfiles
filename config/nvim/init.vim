" olvior's nvim config
" Mainly equal to my vimrc but slightly adapted, and with treesitter
" Might add lsp support in the future...

call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter'

call plug#end()


runtime! ./vimscript/settings.vim

runtime! ./vimscript/mappings.vim

runtime! ./vimscript/autocmds.vim

runtime! ./vimscript/functions.vim

runtime! ./vimscript/ui.vim

runtime! ./vimscript/autocomplete.vim


" lua section for treesitter
lua << END_LUA

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "cpp", "java", "python", "vim", "markdown", "markdown_inline" },

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
  },
}

END_LUA
