;; Enable scala-mode and sbt-mode
(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
 :init (setq lsp-prefer-flymake nil))

(use-package lsp-ui)

;; Add company-lsp backend for metals
(use-package company-lsp)

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
