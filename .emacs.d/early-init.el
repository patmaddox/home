;; disable package.el - needed for straight.el
(setq package-enable-at-startup nil)

;; org / agenda config
(setq org-agenda-files
      '("~/priv/org" "~/ratio/org"))

(setq org-todo-keywords
      '((sequence "TODO" "WAIT" "HOLD" "|" "DONE")))
