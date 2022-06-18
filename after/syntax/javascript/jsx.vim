"syntax match jsxTagName "\v(\<)@<=\w+" contained containedin=jsIdentifier
"highlight def link jsxTagName Keyword 

"syntax region jsxBlock start="<\z(\I\i\+\)" end="\z1\\>"
"syntax cluster jsx add=jsxBlock

"syntax region jsxTag start="\v<" end="\v>"
"syntax cluster jsx add=jsxTag

syntax cluster js add=@jsx
