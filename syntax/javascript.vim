setlocal foldmethod=syntax

"syntax region jsBlock transparent start="\v(\$)@<!\{" end="\v\}" contains=@js,jsBlock

set isident+=$
syntax match jsIdentifier "\<\I\i*\>" 
highlight def link jsIdentifier Identifier
syntax cluster js add=jsIdentifier

syntax match jsFunctionCall "\I\i*\ze\(\s*\|?\.\)(" contained containedin=jsObjectProperty,jsIdentifier
highlight def link jsFunctionCall Function

syntax match jsObjectProperty "\(\.\)\@<=\<\I\i*\>" contained containedin=jsIdentifier

"syntax match jsLetOrConst "\v(let|const)" nextgroup=jsBindingList skipwhite
"syntax region jsBindingList start="\v((let|const)\s+)@<=." end="=" contained contains=@jsBindingPattern,jsBindingIdentifier
"syntax match jsBindingIdentifier "\v\w+" contained
"syntax region jsObjectBindingPattern transparent start="{"rs=s-1 end="}" contained contains=@jsBindingPattern,jsBindingIdentifier
"syntax cluster jsBindingPattern add=jsObjectBindingPattern
"syntax region jsArrayBindingPattern transparent start="\["rs=s-1 end="\]" contained contains=@jsBindingPattern,jsBindingIdentifier
"syntax cluster jsBindingPattern add=jsArrayBindingPattern
"highlight def link jsLetOrConst jsKeyword
"highlight def link jsBindingIdentifier jsIdentifier

syntax keyword jsBoolean false true
highlight def link jsBoolean Boolean
syntax cluster js add=jsBoolean

set iskeyword-=*
syntax match jsNumber "\(\<\d\+\|[^\I]\zs\)\.\d\+\(e-\?\d\+\)\?\>"
syntax match jsNumber "\<\d\+\(e-\?\d\+\|n\)\?\>"
syntax match jsNumber "\<0\(x\x\+\|b[01]\+\)\>"
syntax keyword jsNumber NaN Infinity
highlight def link jsNumber Number
syntax cluster js add=jsNumber

syntax match jsComment "//.*$"
syntax region jsComment start="/\*" end="\*/"
syntax sync ccomment jsComment
highlight def link jsComment Comment
syntax cluster js add=jsComment

syntax region jsString start="\z(\"\|\'\)" skip="\\\z1" end="\z1" oneline
highlight def link jsString String
syntax cluster js add=jsString

syntax region jsRegex start="\v\/[^*/]" end="\v\/[dgimsuy]?" oneline
syntax cluster js add=jsRegex

syntax keyword jsKeyword let const function class extends super static this switch case yield var async await delete new typeof instanceof void debugger do while if else for in of continue import export as default from return switch case break try catch throw null
highlight def link jsKeyword Keyword
syntax cluster js add=jsKeyword


syntax region jsPlaceholder start="\v(\\)@<!\$\{"rs=s-1 end="\}" contained contains=@js,jsBlock
syntax region jsTemplateLiteral start="\v`" skip="\v\\`" end="\v(\\)@<!`" contains=jsPlaceholder
highlight jsPlaceholder cterm=NONE ctermfg=NONE ctermbg=NONE
highlight def link jsTemplateLiteral jsString
syntax cluster js add=jsTemplateLiteral
