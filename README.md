# Neovim Config

Personal Neovim configuration. Requires Neovim 0.12+.

## Structure

| File | Purpose |
|------|---------|
| `lua/plugins.lua` | Plugin list (lazy.nvim) |
| `lua/lsp.lua` | LSP server configs (native `vim.lsp` API) |
| `lua/linting.lua` | Linter config (nvim-lint) |
| `lua/format.lua` | Formatter config (conform.nvim) |
| `lua/colours.lua` | Colorscheme + statusline (lualine) |
| `lua/ts.lua` | Treesitter config + textobjects + dotenv detection |
| `lua/mappings.lua` | Core keymaps |
| `lua/autocomplete.lua` | Copilot + Avante AI setup |
| `lua/diag.lua` | Diagnostic display config |
| `lua/search.lua` | Telescope + NvimTree + Oil config |
| `lua/snippet.lua` | LuaSnip + nvim-cmp completion |
| `lua/coc.lua` | CoC (legacy, used for Elixir) |
| `lua/frontend.lua` | JS/TS specific config |
| `lua/elixir.lua` | Elixir specific config |
| `lua/languages.lua` | Misc language config |
| `lua/sql.lua` | SQL / dadbod config |
| `lua/ai_tools.lua` | AI tool helpers |
| `lua/mcp_servers.lua` | MCP server definitions |
| `lua/telescope_multigrep.lua` | Custom multi-grep picker |
| `lua/lualine_python.lua` | Custom lualine Python component |
| `after/ftplugin/sql.lua` | Force treesitter active for SQL buffers |
| `after/syntax/sql.vim` | Jinja vim-regex syntax (disabled) |
| `after/queries/python/injections.scm` | SQL injection into Python strings |
| `after/queries/sql/injections.scm` | SQL treesitter query extensions |

## LSPs

Uses Neovim 0.12 native LSP API (`vim.lsp.config` / `vim.lsp.enable`) — no lspconfig dependency.

| Language | Server | Notes |
|----------|--------|-------|
| Elixir | elixirls | Manual binary path required |
| TypeScript/JavaScript | ts_ls, biome | ts_ls for types, biome for lint/format |
| Python | basedpyright, ruff | Both active simultaneously |
| Lua | lua_ls | Neovim runtime-aware (LuaJIT, VIMRUNTIME library) |
| Ruby | ruby_lsp | `ruby-lsp` binary, roots at Gemfile |
| Bash | bashls | Also handles `.env.*` files |
| SQL | sqlls | Disabled by default |
| dbt | dbtls | Disabled by default; roots at `dbt_project.yml` |
| HTML | html | |
| Vimscript | vimls | |
| Dockerfile | dockerls | |
| GraphQL | graphql | Also attaches to TSX/TS files |
| Typst | tinymist | |
| GitHub Actions | gh_actions_ls | YAML files |
| Copilot | copilot | Native LSP client |

### LSP Keymaps (all buffers with LSP attached)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | References |
| `K` | Hover docs |
| `<C-k>` | Signature help |
| `\cr` | Rename symbol |
| `\gca` | Code action |
| `\cf` | Format buffer |
| `\cd` | Open diagnostics float |
| `[d` / `]d` | Prev / next diagnostic |

## Linters

| Language | Linter |
|----------|--------|
| JavaScript/TypeScript | biomejs |
| Python | mypy, ruff |
| Dotenv (`.env.*`) | dotenv_linter |
| SQL | sqlfluff (disabled) |

Linting runs on `BufEnter`, `BufWritePost`, and `InsertLeave`. Manual trigger: `\lf`.

## Formatters

| Language | Formatter |
|----------|-----------|
| Lua | stylua (4-space indent) |
| JSON | jq |
| Elixir | mix format (roots at `.envrc`) |
| Python | ruff_format |
| Typst | prettypst |
| JavaScript/TypeScript | prettierd |
| All files | injected-language formatting, trim whitespace |

Format on save is enabled with a 10 second timeout (`lsp_format = "fallback"`).

## Theme

gruvbox-material (hard dark).

### Statusline (lualine)

| Section | Content |
|---------|---------|
| Left A | Mode |
| Left B | Git branch (truncated to `abcdefghi...wxyz012` if >20 chars), diff, diagnostics |
| Left C | Filename, LSP progress |
| Right X | Active LSPs (green), failed LSPs (red), active linters (blue), failed linters (red), active formatters (purple), failed formatters (red), encoding, fileformat, filetype |
| Right Y | Scroll percentage |
| Right Z | Line/column |

LSP status icons: server, linter, formatter (Nerd Font / devicons). Copilot and Augment are hidden from the statusline.

## Treesitter

Parsers auto-installed. The following are explicitly ensured:

`c`, `cpp`, `python`, `lua`, `r`, `markdown`, `markdown_inline`, `comment`, `html`, `css`, `javascript`, `typescript`, `tsx`, `sql`

Latex highlighting is disabled (vimtex handles it). Rainbow delimiters are enabled.

### Textobject Keymaps

| Key | Object |
|-----|--------|
| `ad` / `id` | Block outer / inner |
| `af` / `if` | Function outer / inner |
| `ap` / `ip` | Parameter outer / inner |

### Motion Keymaps

| Key | Motion |
|-----|--------|
| `]m` / `[m` | Next / prev function start |
| `]M` / `[M` | Next / prev function end |
| `]p` / `[p` | Next / prev parameter start |
| `]P` / `[P` | Next / prev parameter end |
| `]]` / `[[` | Next / prev class start |
| `][` / `[]` | Next / prev class end |

### Dotenv files

`.env.*` files are detected as `dotenv` filetype and highlighted with the `bash` parser.

## Completion (nvim-cmp + LuaSnip)

Sources (in priority order): LSP → LuaSnip → buffer → vim-dadbod-completion.

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selection |
| `<Tab>` / `<S-Tab>` | Next / prev item, or expand/jump snippet |
| `<C-b>` / `<C-f>` | Scroll docs |
| `<C-e>` | Abort |

### Snippet Keymaps (LuaSnip)

| Key | Action |
|-----|--------|
| `<C-K>` (insert) | Expand snippet |
| `<C-L>` (insert/select) | Jump forward |
| `<C-J>` (insert/select) | Jump backward |
| `<C-E>` (insert/select) | Cycle choice node |

## AI Tools

### Copilot

- `<C-J>` (insert) — accept suggestion (Tab map disabled to avoid cmp conflict)

### Avante

Agentic AI assistant using Azure OpenAI (gpt-4o). MCP tools are available via mcphub.nvim and injected into the Avante system prompt automatically.

## Key Mappings

### Navigation

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows |
| `-` | Open parent directory (Oil) |

### Toggles

| Key | Action |
|-----|--------|
| `\t` | Toggle file tree (NvimTree, reveals current file) |
| `\u` | Toggle undo tree |
| `\l` | Toggle relative line numbers |
| `\m` | Toggle mouse |
| `\o` | Toggle paste mode |

### Utilities

| Key | Action |
|-----|--------|
| `\c` | Clear search highlight |
| `\p` | Print full file path |

### Search (Telescope)

| Key | Action |
|-----|--------|
| `tt` | Open Telescope |
| `\ff` | Find files |
| `\fg` | Multi-grep (double space separates search and file pattern) |
| `\fw` | Grep current word |
| `\fb` | Find buffers |
| `\fh` | Help tags |
| `\fc` | Commands |
| `\fd` | LSP definitions |
| `\fr` | LSP references |
| `\fk` | Keymaps |
| `\fws` | Workspace symbols |
| `\fds` | Document symbols |
| `\fn` | Notifications |
| `\fa` | Code actions |
| `\fo` | Search Obsidian vault |

### File Browser (Oil)

| Key | Action |
|-----|--------|
| `-` | Open parent directory |
| `\st` | Sort by modified time |
| `\sn` | Sort by name |

### Diagnostics

| Key | Action |
|-----|--------|
| `\sd` | Open diagnostics float |
| `\ll` | Toggle lsp_lines (inline diagnostic lines) |
| `<Space>d` | Toggle diagnostics entirely |

### Language-specific

| Key | Action |
|-----|--------|
| `gs` | dbt: go to schema file (requires dbtls attached) |
| `\ts` | Force-start treesitter in current buffer |

### Git / Diff

| Key | Action |
|-----|--------|
| `\gl` | diffget LOCAL (3-way merge) |
| `\gr` | diffget REMOTE (3-way merge) |
| `\gb` | diffget BASE (3-way merge) |

Use `[c` / `]c` (vim built-in) to jump between conflict hunks.

## Notable Plugins

| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Plugin manager |
| gruvbox-material | Colorscheme |
| lualine | Statusline |
| nvim-treesitter | Syntax / textobjects |
| nvim-cmp | Completion framework |
| LuaSnip | Snippets |
| Telescope | Fuzzy finder |
| nvim-tree | File tree |
| Oil | File browser (ranger-style) |
| vim-fugitive | Git integration |
| vim-gitgutter | Git gutter signs |
| undotree | Visual undo history |
| conform.nvim | Formatting |
| nvim-lint | Linting |
| lsp_lines | Inline diagnostic rendering |
| noice.nvim | UI for messages, cmdline, popupmenu |
| nvim-notify | Toast notifications |
| Copilot | AI completion |
| Avante | AI assistant (agentic) |
| mcphub.nvim | MCP server manager |
| vim-dadbod + UI | SQL database client |
| obsidian.nvim | Obsidian vault integration |
| vim-easy-align | Text alignment (`ga`) |
| vim-surround | Surround with `cs`/`ds`/`ys` |
| delimitMate | Auto-close brackets/quotes |
| rainbow-delimiters | Bracket rainbow colouring |
| todo-comments | Highlight TODO/FIXME/etc |
| highlight-whitespace | Trailing whitespace highlight |
| vimtex | LaTeX support |
| glow.nvim | Markdown preview in terminal |
| markdown-preview.nvim | Markdown preview in browser |
| vim-mixer | Elixir mix tasks |
| vim-elixir | Elixir syntax |
| nx.nvim | Nx monorepo integration |

## Notes

- Uses Neovim 0.12 native LSP API throughout — no lspconfig wrappers.
- `after/ftplugin/sql.lua` force-calls `vim.treesitter.start()` to prevent `syntax.vim`'s FileType autocmd from disabling treesitter in SQL buffers.
- A global `FileType` autocmd (in `ts.lua`) schedules `vim.treesitter.start()` after all other FileType handlers for every filetype, ensuring treesitter injection highlighting (e.g. SQL in Python strings) always works.
- Python SQL injection highlights SQL inside `pd.read_sql(...)`, `cursor.execute(...)`, and string literals matching SELECT/INSERT/UPDATE/DELETE patterns.
- Dotenv files (`.env.*`) use the bash treesitter parser.
- dbt `gs` keybinding uses `workspace/executeCommand` via dbtls directly (not `vim.lsp.buf.execute_command`) to avoid broadcasting to other LSP clients.
- Avante MCP tools are injected from mcphub into the system prompt at request time.
- `\fg` multi-grep: type search term, then two spaces, then a file glob to scope the search.
