syntax keyword tsKeyword interface type infer abstract private public protected static readonly implements namespace declare is keyof
highlight def link tsKeyword Keyword
syntax cluster ts add=tsKeyword

syntax keyword tsType object boolean number string any never unknown undefined null void
highlight def link tsType Type
syntax cluster ts add=tsType

"syntax region tsGeneric start="\i\zs<" end=">" contained containedin=jsIdentifier contains=tsType
"syntax cluster ts add=tsGeneric

syntax cluster js add=@ts
