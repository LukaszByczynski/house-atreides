(defun ensime-edit-definition-with-fallback (arg)
  "Variant of `ensime-edit-definition' with ctags if ENSIME is not available."
  (interactive "P")
  (unless (and (ensime-connection-or-nil)
               (ensime-edit-definition arg))
    (projectile-find-tag)))

(use-package scala-mode
  :pin melpa)
      
(use-package ensime
  :defer t
  :pin melpa
  ;; :pin melpa-stable
  :init
  (put 'ensime-auto-generate-config 'safe-local-variable #'booleanp)
  (setq
   ensime-startup-notification nil)
  :config
  (require 'ensime-expand-region)
  (add-hook 'git-timemachine-mode-hook (lambda () (ensime-mode 0)))

  (bind-key "<M-f3>" 'ensime-print-errors-at-point)
  (bind-key "M-RET" 'ensime-import-type-at-point)
  (bind-key "s-n" 'ensime-search ensime-mode-map)
  (bind-key "s-t" 'ensime-print-type-at-point ensime-mode-map))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :pin melpa
  :init
  (setq
   sbt:sbt-history-file ".history"
   sbt:ansi-support t
   sbt:prefer-nested-projects t
   sbt:scroll-to-bottom-on-output nil
   sbt:program-options '("-Djline.terminal=auto")
   sbt:default-command "test:compile")
  (put 'sbt:default-command 'safe-local-variable #'stringp)
  :config
  ;; WORKAROUND: https://github.com/hvesalai/sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)

  (bind-key "C-c F" 'ensime-sbt-do-fmt sbt:mode-map)
  (bind-key "S-<f12>" 'ensime sbt:mode-map)
  (bind-key "C-c c" 'sbt-command sbt:mode-map)
  (bind-key "C-c e" 'next-error sbt:mode-map))

(add-hook 'sbt-mode-hook
          (lambda ()
            (setq prettify-symbols-alist
                  `((,(expand-file-name (getenv "SBT_VOLATILE_TARGET")) . ?☣)
                    (,(expand-file-name (directory-file-name (projectile-project-root))) . ?§)
                    ("target/scala-2.12" . ?☢)
                    (,(expand-file-name "~") . ?~)))
            (prettify-symbols-mode t)))

(defcustom
  scala-mode-prettify-symbols
  '(("->" . ?→)
    ("<-" . ?←)
    ("=>" . ?⇒)
    ;;("<=" . ?≤)
    ;;(">=" . ?≥)
    ;;("!=" . ?≠)
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

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)
            (show-paren-mode)
    ;;        (focus-mode)
            (rainbow-mode)
            (prettify-symbols-mode)
            (eldoc-mode)
            (flycheck-mode)
            (yas-minor-mode)
            (company-mode)
            (smartparens-strict-mode)
            (rainbow-delimiters-mode)))

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
