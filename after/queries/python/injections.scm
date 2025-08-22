;; extends
(string
  (string_content) @injection.content
    (#vim-match? @injection.content "(WITH|with|SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
    (#set! injection.language "sql"))

(call
  function: (attribute attribute: (identifier) @id (#match? @id "execute|read_sql"))
  arguments: (argument_list
    (string (string_content) @injection.content (#set! injection.language "sql"))))

