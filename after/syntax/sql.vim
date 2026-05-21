" Jinja2 syntax on top of SQL (for dbt models)
syntax region jinjaVariable matchgroup=jinjaDelim start='{{' end='}}' keepend
syntax region jinjaBlock    matchgroup=jinjaDelim start='{%[+-]\?' end='[+-]\?%}' keepend
syntax region jinjaComment  matchgroup=jinjaDelim start='{#' end='#}' keepend

highlight default link jinjaDelim    Special
highlight default link jinjaVariable Identifier
highlight default link jinjaBlock    PreProc
highlight default link jinjaComment  Comment
