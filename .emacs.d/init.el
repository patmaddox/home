;; straight.el -- bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; packages
(straight-use-package 'elixir-mode)
(straight-use-package 'magit)
(straight-use-package 'typescript-mode)

;; org / agenda
(require 'ol) ; org-mode links

;; projectile
;(straight-use-package 'projectile)
;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;(projectile-mode +1)
