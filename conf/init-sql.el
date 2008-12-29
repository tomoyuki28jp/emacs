;;; init-sql.el

;; SQL-Mode
(add-hook 'sql-mode-hook
          (lambda ()
            (setq sql-product 'mysql)
            (setq sql-user "root")
;           (load-library "sql-indent")
            (setq sql-indent-offset 4)
            (setq sql-indent-maybe-tab nil)
            (setq sql-indent-first-column-regexp
                  (concat "^\\s-*"
                          (regexp-opt
                           '("select" "update" "insert" "delete"
                             "union" "intersect"
                             "from" "where" "into" "group" "having" "order"
                             "set" "and" "or" "exists" "limit"
                             "--") t) "\\(\\b\\|\\s-\\)"))))
