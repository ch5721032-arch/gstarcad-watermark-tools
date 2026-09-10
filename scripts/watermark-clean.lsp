;; watermark-clean.lsp - Remove all watermark texts
;; Command: WMCLEAN
(defun c:WMCLEAN ( / ss n )
  (setq ss (ssget "_X" '((0 . "TEXT,MTEXT") (8 . "WATERMARK"))))
  (if ss
    (progn
      (setq n (sslength ss))
      (command "_.ERASE" ss "")
      (princ (strcat "\nRemoved " (itoa n) " watermark texts."))
    )
    (princ "\nNo watermark texts found.")
  )
  (princ)
)
