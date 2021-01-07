(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
 
;; can't refresh packages without this 
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;;(package-refresh-contents)

(unless (package-installed-p 'evil)
  (package-install 'evil))
 
(unless (package-installed-p 'which-key)
  (package-install 'which-key))
 
(unless (package-installed-p 'ivy)
  (package-install 'ivy))
 
(unless (package-installed-p 'projectile)
  (package-install 'projectile))
 
(unless (package-installed-p 'neotree)
  (package-install 'neotree))
 
;; Required to avoid string-trim being void in projectile
(require 'subr-x)
 
(require 'which-key)
(which-key-mode 1)
 
(require 'evil)
(evil-mode 1)
 
(require 'ivy)
(ivy-mode 1)
 
(require 'projectile) 
(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
 
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)
;; Open neotree when projectile switches project
(setq projectile-switch-project-action 'neotree-projectile-action)
;; Remap evil keys for neotree buffer
(add-hook 'neotree-mode-hook
	  (lambda ()
	    (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
	    (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
(define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
    (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
 
;; Set backup files to single directory
(let ((dir "~/.emacs.d/backups/"))
  (unless (file-directory-p dir)
    (make-directory dir t)))
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))
 
;; Disable start screen
(setq inhibit-startup-message t)
;; Disable tool bar
(tool-bar-mode -1)
;; Disable scrollbar
(scroll-bar-mode -1)
;; Show line number
(line-number-mode 1)
;; Highlight matching paren
(show-paren-mode 1)
;; 8 tab width
(setq-default tab-width 8)
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'after-init-hook (prin1 (format "Boot time: %s" emacs-init-time)))
