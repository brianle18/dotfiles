# Neovim Config

Personal Neovim configuration. Requires Neovim 0.12+.

## Structure

| File | Purpose |
|------|---------|
| `lua/plugins.lua` | Plugin list (lazy.nvim) |
| `lua/lsp.lua` | LSP server configs |
| `lua/linting.lua` | Linter config (nvim-lint) |
| `lua/format.lua` | Formatter config (conform.nvim) |
| `lua/colours.lua` | Colorscheme + statusline (lualine) |
| `lua/ts.lua` | Treesitter config |
| `lua/mappings.lua` | Keymaps |
| `lua/autocomplete.lua` | Completion (nvim-cmp) |
| `lua/diag.lua` | Diagnostic display config |
| `lua/search.lua` | Telescope config |
| `lua/snippet.lua` | Snippet config |

## LSPs

| Language | Server |
|----------|--------|
| Elixir | elixirls |
| TypeScript/JavaScript | ts_ls, biome |
| Python | basedpyright, ruff |
| Lua | lua_ls |
| Ruby | ruby_lsp |
| Bash | bashls |
| SQL/dbt | sqlls, dbtls |
| HTML | html |
| Vimscript | vimls |
| Dockerfile | dockerls |
| GraphQL | graphql |
| Typst | tinymist |
| GitHub Actions | gh_actions_ls |

## Linters

| Language | Linter |
|----------|--------|
| JavaScript/TypeScript | biomejs |
| Python | mypy, ruff |
| SQL | sqlfluff |
| Dotenv | dotenv_linter |

## Formatters

| Language | Formatter |
|----------|-----------|
| Lua | stylua |
| SQL | sqlfluff |
| JSON | jq |
| Elixir | mix format |
| Python | ruff_format |
| Typst | prettypst |
| JavaScript/TypeScript | biome |

## Theme

gruvbox-material (hard dark)

## Key Mappings

| Key | Action |
|-----|--------|
| `\t` | Toggle file tree (NvimTree, reveals current file) |
| `\u` | Toggle undo tree |
| `\l` | Toggle relative line numbers |
| `\c` | Clear search highlight |
| `\p` | Print full file path |
| `\m` | Toggle mouse |
| `gs` | dbt: go to schema |
| `gd` | LSP: go to definition |
| `gr` | LSP: references |
| `K` | LSP: hover |
| `\cr` | LSP: rename |
| `\cd` | LSP: diagnostics float |
| `[d` / `]d` | LSP: prev/next diagnostic |

## Notes

- dbt SQL files get Jinja syntax highlighting via `after/syntax/sql.vim`
- SQL treesitter highlighting is force-started via `after/ftplugin/sql.lua` to prevent vim syntax from overriding it
- Dotenv files (`.env.*`) use bash treesitter for highlighting
