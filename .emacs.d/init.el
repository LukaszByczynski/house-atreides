;; global variables
(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
 global-linum-mode t
 whitespace-line-column 121
 sentence-end-double-space nil)

;; editor panels
(tool-bar-mode 0) 
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; only type `y` instead of `yes`
(fset `yes-or-no-p `y-or-n-p)

;; no tabs!
(setq-default indent-tabs-mode nil)

;; highlight current line
(global-hl-line-mode 1)
(show-paren-mode 1)

;; no wordwrap
(setq-default truncate-lines 1)

;; initial window frame position and size
(when (window-system)
  (set-frame-height (selected-frame) 60)
  (set-frame-position (selected-frame) 80 5)
  (set-frame-size (selected-frame) 180 50))

;; fix osx path
(setq exec-path (append exec-path '("/usr/local/bin")))

;; default font
(set-frame-font "Hack-12")
(text-scale-increase 2)  ;; 2 steps larger

;; paste fixes
(setq kill-ring-max 100) 
(setq x-select-enable-clipboard t) 
(setq select-active-regions t) 
(setq save-interprogram-paste-before-kill 1) 
(setq yank-pop-change-selection t)

;; unbind right alt
(setq ns-right-alternate-modifier nil)

;; ==============================================
;; use-package configuration and packages sources
;; ==============================================

;; Install use-package if necessary
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives (append package-archives
			       '(("melpa" . "http://melpa.org/packages/")
                                 ("melpa-stable" . "http://stable.melpa.org/packages/")
				 ("marmalade" . "http://marmalade-repo.org/packages/")
				 ("gnu" . "http://elpa.gnu.org/packages/")
				 ("elpy" . "http://jorgenschaefer.github.io/packages/"))))
;; Bootstrap `use-package'
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; ===================================
;; 3rdParty packages configuration
;; ===================================

;; evil mode
(use-package evil
  :demand)

;; helm configuration
(use-package helm
  :ensure t
  :bind(("M-x" . helm-M-x)
	("C-x C-m" . helm-M-x)
	("C-c C-m" . helm-M-x)
	("s-e"   . helm-mini)
	("M-s-~" . helm-find-files)))

;; monokai-theme
(use-package monokai-theme
  :ensure t)

;; ensime
(use-package ensime
  :ensure t
;;  :pin melpa-stable
  :commands ensime ensime-mode
  :init(setq
     ensime-startup-snapshot-notification nil
     ensime-startup-notification nil
  )
  :bind(("s-t" . ensime-search)
	("<M-RET>" . ensime-import-type-at-point)
	("<M-s-l>" . ensime-refactor-diff-organize-imports)))
(add-hook 'scala-mode-hook 'ensime-mode)

;; sbt
(use-package sbt-mode
  :ensure t
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

;; htmlize
(use-package htmlize
  :ensure t)

;; zoom-frame
(use-package zoom-frm
  :ensure t
  :bind(("C-=" . zoom-frm-in)
	("C--" . zoom-frm-out)))

;; projectile
(use-package projectile
  :ensure t
  :demand
  :init   (setq projectile-use-git-grep t)
  :config (projectile-global-mode t)
  :bind   (("s-f" . projectile-find-file)
           ("s-F" . projectile-grep)))

;; magit
(use-package magit
  :ensure t
  :commands magit-status magit-blame
  :init (setq magit-revert-buffers nil)
  :bind (("s-g" . magit-status)
         ("s-b" . magit-blame)))

;; project explorer
(use-package project-explorer
  :ensure t)

;; yaml mode
(use-package yaml-mode
  :ensure t)
(add-hook 'yaml-mode-hook
	  '(lambda ()
§	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; sass
(use-package scss-mode
  :ensure t
  )

;; uniquify
(use-package uniquify
  :ensure nil
  :config
  ;; buffernames that are foo<1>, foo<2> are hard to read. This makes them foo|dir  foo|otherdir
  (setq uniquify-buffer-name-style 'post-forward)
  ;; where to save auto-replace maps
  (setq abbrev-file-name "~/.emacs.d/abbrev_defs")
  )

;; yasnipet
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :commands yas-minor-mode
  :config (yas-reload-all))

;; autoupdate
(use-package auto-package-update
  :ensure t)

;; org-reval
(use-package ox-reveal
  :ensure t)

;; ditaa
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)))

;;
(global-unset-key (kbd "C-z"))
(use-package undo-tree
  :diminish undo-tree-mode
  :config (global-undo-tree-mode)
  :bind ("C-z" . undo-tree-visualize))

;; higlight symbol
(use-package highlight-symbol
  :ensure t
  :diminish highlight-symbol-mode
  :commands highlight-symbol
  :bind ("s-h" . highlight-symbol))

;; popum summary
(use-package popup-imenu
  :ensure t
  :commands popup-imenu
  :bind ("M-i" . popup-imenu))

;; completion
(use-package company
  :ensure t
  :diminish company-mode
  :commands company-mode
  :init
  (setq
   company-dabbrev-ignore-case nil
   company-dabbrev-code-ignore-case nil
   company-dabbrev-downcase nil
   company-idle-delay 0
   company-minimum-prefix-length 4)
  :config
  ;; disables TAB in company-mode, freeing it for yasnippet
  (define-key company-active-map [tab] nil)
  (define-key company-active-map (kbd "TAB") nil))

;; expand region
;;(use-package expand-region
;;  :commands 'er/expand-region
;;  :bind ("C-0" . er/expand-region))
;;(require 'ensime-expand-region)

;; ===================================
;; Keymap configuration
;; ===================================

;; Use F12 to switch between windowed and full-screen modes
(global-set-key (kbd "<f12>") 'toggle-frame-fullscreen)

;; buffer navigation
(global-set-key (kbd "M-]") 'next-buffer)
(global-set-key (kbd "M-[") 'previous-buffer)

;; window navigation
(global-unset-key (kbd "M-j"))
(global-unset-key (kbd "M-k"))
(global-set-key (kbd "M-j") (lambda () (interactive) (other-window 1)))
(global-set-key (kbd "M-k") (lambda () (interactive) (other-window -1)))

;; keymap rebindings
(global-set-key (kbd "<f8>") 'project-explorer-open)

;; switch two last buffers
(global-unset-key (kbd "<C-tab>"))
(global-set-key (kbd "<C-tab>") (lambda() (interactive) (switch-to-buffer (other-buffer (current-buffer) 1))))

;; move lines up and down
(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-unset-key (kbd "<M-up>"))
(global-set-key (kbd "<M-up>") 'move-line-up)
(global-unset-key (kbd "<M-down>"))
(global-set-key (kbd "<M-down>") 'move-line-down)


;; ===================================
;; Scala features
;; ===================================
(defvar scala-package-roots '("scala" "java"))

(defun scala-package-name ()
  "Determine current packge from directory structure"
  (interactive)
  (insert (labels ((search-root (stack path)
             (if (or (null path) (member (car path) scala-package-roots))
                 (mapconcat 'identity stack ".")
               (search-root (cons (car path) stack) (cdr path)))))
    (search-root '() (cdr (reverse (split-string (file-name-directory
                                                  buffer-file-name) "/")))))))

(defun scala-class-name ()
  "Determine the class name from the filename"
  (interactive)
  (insert (file-name-sans-extension (file-name-nondirectory buffer-file-name))))

(global-set-key (kbd "C-c C-s p") 'scala-package-name)
(global-set-key (kbd "C-c C-s c") 'scala-class-name)


;; org mode shift selection
(setq org-support-shift-select 't)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil ox-reveal auto-package-update scss-mode yaml-mode project-explorer magit projectile zoom-frm ensime monokai-theme helm use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; comments
(defun scala-mode-newline-comments ()
  "Custom newline appropriate for `scala-mode'."
  ;; shouldn't this be in a post-insert hook?
  (interactive)
  (newline-and-indent)
  (scala-indent:insert-asterisk-on-multiline-comment))

(bind-key "RET" 'scala-mode-newline-comments)
(setq comment-start "/*"
	  comment-end " */"
	  comment-style 'multi-line
	  comment-empty-lines t)

