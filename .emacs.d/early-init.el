;; disable package.el - needed for straight.el
(setq package-enable-at-startup nil)

;; org / agenda config
(defun pat-org-all ()
  (interactive)
  (setq org-agenda-files
	'("~/priv/org/pat.org" "~/ratio/org/ratio.org")))

(pat-org-all)

(defun pat-org-personal ()
  (interactive)
  (setq org-agenda-files
	'("~/priv/org/pat.org")))

(defun pat-org-ratio ()
  (interactive)
  (setq org-agenda-files
	'("~/ratio/org/ratio.org")))

(setq org-todo-keywords
      '((sequence "TODO" "WAIT" "HOLD" "|" "DONE")))
