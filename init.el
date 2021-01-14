(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
 
;; Fixes some bugs that prevent package refresh 
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq package-check-signature nil)
(package-refresh-contents)

;; Install packages if not installed
(unless (package-installed-p 'evil)
  (package-install 'evil))
 
(unless (package-installed-p 'which-key)
  (package-install 'which-key))
 
(unless (package-installed-p 'ivy)
  (package-install 'ivy))
 
(unless (package-installed-p 'projectile)
  (package-install 'projectile))

(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))

(unless (package-installed-p 'company)
  (package-install 'company))

(unless (package-installed-p 'org)
  (package-install 'org))

;; Required to avoid string-trim being void in projectile
(require 'subr-x)

;; Enable some modes
(which-key-mode)
(evil-mode)
(ivy-mode)

(projectile-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Use undo tree for evil redo (Ctrl+R)
(global-undo-tree-mode)
(evil-set-undo-system 'undo-tree)

(add-hook 'after-init-hook 'global-company-mode)
 
;; Set backup files to single directory
(let ((dir "~/.emacs.d/backups/"))
  (unless (file-directory-p dir)
    (make-directory dir t)))
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))

;; Add org mode directory
(let ((dir "~/org/"))
  (unless (file-directory-p dir)
    (make-directory dir t))
  (setq org-directory dir))

;; Make timestamp when marking things as done in org-mode
(setq org-log-done 'time)
 
;; Disable start screen
(setq inhibit-startup-message t)
;; Disable tool bar
(tool-bar-mode -1)
;; Disable scrollbar
(scroll-bar-mode -1)
;; Show line number
(line-number-mode 1)
;; Show line number
(column-number-mode 1)
;; Show line numbers on side
(global-display-line-numbers-mode 1)
;; Highlight matching paren
(show-paren-mode 1)
;; Automatically update files if they change
(global-auto-revert-mode t)

;; So I can use big TAGS files
(setq large-file-warning-threshold 100000000)
(setq tags-add-tables nil)

;; eshell shortcut
(global-set-key (kbd "C-c e") 'eshell)

;; open init.el shortcut
(defun open-init ()
  "Edit emacs init file"
  (interactive)
  (find-file user-init-file))
(global-set-key (kbd "C-c i") 'open-init)

(setq indent-line-function 'insert-tab)
(setq c-default-style "linux")
(c-set-offset 'comment-intro 0)

;; 4 spaces for indent
;(setq-default indent-tabs-mode nil)
;(setq-default tab-width 4)
;(setq tab-stop-list (number-sequence 4 200 4))

;; 8 width tabs for indent
(setq-default tab-width 8)
(setq tab-stop-list (number-sequence 8 200 8))
(setq c-basic-offset 8)

;; Use custom file instead of custom-set-variables, custom-set-faces
(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (make-empty-file custom-file t))
(load custom-file)
