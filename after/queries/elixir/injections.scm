;; extends
(string
  (quoted_content) @injection.content
    (#vim-match? @injection.content "(WITH|with|SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
    (#set! injection.language "sql"))

(call
  target: (identifier) @fn
  (arguments
    (string (quoted_content) @injection.content))
  (#match? @fn "^(execute|query)$")
  (#set! injection.language "sql"))
