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
(global-set-key (kbd "<f8>") 'neotree-toggle)

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

;; zoom text
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "M-m") 'resize-window)
