;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://lists.gnu.org/archive/html/emacs-devel/2017-09/msg00211.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; User Site Local
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load (expand-file-name "local-preinit.el" user-emacs-directory) 'no-error)
(unless (boundp 'package--initialized)
  ;; don't set gnu/org/melpa if the site-local or local-preinit have
  ;; done so (e.g. firewalled corporate environments)
  (require 'package)
  (setq
  package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                     ("org" . "http://orgmode.org/elpa/")
                     ("melpa-stable" . "http://stable.melpa.org/packages/")
                     ("melpa" . "http://melpa.org/packages/"))
  package-archive-priorities '(("melpa-stable" . 1))))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global variables (prebuilt in emacs)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq
 inhibit-startup-screen t
 initial-scratch-message nil
 enable-local-variables t
 create-lockfiles nil
 make-backup-files nil
 load-prefer-newer t
 custom-file (expand-file-name "custom.el" user-emacs-directory)
 column-number-mode t
 scroll-error-top-bottom t
 gc-cons-threshold 20000000
 large-file-warning-threshold 100000000
 user-full-name "Lukasz Byczynski")

;; buffer local variables
(setq-default
  fill-column 120
  indent-tabs-mode nil
  tab-width 2)

;; newcomer modes
;(cua-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This section is for setup functions that are built-in to emacs
(defalias 'yes-or-no-p 'y-or-n-p)
(menu-bar-mode -1)
(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1))
(global-auto-revert-mode t)

;; highlight current line
(global-hl-line-mode 1)
(show-paren-mode 1)

;; no wordwrap
(setq-default truncate-lines 1)

;; initial window frame position and size
(when (window-system)
  (set-frame-height (selected-frame) 60)
  (set-frame-position (selected-frame) 60 0)
  (set-frame-size (selected-frame) 160 60))

;; fix osx path
(setq exec-path (append exec-path '("/usr/local/bin")))

;; default font
(set-frame-font "Iosevka-16")

;; paste fixes
(setq kill-ring-max 100)
(setq x-select-enable-clipboard t)
(setq select-active-regions t)
(setq save-interprogram-paste-before-kill 1)
(setq yank-pop-change-selection t)

;; unbind right alt
(setq ns-right-alternate-modifier nil)

(electric-indent-mode 0)
(remove-hook 'post-self-insert-hook
             'electric-indent-post-self-insert-function)
(remove-hook 'find-file-hooks 'vc-find-file-hook)
(global-linum-mode t)
(global-auto-composition-mode 0)
(auto-encryption-mode 0)
(tooltip-mode 0)
(save-place-mode 1)

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))
(defun add-to-load-path (path)
  "Add PATH to LOAD-PATH if PATH exists."
  (when (file-exists-p path)
    (add-to-list 'load-path path)))
(add-to-load-path (expand-file-name "lisp" user-emacs-directory))

(add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))
;; WORKAROUND http://debbugs.gnu.org/cgi/bugreport.cgi?bug=16449
(add-hook 'nxml-mode-hook (lambda () (flyspell-mode -1)))

;; mouse scrolling fix
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This section is for global settings for built-in packages that autoload
(setq
 help-window-select t
 show-paren-delay 0.5
 dabbrev-case-fold-search nil
 tags-case-fold-search nil
 tags-revert-without-query t
 tags-add-tables nil
 compilation-scroll-output 'first-error
 source-directory (getenv "EMACS_SOURCE")
 org-confirm-babel-evaluate nil
 nxml-slash-auto-complete-flag t
 sentence-end-double-space nil
 browse-url-browser-function 'browse-url-generic
 ediff-window-setup-function 'ediff-setup-windows-plain)

(setq-default
  c-basic-offset 4)

;; (add-hook 'prog-mode-hook
;;           (lambda () (setq show-trailing-whitespace t)))

;; protects against accidental mouse movements
;; http://stackoverflow.com/a/3024055/1041691
(add-hook 'mouse-leave-buffer-hook
          (lambda () (when (and (>= (recursion-depth) 1)
                           (active-minibuffer-window))
                  (abort-recursive-edit))))

;; *scratch* is immortal
(add-hook 'kill-buffer-query-functions
          (lambda () (not (member (buffer-name) '("*scratch*" "scratch.el")))))


;; ==============================================
;; use-package configuration and packages sources
;; ==============================================

;; Bootstrap `use-package'
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package)
)

;; Bootstrap use-package
(require 'use-package)

;; ===================================
;; 3rdParty packages configuration
  ;; ===================================

;; completion
(use-package company
  :diminish company-mode
  :commands company-mode
  :init
  (setq
   company-dabbrev-other-buffers t
   company-dabbrev-ignore-case nil
   company-dabbrev-code-ignore-case nil
   company-dabbrev-downcase nil
   company-dabbrev-minimum-length 4
   company-idle-delay 0
   company-minimum-prefix-length 4)
  :config
  ;; dabbrev is too slow, use C-TAB explicitly or add back on per-mode basis
  (delete 'company-dabbrev company-backends)
  ;; disables TAB in company-mode (too many conflicts)
  (define-key company-active-map [tab] nil)
  (define-key company-active-map (kbd "TAB") nil))

;; helm configuration
(use-package helm
  :ensure t
  :bind(("M-x" . helm-M-x)
	("C-x C-m" . helm-M-x)
	("C-c C-m" . helm-M-x)
	("s-e"   . helm-mini)
	("s-n" . helm-find-files)))

;; monokai-theme
(use-package monokai-theme
  :ensure t)

;; HASKELL
(use-package intero
  :ensure t
  :init
  (add-hook 'haskell-mode-hook #'intero-mode)
  :config
    (progn
      (add-hook 'haskell-mode-hook 'intero-mode)
      (add-hook 'haskell-mode-hook 'company-mode)
      (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
    )
  )

(use-package haskell-mode
  :defer t
  :init
  (add-hook 'haskell-mode-hook #'haskell-doc-mode)
  (add-hook 'haskell-mode-hook #'haskell-decl-scan-mode)
  (setq haskell-process-suggest-add-package nil
        haskell-ask-also-kill-buffers nil
        haskell-stylish-on-save t
        haskell-process-auto-import-loaded-modules t
        haskell-process-log t
        haskell-interactive-popup-errors nil)
  (add-hook 'haskell-mode-hook (lambda () (whitespace-toggle-options 'tabs)))
)

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

;; autoupdate
(use-package auto-package-update
  :ensure t)

;; popum summary
(use-package popup-imenu
  :ensure t
  :commands popup-imenu
  :bind ("M-i" . popup-imenu))

(use-package rainbow-mode
  :diminish rainbow-mode
  :commands rainbow-mode)


;; ;; evil mode
;; (use-package evil
;;   :demand)
;;
;;

;;
;; ;; ensime
;; (use-package ensime
;;   :ensure t
;; ;;  :pin melpa-stable
;;   :commands ensime ensime-mode
;;   :init(setq
;;      ensime-startup-snapshot-notification nil
;;      ensime-startup-notification nil
;;   )
;;   :bind(("s-t" . ensime-search)
;; 	("<M-RET>" . ensime-import-type-at-point)
;; 	("<M-s-l>" . ensime-refactor-diff-organize-imports)))
;; (add-hook 'scala-mode-hook 'ensime-mode)
;;
;; ;; sbt
;; (use-package sbt-mode
;;   :ensure t
;;   :commands sbt-start sbt-command
;;   :config
;;   ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
;;   ;; allows using SPACE when in the minibuffer
;;   (substitute-key-definition
;;    'minibuffer-complete-word
;;    'self-insert-command
;;    minibuffer-local-completion-map))
;;

;; htmlize
(use-package htmlize
  :ensure t)

;; yaml mode
(use-package yaml-mode
  :ensure t)
(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; sass
(use-package scss-mode
  :ensure t
  )
;;
;; ;; uniquify
;; (use-package uniquify
;;   :ensure nil
;;   :config
;;   ;; buffernames that are foo<1>, foo<2> are hard to read. This makes them foo|dir  foo|otherdir
;;   (setq uniquify-buffer-name-style 'post-forward)
;;   ;; where to save auto-replace maps
;;   (setq abbrev-file-name "~/.emacs.d/abbrev_defs")
;;   )
;;
;; ;; yasnipet
;; (use-package yasnippet
;;   :ensure t
;;   :diminish yas-minor-mode
;;   :commands yas-minor-mode
;;   :config (yas-reload-all))

;; org-reval
(use-package ox-reveal
  :ensure t)

;; ditaa
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)))

;; undo tree
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

;; expand region
(use-package expand-region
  :commands 'er/expand-region
  :bind ("C-=" . er/expand-region))

(use-package goto-chg
  :commands goto-last-change
  ;; complementary to
  ;; C-x r m / C-x r l
  ;; and C-<space> C-<space> / C-u C-<space>
  :bind (("C-." . goto-last-change)
         ("C-," . goto-last-change-reverse)))

(use-package git-gutter
  :diminish git-gutter-mode
  :commands git-gutter-mode)


;; ===================================
;; Keymap configuration
;; ===================================

;; Use F12 to switch between windowed and full-screen modes
(global-set-key (kbd "<f12>") 'toggle-frame-fullscreen)

;; buffer navigation
(global-set-key (kbd "M-]") 'next-buffer)
(global-set-key (kbd "M-[") 'previous-buffer)

;; ;; window navigation
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


;; ;; ===================================
;; ;; Scala features
;; ;; ===================================
;; (defvar scala-package-roots '("scala" "java"))
;;
;; (defun scala-package-name ()
;;   "Determine current packge from directory structure"
;;   (interactive)
;;   (insert (labels ((search-root (stack path)
;;              (if (or (null path) (member (car path) scala-package-roots))
;;                  (mapconcat 'identity stack ".")
;;                (search-root (cons (car path) stack) (cdr path)))))
;;     (search-root '() (cdr (reverse (split-string (file-name-directory
;;                                                   buffer-file-name) "/")))))))
;;
;; (defun scala-class-name ()
;;   "Determine the class name from the filename"
;;   (interactive)
;;   (insert (file-name-sans-extension (file-name-nondirectory buffer-file-name))))
;;
;; (global-set-key (kbd "C-c C-s p") 'scala-package-name)
;; (global-set-key (kbd "C-c C-s c") 'scala-class-name)
;;
;;
;; ;; org mode shift selection
;; (setq org-support-shift-select 't)
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(package-selected-packages
;;    (quote
;;     (evil ox-reveal auto-package-update scss-mode yaml-mode project-explorer magit projectile zoom-frm ensime monokai-theme helm use-package))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
;;
;;
;; ;; comments
;; (defun scala-mode-newline-comments ()
;;   "Custom newline appropriate for `scala-mode'."
;;   ;; shouldn't this be in a post-insert hook?
;;   (interactive)
;;   (newline-and-indent)
;;   (scala-indent:insert-asterisk-on-multiline-comment))
;;
;; (bind-key "RET" 'scala-mode-newline-comments)
;; (setq comment-start "/*"
;; 	  comment-end " */"
;; 	  comment-style 'multi-line
;; 	  comment-empty-lines t)
;; (custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(package-selected-packages (quote (monokai-theme helm use-package))))
;; (custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; )
