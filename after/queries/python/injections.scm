;; extends
(string 
  (string_content) @injection.content
    (#vim-match? @injection.content "^\w*SELECT|FROM|INNER JOIN|WHERE|CREATE|DROP|INSERT|UPDATE|ALTER.*$")
    (#set! injection.language "sql"))

(call
  function: (attribute attribute: (identifier) @id (#match? @id "execute|read_sql"))
  arguments: (argument_list
    (string (string_content) @injection.content (#set! injection.language "sql"))))
