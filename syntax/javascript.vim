setlocal foldmethod=syntax

syntax region jsBlock transparent start="\v(\$)@<!\{" end="\v\}" contains=@js,jsBlock

set isident+=$
syntax match jsIdentifier "\v(\.|\w)@<!(\$\{)@!\I\i*"
highlight def link jsIdentifier Identifier
syntax cluster js add=jsIdentifier

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

syntax match jsNumber "\v(\d|\.|e|e-)@<!(\d+\.|\d+\.e|\d+e)@!\d+" " .1234
syntax match jsNumber "\v(\d|\.)@<!\d+e-?\d+" " .123e4 .123e-4
syntax match jsNumber "\v(\d+)@<!(\.\d+e)@!\.\d+" " 12.34
syntax match jsNumber "\v(\d+)@<!\.\d+e-?\d+" " 12.3e4 12.3e-4
syntax match jsNumber "\v(\d+\.\d+e)@!\d+\.\d+" " 1234
syntax match jsNumber "\v\d+\.\d+e-?\d+" " 12e34 12e-34
syntax match jsNumber "\v\d+n" " 1234n
syntax match jsNumber "\v0x[0-9a-fA-F]+" " 0x1234
syntax match jsNumber "\v0b[01]+" " 0b01
syntax keyword jsNumber NaN Infinity
highlight def link jsNumber Number
syntax cluster js add=jsNumber

syntax match jsComment "\v\/\/.+"
syntax region jsComment start="\v\/\*" end="\v\*\/"
syntax sync ccomment jsComment
highlight def link jsComment Comment
syntax cluster js add=jsComment

syntax region jsString start="\"" skip="\\\"" end="\"" oneline
syntax region jsString start="\'" skip="\\\'" end="\'" oneline
highlight def link jsString String
syntax cluster js add=jsString

syntax region jsRegex start="\v\/[^*/]" end="\v\/[dgimsuy]?" oneline
syntax cluster js add=jsRegex

set iskeyword+=*
syntax keyword jsKeyword let const function function* class super this switch case yield var async await delete new typeof instanceof void debugger do while if else for in of continue import export as default from return switch case break try catch throw null
highlight def link jsKeyword Keyword
syntax cluster js add=jsKeyword

syntax match jsFunctionCall "\v(function\s+|function\*\s+|\w)@<!\I\i*\("me=e-1
syntax match jsFunctionCall "\v\I\i*\?\.\("me=e-3
highlight def link jsFunctionCall Function
syntax cluster js add=jsFunctionCall

syntax region jsPlaceholder start="\v(\\)@<!\$\{" end="\}" contained contains=@js,jsBlock
syntax region jsTemplateLiteral start="\v`" skip="\v\\`" end="\v(\\)@<!`" contains=jsPlaceholder
highlight jsPlaceholder cterm=NONE ctermfg=NONE ctermbg=NONE
highlight def link jsTemplateLiteral jsString
syntax cluster js add=jsTemplateLiteral
