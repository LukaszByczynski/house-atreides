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
  package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                     ("org" . "https://orgmode.org/elpa/")
                     ("marmalade" . "https://marmalade-repo.org/packages/")
                     ("melpa-stable" . "https://stable.melpa.org/packages/")
                     ("marmalade" . "https://marmalade-repo.org/packages/")
                     ("melpa" . "https://melpa.org/packages/"))
                     ;; package-archive-priorities '(("melpa" . 1)))
  ))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
;; Enable defer and ensure by default for use-package
(setq ;;use-package-always-defer t
      use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global variables (prebuilt in emacs)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq
  inhibit-startup-screen t
  initial-scratch-message nil
  enable-local-variables t
  create-lockfiles nil
  ansi-color-for-comint-mode t
  make-backup-files nil
  load-prefer-newer t
  custom-file (expand-file-name "custom.el" user-emacs-directory)
  column-number-mode t
  ;; scroll-error-top-bottom t
  gc-cons-threshold 20000000
  large-file-warning-threshold 100000000
  user-full-name "Lukasz Byczynski")

;; buffer local variables
(setq-default
  fill-column 120
  indent-tabs-mode nil
  tab-width 2)

(put 'compilation-skip-threshold 'safe-local-variable #'integerp)

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

(add-hook 'prog-mode-hook
  (lambda () (setq show-trailing-whitespace t)))

;; protects against accidental mouse movements
;; http://stackoverflow.com/a/3024055/1041691
(add-hook 'mouse-leave-buffer-hook
  (lambda () (when (and (>= (recursion-depth) 1)
                  (active-minibuffer-window))
         (abort-recursive-edit))))

;; *scratch* is immortal
(add-hook 'kill-buffer-query-functions
  (lambda () (not (member (buffer-name) '("*scratch*" "scratch.el")))))

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
(global-linum-mode t)
(global-auto-composition-mode 0)
(auto-encryption-mode 0)
(tooltip-mode 0)
(save-place-mode 1)
(setq ring-bell-function #'ignore)

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
(add-text-properties (point-min) (point-max)
                     '(line-spacing 0.25 line-height 1.25))

;; paste fixes
(setq kill-ring-max 100)
(setq x-select-enable-clipboard t)
(setq select-active-regions t)
(setq save-interprogram-paste-before-kill 1)
(setq yank-pop-change-selection t)

;; unbind right alt
(setq ns-right-alternate-modifier nil)

(make-variable-buffer-local 'tags-file-name)
(make-variable-buffer-local 'show-paren-mode)

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))
(defun add-to-load-path (path)
  "Add PATH to LOAD-PATH if PATH exists."
  (when (file-exists-p path)
    (add-to-list 'load-path path)))
(add-to-load-path (expand-file-name "lisp" user-emacs-directory))

(add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))
;; WORKAROUND http://debbugs.gnu.org/cgi/bugreport.cgi?bug=16449
(add-hook 'nxml-mode-hook (lambda () (flyspell-mode -1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load my custom scripts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "packages.el")
(load-user-file "functions.el")
(load-user-file "scala.el")
(load-user-file "keymap.el")

;; Use emacs terminfo, not system terminfo
;;(setq system-uses-terminfo nil)

;; Use utf-8 in ansi-term
;;(defadvice ansi-term (after advise-ansi-term-coding-system)
;;    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
;;(ad-activate 'ansi-term)
