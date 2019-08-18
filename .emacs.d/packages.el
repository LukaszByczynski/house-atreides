;; helm configuration
(use-package helm
  :bind(("M-x" . helm-M-x)
    ("C-x C-m" . helm-M-x)
    ("C-c C-m" . helm-M-x)
    ("s-e"   . helm-mini)
    ("s-N" . helm-find-files)))

;; monokai-theme
(use-package monokai-pro-theme)

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

 ;; sidebar and status bar
 (use-package all-the-icons)
 (use-package neotree
   :init (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
   :config (setq neo-autorefresh nil)) ;; Stopping Neotree from constantly switching to the open file's directory

 (use-package smart-mode-line
   :config
   (setq sml/no-confirm-load-theme t)
   (sml/setup))

;; autoupdate
(use-package auto-package-update)

;; popum summary
(use-package popup-imenu
  :commands popup-imenu
  :bind ("M-i" . popup-imenu))

(use-package color-moccur
  :bind (("s-o" . moccur)
         :map isearch-mode-map
         ("M-o" . isearch-moccur)
         ("M-O" . isearch-moccur-all)))

(use-package nyan-mode
  :init (progn (nyan-mode 1))
  )

(use-package highlight-symbol
  :diminish highlight-symbol-mode
  :commands highlight-symbol
  :bind ("s-h" . highlight-symbol))

(use-package expand-region
  :commands 'er/expand-region
  :bind ("C-=" . er/expand-region))

(use-package goto-chg
  :commands goto-last-change
  :bind (("C-." . goto-last-change)
         ("C-," . goto-last-change-reverse)))

(use-package git-gutter
  :diminish git-gutter-mode
  :commands git-gutter-mode)

(use-package magit
  :commands magit-status magit-blame
  :init (setq
        git-commit-style-convention-checks nil)
  :bind (("s-g" . magit-status)
        ("s-b" . magit-blame)))

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

(use-package git-gutter
  :diminish git-gutter-mode
  :commands git-gutter-mode)

(use-package magit
  :commands magit-status magit-blame
  :init (setq
        git-commit-style-convention-checks nil)
  :bind (("s-g" . magit-status)
        ("s-b" . magit-blame)))

(use-package git-timemachine
  :commands git-timemachine
  :init (setq
        git-timemachine-abbreviation-length 4))

(use-package etags-select
  :commands etags-select-find-tag)

(use-package ag
  :commands ag
  :init (setq ag-reuse-window 't)
  :config
  (add-hook 'ag-search-finished-hook
           (lambda () (pop-to-buffer next-error-last-buffer))))

(use-package tidy
  :commands tidy-buffer)

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

(use-package flyspell
  :commands flyspell-mode
  :diminish flyspell-mode
  :init (setq
        ispell-dictionary "british"
        flyspell-prog-text-faces '(font-lock-doc-face))
  :config
  (bind-key "C-." nil flyspell-mode-map)
  ;; the correct way to set flyspell-generic-check-word-predicate
  (put #'text-mode #'flyspell-mode-predicate #'text-flyspell-predicate))

(defun text-flyspell-predicate ()
 "Ignore acronyms and anything starting with 'http' or 'https'."
 (save-excursion
   (let ((case-fold-search nil))
     (forward-whitespace -1)
     (when
         (or
          (equal (point) (line-beginning-position))
          (looking-at " "))
       (forward-char))
     (not
      (looking-at "\\([[:upper:]]+\\|https?\\)\\b")))))

(use-package smartparens
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

  ;; WORKAROUND https://github.com/Fuco1/smartparens/issues/543
  (bind-key "C-<left>" nil smartparens-mode-map)
  (bind-key "C-<right>" nil smartparens-mode-map)

  (bind-key "s-<delete>" 'sp-kill-sexp smartparens-mode-map)
  (bind-key "s-<backspace>" 'sp-backward-kill-sexp smartparens-mode-map))

(use-package rainbow-mode
  :diminish rainbow-mode
  :commands rainbow-mode)

(use-package rainbow-delimiters
  :diminish rainbow-delimiters-mode
  :commands rainbow-delimiters-mode)

(use-package eldoc
  :ensure nil
  :diminish eldoc-mode
  :commands eldoc-mode)

(use-package yasnippet
  :diminish yas-minor-mode
  :commands yas-minor-mode
  :config (yas-reload-all))

(use-package expand-region
  :commands 'er/expand-region
  :bind ("C-=" . er/expand-region))

(use-package yatemplate
  :defer 2 ;; WORKAROUND https://github.com/mineo/yatemplate/issues/3
  :config
  (auto-insert-mode)
  (setq auto-insert-alist nil)
  (yatemplate-fill-alist))

(use-package whitespace
  :commands whitespace-mode
  :diminish whitespace-mode
  :init
  ;; BUG: https://emacs.stackexchange.com/questions/7743
  (put 'whitespace-style 'safe-local-variable #'listp)
  (put 'whitespace-line-column 'safe-local-variable #'integerp)
  (setq whitespace-style '(face trailing tabs)
        ;; add `lines-tail' to report long lines
        ;; github source code viewer overflows ~120 chars
        whitespace-line-column 120))
(defun whitespace-mode-with-local-variables ()
  "A variant of `whitespace-mode' that can see local variables."
  ;; WORKAROUND https://emacs.stackexchange.com/questions/7743
  (add-hook 'hack-local-variables-hook 'whitespace-mode nil t))


(use-package web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scala.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(use-package resize-window)
