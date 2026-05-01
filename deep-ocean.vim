set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "deep-ocean"

" ── Editor ────────────────────────────────────────────────────────────────────
hi Normal          guifg=#A6ACCD guibg=#0F111A
hi NormalFloat     guifg=#A6ACCD guibg=#090B10
hi FloatBorder     guifg=#232637 guibg=#090B10
hi ColorColumn                   guibg=#090B10
hi CursorLine                    guibg=#1F2233
hi CursorLineNr    guifg=#84FFFF
hi LineNr          guifg=#3B3F51
hi SignColumn                    guibg=#0F111A
hi VertSplit       guifg=#232637
hi WinSeparator    guifg=#232637
hi Visual                        guibg=#1F2233
hi Search          guifg=#0F111A guibg=#84FFFF
hi IncSearch       guifg=#0F111A guibg=#FFCB6B
hi MatchParen      guifg=#84FFFF               gui=bold
hi EndOfBuffer     guifg=#3B3F51

" ── Statusline ────────────────────────────────────────────────────────────────
hi StatusLine      guifg=#A6ACCD guibg=#1A1C25
hi StatusLineNC    guifg=#464B5D guibg=#1A1C25

" ── Pmenu (fallback completion menu) ─────────────────────────────────────────
hi Pmenu           guifg=#A6ACCD guibg=#1A1C25
hi PmenuSel        guifg=#0F111A guibg=#84FFFF
hi PmenuSbar                     guibg=#232637
hi PmenuThumb                    guibg=#464B5D

" ── Syntax ────────────────────────────────────────────────────────────────────
hi Comment         guifg=#464B5D gui=italic
hi Constant        guifg=#89DDFF
hi String          guifg=#C3E88D
hi Number          guifg=#F78C6C
hi Float           guifg=#F78C6C
hi Boolean         guifg=#89DDFF
hi Identifier      guifg=#A6ACCD
hi Function        guifg=#82AAFF
hi Statement       guifg=#C792EA
hi Keyword         guifg=#C792EA
hi Conditional     guifg=#C792EA
hi Repeat          guifg=#C792EA
hi Operator        guifg=#89DDFF
hi PreProc         guifg=#C792EA
hi Include         guifg=#C792EA
hi Type            guifg=#FFCB6B
hi StorageClass    guifg=#C792EA
hi Special         guifg=#89DDFF
hi Delimiter       guifg=#89DDFF
hi Todo            guifg=#FFCB6B guibg=#0F111A gui=bold

" ── LSP diagnostics ───────────────────────────────────────────────────────────
hi DiagnosticError             guifg=#FF5370
hi DiagnosticWarn              guifg=#FFCB6B
hi DiagnosticInfo              guifg=#82AAFF
hi DiagnosticHint              guifg=#84FFFF
hi DiagnosticUnderlineError    guisp=#FF5370 gui=undercurl
hi DiagnosticUnderlineWarn     guisp=#FFCB6B gui=undercurl
hi DiagnosticUnderlineInfo     guisp=#82AAFF gui=undercurl
hi DiagnosticUnderlineHint     guisp=#84FFFF gui=undercurl

" ── Telescope ─────────────────────────────────────────────────────────────────
hi TelescopeNormal             guifg=#A6ACCD guibg=#090B10
hi TelescopeBorder             guifg=#232637 guibg=#090B10
hi TelescopePromptNormal       guifg=#A6ACCD guibg=#1A1C25
hi TelescopePromptBorder       guifg=#1A1C25 guibg=#1A1C25
hi TelescopePromptTitle        guifg=#0F111A guibg=#84FFFF
hi TelescopePreviewTitle       guifg=#0F111A guibg=#C3E88D
hi TelescopeResultsTitle       guifg=#232637 guibg=#090B10
hi TelescopeSelection          guifg=#A6ACCD guibg=#1F2233
hi TelescopeSelectionCaret     guifg=#84FFFF guibg=#1F2233
hi TelescopeMatching           guifg=#84FFFF

" ── blink.cmp ─────────────────────────────────────────────────────────────────
hi BlinkCmpMenu                guifg=#A6ACCD guibg=#1A1C25
hi BlinkCmpMenuBorder          guifg=#232637 guibg=#1A1C25
hi BlinkCmpMenuSelection       guifg=#0F111A guibg=#84FFFF
hi BlinkCmpScrollBarThumb                    guibg=#464B5D
hi BlinkCmpScrollBarGutter                   guibg=#1A1C25
hi BlinkCmpLabel               guifg=#A6ACCD
hi BlinkCmpLabelMatch          guifg=#84FFFF
hi BlinkCmpKind                guifg=#717CB4
hi BlinkCmpDoc                 guifg=#A6ACCD guibg=#090B10
hi BlinkCmpDocBorder           guifg=#232637 guibg=#090B10
