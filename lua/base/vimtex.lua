local g = vim.g
g.tex_flavor = 'latex'
g.vimtex_view_method = 'skim'
g.vimtex_view_general_viewer = 'skim'
g.vimtex_view_skim_sync=1
g.vimtex_view_skim_activate=1
g.vimtex_disable_version_warning=1
g.vimtex_compiler_method = 'latexmk'

g.vimtex_compiler_enabled=1
-- FIXME hack, no clue what's wrong
vim.cmd("let g:vimtex_compiler_latexmk = { 'callback' : 0, 'build_dir' : 'build', 'options' : [ '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode', '-shell-escape' ], }")
