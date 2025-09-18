let g:java_highlight_functions=1
let g:java_highlight_all=1

highlight link javaScopeDecl Statement
highlight link javaType Type
highlight link javaDocTags PreProc

inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
