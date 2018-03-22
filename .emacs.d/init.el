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
                     ("marmalade" . "http://marmalade-repo.org/packages/")
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

(electric-indent-mode 0)
(remove-hook 'post-self-insert-hook
             'electric-indent-post-self-insert-function)
(remove-hook 'find-file-hooks 'vc-find-file-hook)


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
(set-frame-font "Iosevka-16:linespace=120")

;; paste fixes
(setq kill-ring-max 100)
(setq x-select-enable-clipboard t)
(setq select-active-regions t)
(setq save-interprogram-paste-before-kill 1)
(setq yank-pop-change-selection t)

;; unbind right alt
(setq ns-right-alternate-modifier nil)

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

;; completion -> company
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
;;(use-package zoom-frm
;;  :ensure t
;;  :bind(
;;        ("C-+" . zoom-frm-in)
;;        ("C--" . zoom-frm-out))
;;  )

(use-package projectile
  :pin melpa ;; for changes to ag-ignore
  :demand
  ;; nice to have it on the modeline
  :init
  ;; WORKAROUND https://github.com/Wilfred/ag.el/issues/141
  (make-variable-buffer-local 'ag-ignore-list)
  (put 'ag-ignore-list 'safe-local-variable #'listp)
  (setq
   projectile-tags-backend 'etags-select
   projectile-use-git-grep t
   projectile-globally-ignored-files '("TAGS" "*.min.js"))
  :config
  (projectile-global-mode)
  (add-hook 'projectile-grep-finished-hook
            ;; not going to the first hit?
            (lambda () (pop-to-buffer next-error-last-buffer)))
  :bind
  (("s-f" . projectile-find-file)
   ("s-F" . projectile-ag)))

;; magit
(use-package magit
  :ensure t
  :commands magit-status magit-blame
  :init (setq magit-revert-buffers nil)
  :bind (("s-g" . magit-status)
         ("s-b" . magit-blame)))

;; project explorer
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (use-package treemacs-evil
      :ensure t
      :demand t)
    (setq treemacs-change-root-without-asking nil
          treemacs-collapse-dirs              (if (executable-find "python") 3 0)
          treemacs-file-event-delay           5000
          treemacs-follow-after-init          t
          treemacs-follow-recenter-distance   0.1
          treemacs-goto-tag-strategy          'refetch-index
          treemacs-indentation                2
          treemacs-indentation-string         " "
          treemacs-is-never-other-window      nil
          treemacs-never-persist              nil
          treemacs-no-png-images              nil
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow  nil
          treemacs-show-hidden-files          t
          treemacs-silent-filewatch           nil
          treemacs-silent-refresh             nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-tag-follow-cleanup         t
          treemacs-tag-follow-delay           1.5
          treemacs-width                      35)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'extended))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ([f8]         . treemacs-toggle)
        ("M-0"        . treemacs-select-window)
        ("C-c 1"      . treemacs-delete-other-windows)))
        ;;("M-m fT"     . treemacs)
        ;;("M-m fB"     . treemacs-bookmark)
        ;;("M-m f C-t"  . treemacs-find-file)
        ;;("M-m f M-t"  . treemacs-find-tag)))

(use-package treemacs-projectile
  :defer t
  :ensure t
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header)
 )
  ;;:bind (:map global-map
    ;;          ("M-m fP" . treemacs-projectile)
    ;;          ("M-m fp" . treemacs-projectile-toggle)))

;; autoupdate
(use-package auto-package-update
  :ensure t)

;; popum summary
(use-package popup-imenu
  :ensure t
  :commands popup-imenu
  :bind ("M-<F12>" . popup-imenu))

(use-package rainbow-mode
  :diminish rainbow-mode
  :commands rainbow-mode)

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

(use-package git-timemachine
  :commands git-timemachine
  :init (setq
         git-timemachine-abbreviation-length 4))

(use-package etags-select
  :commands etags-select-find-tag)

(use-package ag
  :commands ag
  :init
  (setq ag-reuse-window 't)
  :config
  (add-hook 'ag-search-finished-hook
            (lambda () (pop-to-buffer next-error-last-buffer))))

(use-package rainbow-mode
  :diminish rainbow-mode
  :commands rainbow-mode)

(use-package color-moccur
  :bind (("s-o" . moccur)
         :map isearch-mode-map
         ("M-o" . isearch-moccur)
         ("M-O" . isearch-moccur-all)))

(use-package nyan-mode
  :ensure t
  :init (progn (nyan-mode 1))
  )

(use-package smartparens
 :pin melpa
 :diminish smartparens-mode
 :commands
 smartparens-strict-mode
 smartparens-mode
 sp-restrict-to-pairs-interactive
 sp-local-pair
 :init
 (setq sp-interactive-dwim t)
 :config
 (require 'smartparens-config)
 (sp-use-smartparens-bindings)
 (sp-pair "(" ")" :wrap "C-(") ;; how do people live without this?
 (sp-pair "[" "]" :wrap "s-[") ;; C-[ sends ESC
 (sp-pair "{" "}" :wrap "C-{")
 ;;(sp-pair "<" ">" :wrap "C-<") ;; https://github.com/Fuco1/smartparens/issues/816

 ;; nice whitespace / indentation when creating statements
 (sp-local-pair '(c-mode java-mode) "(" nil :post-handlers '(("||\n[i]" "RET")))
 (sp-local-pair '(c-mode java-mode) "{" nil :post-handlers '(("||\n[i]" "RET")))
 (sp-local-pair '(java-mode) "<" nil :post-handlers '(("||\n[i]" "RET")))

 ;; WORKAROUND https://github.com/Fuco1/smartparens/issues/543
 (bind-key "C-<left>" nil smartparens-mode-map)
 (bind-key "C-<right>" nil smartparens-mode-map)

 (bind-key "s-{" 'sp-rewrap-sexp smartparens-mode-map)

 (bind-key "s-<delete>" 'sp-kill-sexp smartparens-mode-map)
 (bind-key "s-<backspace>" 'sp-backward-kill-sexp smartparens-mode-map)
 (bind-key "s-<home>" 'sp-beginning-of-sexp smartparens-mode-map)
 (bind-key "s-<end>" 'sp-end-of-sexp smartparens-mode-map)
 (bind-key "s-<left>" 'sp-beginning-of-previous-sexp smartparens-mode-map)
 (bind-key "s-<right>" 'sp-next-sexp smartparens-mode-map)
 (bind-key "s-<up>" 'sp-backward-up-sexp smartparens-mode-map)
 (bind-key "s-<down>" 'sp-down-sexp smartparens-mode-map))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This section is for generic interactive convenience methods.
;; Arguably could be uploaded to MELPA as package 'fommil-utils.
;; References included where shamelessly stolen.
(defun indent-buffer ()
  "Indent the entire buffer."
  (interactive)
  (save-excursion
    (delete-trailing-whitespace)
    (indent-region (point-min) (point-max) nil)
    (untabify (point-min) (point-max))))

(defun unfill-paragraph (&optional region)
  ;; http://www.emacswiki.org/emacs/UnfillParagraph
  "Transforms a paragraph in REGION into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil region)))

(defun unfill-buffer ()
  "Unfill the buffer for function `visual-line-mode'."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region 0 (point-max))))

(defun revert-buffer-no-confirm ()
  ;; http://www.emacswiki.org/emacs-en/download/misc-cmds.el
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer t t))

(defun contextual-backspace ()
  "Hungry whitespace or delete word depending on context."
  (interactive)
  (if (looking-back "[[:space:]\n]\\{2,\\}" (- (point) 2))
      (while (looking-back "[[:space:]\n]" (- (point) 1))
        (delete-char -1))
    (cond
     ((and (boundp 'smartparens-strict-mode)
           smartparens-strict-mode)
      (sp-backward-kill-word 1))
     (subword-mode
      (subword-backward-kill 1))
     (t
      (backward-kill-word 1)))))

(defun exit ()
  "Short hand for DEATH TO ALL PUNY BUFFERS!"
  (interactive)
  (if (daemonp)
      (message "You silly")
    (save-buffers-kill-emacs)))

(defun safe-kill-emacs ()
  "Only exit Emacs if this is a small session, otherwise prompt."
  (interactive)
  (if (daemonp)
      ;; intentionally not save-buffers-kill-terminal as it has an
      ;; impact on other client sessions.
      (delete-frame)
    ;; would be better to filter non-hidden buffers
    (let ((count-buffers (length (buffer-list))))
      (if (< count-buffers 11)
          (save-buffers-kill-emacs)
        (message-box "use 'M-x exit'")))))

(defun declare-buffer-bankruptcy ()
  "Declare buffer bankruptcy and clean up everything using `midnight'."
  (interactive)
  (let ((clean-buffer-list-delay-general 0)
        (clean-buffer-list-delay-special 0))
    (clean-buffer-list)))


(defvar ido-buffer-whitelist
  '("^[*]\\(notmuch\\-hello\\|unsent\\|ag search\\|grep\\|eshell\\).*")
  "Whitelist regexp of `clean-buffer-list' buffers to show when switching buffer.")
(defun midnight-clean-or-ido-whitelisted (name)
  "T if midnight is likely to kill the buffer named NAME, unless whitelisted.
Approximates the rules of `clean-buffer-list'."
  (require 'midnight)
  (require 'dash)
  (cl-flet* ((buffer-finder (regexp) (string-match regexp name))
             (buffer-find (regexps) (-partial #'-find #'buffer-finder)))
    (and (buffer-find clean-buffer-list-kill-regexps)
         (not (or (buffer-find clean-buffer-list-kill-never-regexps)
                  (buffer-find ido-buffer-whitelist))))))

(defun company-or-dabbrev-complete ()
  "Force a `company-complete', falling back to `dabbrev-expand'."
  (interactive)
  (if company-mode
      (company-complete)
    (call-interactively 'dabbrev-expand)))

(defun company-backends-for-buffer ()
  "Calculate appropriate `company-backends' for the buffer.
For small projects, use TAGS for completions, otherwise use a
very minimal set."
  (projectile-visit-project-tags-table)
  (cl-flet ((size () (buffer-size (get-file-buffer tags-file-name))))
    (let ((base '(company-keywords company-dabbrev-code company-files)))
      (if (and tags-file-name (<= 20000000 (size)))
          (list (push 'company-etags base))
        (list base)))))

(defun sp-restrict-c (sym)
  "Smartparens restriction on `SYM' for C-derived parenthesis."
  (sp-restrict-to-pairs-interactive "{([" sym))

(defun plist-merge (&rest plists)
  "Create a single property list from all PLISTS.
Inspired by `org-combine-plists'."
  (let ((rtn (pop plists)))
    (dolist (plist plists rtn)
      (setq rtn (plist-put rtn
                           (pop plist)
                           (pop plist))))))

(defun dot-emacs ()
  "Go directly to .emacs, do not pass Go, do not collect $200."
  (interactive)
  (message "Stop procrastinating and do some work!")
  (find-file "~/.emacs.d/init.el"))

(defun display-ansi-colors ()
  "When opening a log file with ANSI escapes."
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))


;; ===================================
;; Keymap configuration
;; ===================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This section is for overriding common emacs keybindings with tweaks.
(global-unset-key (kbd "C-z")) ;; I hate you so much C-z
(global-set-key (kbd "C-x C-c") 'safe-kill-emacs)
(global-set-key (kbd "C-<backspace>") 'contextual-backspace)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-.") 'projectile-find-tag)
(global-set-key (kbd "M-,") 'pop-tag-mark)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This section is for defining commonly invoked commands that deserve
;; a short binding instead of their packager's preferred binding.
(global-set-key (kbd "C-<tab>") 'company-or-dabbrev-complete)
(global-set-key (kbd "s-r") 'replace-string)
(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)
(global-set-key (kbd "M-Q") 'unfill-paragraph)
(global-set-key (kbd "<f6>") 'dot-emacs)

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


;; ===================================
;; Scala features
;; ===================================
(defvar scala-package-roots '("scala" "java"))

;; Java / Scala support for templates
(defun mvn-package-for-buffer ()
  "Calculate the expected package name for the buffer;
assuming it is in a maven-style project."
  ;; see https://github.com/fommil/dotfiles/issues/66
  (let* ((kind (file-name-extension buffer-file-name))
         (root (locate-dominating-file default-directory kind)))
    (when root
      (require 'subr-x) ;; maybe we should just use 's
      (let ((calculated (replace-regexp-in-string
                         (regexp-quote "/") "."
                         (string-remove-suffix "/"
                                               (string-remove-prefix
                                                (expand-file-name (concat root "/" kind "/"))
                                                default-directory))
                         nil 'literal)))
        (unless (or (null calculated)
                    (string= "" calculated)
                    (s-starts-with-p "." calculated))
          calculated)))))

(defun scala-mode-newline-comments ()
  "Custom newline appropriate for `scala-mode'."
  ;; shouldn't this be in a post-insert hook?
  (interactive)
  (newline-and-indent)
  (scala-indent:insert-asterisk-on-multiline-comment))

(defun c-mode-newline-comments ()
  "Newline with indent and preserve multiline comments."
  (interactive)
  (c-indent-new-comment-line)
  (indent-according-to-mode))

(defun ensime-sbt-do-fmt ()
  "WORKAROUND https://github.com/ensime/ensime-emacs/issues/635"
  (interactive)
  ;; addCommandAlias("fmt", ";scalafmt ;test:scalafmt ;it:scalafmt")
  (sbt:command "fmt"))

(use-package scala-mode
  :defer t
  :init
  (setq-default yatemplate-scala-header-skip nil)
  (put 'yatemplate-scala-header-skip 'safe-local-variable #'booleanp)
  (setq
   scala-indent:use-javadoc-style t
   scala-indent:align-parameters t)
  :config

  ;; prefer smartparens for parens handling
  (remove-hook 'post-self-insert-hook
               'scala-indent:indent-on-parentheses)

  (bind-key "RET" 'scala-mode-newline-comments scala-mode-map)
  (bind-key "s-<delete>" (sp-restrict-c 'sp-kill-sexp) scala-mode-map)
  (bind-key "s-<backspace>" (sp-restrict-c 'sp-backward-kill-sexp) scala-mode-map)
  (bind-key "s-<home>" (sp-restrict-c 'sp-beginning-of-sexp) scala-mode-map)
  (bind-key "s-<end>" (sp-restrict-c 'sp-end-of-sexp) scala-mode-map)
  ;; BUG https://github.com/Fuco1/smartparens/issues/468
  ;; backwards/next not working particularly well

  ;; i.e. bypass company-mode
  (bind-key "C-<tab>" 'dabbrev-expand scala-mode-map)

  ;; (bind-key "<f12>" 'sbt-start scala-mode-map)
  ;; (bind-key "S-<f12>" 'ensime scala-mode-map)
  (bind-key "C-c c" 'sbt-command scala-mode-map)
  (bind-key "C-c e" 'next-error scala-mode-map))

(defun ensime-edit-definition-with-fallback (arg)
  "Variant of `ensime-edit-definition' with ctags if ENSIME is not available."
  (interactive "P")
  (unless (and (ensime-connection-or-nil)
               (ensime-edit-definition arg))
    (projectile-find-tag)))

(use-package ensime
  :defer t
  :init
  (put 'ensime-auto-generate-config 'safe-local-variable #'booleanp)
  (setq
   ensime-startup-notification nil)
  :config
  (require 'ensime-expand-region)
  (add-hook 'git-timemachine-mode-hook (lambda () (ensime-mode 0)))
  (setq ensime-search-interface 'helm)

  (bind-key "C-c C-v F" 'ensime-sbt-do-fmt scala-mode-map)

  (bind-key "s-n" 'ensime-search ensime-mode-map)
  (bind-key "s-t" 'ensime-type-at-point ensime-mode-map))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :init
  (setq
   sbt:sbt-history-file ".history"
   sbt:ansi-support t
   sbt:prefer-nested-projects t
   sbt:scroll-to-bottom-on-output nil
   sbt:default-command "test:compile")
  (put 'sbt:default-command 'safe-local-variable #'stringp)
  :config
  ;; WORKAROUND: https://github.com/hvesalai/sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)

  ;; (bind-key "S-<f12>" 'ensime sbt:mode-map)
  (bind-key "C-c c" 'sbt-command sbt:mode-map)
  (bind-key "C-c e" 'next-error sbt:mode-map))

(defcustom
  scala-mode-prettify-symbols
  '(;;("->" . ?→)
    ;;("<-" . ?←)
    ;;("=>" . ?⇒)
    ;; ("<=" . ?≤)
    ;; (">=" . ?≥)
    ;; ("!=" . ?≠)
    ;; implicit https://github.com/chrissimpkins/Hack/issues/214
    ;;("+-" . ?±)
    ;; https://contributors.scala-lang.org/t/proposed-syntax-for--root-/1035/78?u=fommil
    ("_root_." . ?/)
    )
  "Prettify symbols for scala-mode.")

(add-hook 'scala-mode-hook
          (lambda ()
            (whitespace-mode-with-local-variables)
            (show-paren-mode t)
            (smartparens-mode t)
            (yas-minor-mode t)
            (git-gutter-mode t)
            (company-mode t)
            (setq prettify-symbols-alist scala-mode-prettify-symbols)
            (prettify-symbols-mode t)
            (scala-mode:goto-start-of-code)))

(add-hook 'ensime-mode-hook
          (lambda ()
            ;; needs to be here to override the default
            (bind-key "M-." 'ensime-edit-definition-with-fallback ensime-mode-map)
            (let ((backends (company-backends-for-buffer)))
              (setq company-backends (cons 'ensime-company backends)))))

;;..............................................................................
;; Java
(use-package cc-mode
  :ensure nil
  :config
  (bind-key "C-c c" 'sbt-command java-mode-map)
  (bind-key "C-c e" 'next-error java-mode-map)
  (bind-key "RET" 'c-mode-newline-comments java-mode-map))

(add-hook 'java-mode-hook
          (lambda ()
            (whitespace-mode-with-local-variables)
            (show-paren-mode t)
            (smartparens-mode t)
            (yas-minor-mode t)
            (git-gutter-mode t)
            (company-mode t)
            (ensime-mode t)))


;;..............................................................................
;; C
(add-hook 'c-mode-hook (lambda ()
                         (yas-minor-mode t)
                         (company-mode t)
                         (smartparens-mode t)))

