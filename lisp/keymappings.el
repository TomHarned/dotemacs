(general-create-definer global-lead-def
  ;; :prefix my-leader
  :prefix "SPC")

(general-create-definer local-lead-def
  ;; :prefix my-local-leader
  :prefix "SPC m")
;; TODO
;; open scracth buffer plain text
;; open elisp buffer
;; open pyton scripting buffer
;; See below for modes (esp org and python)


(global-lead-def
  :states '(normal visual)
  :keymaps 'override

  ;; General
  "SPC" 'counsel-M-x

  ;; Buffer Navigation
  "b" '(:ignore t :which-key "Buffer") ;
  "b b" 'switch-to-buffer
  "b d" 'kill-buffer
  "b D" 'kill-buffer-and-window

  ;; Window Navigation

  "w" '(:ignore t :which-key "Window") ;
  "w v" 'evil-window-vsplit
  "w s" 'evil-window-split
  "w d" 'evil-window-delete
  "w h" 'evil-window-left
  "w l" 'evil-window-right
  "w j" 'evil-window-down
  "w k" 'evil-window-up
  "o a" 'org-agenda

  ;; file navigation
  "f" '(:ignore t :which-key "File") ;
  "f f" 'counsel-find-file
  "f s" 'save-buffer
  "f S" 'write-file

  ;; help
  "h" '(:ignore t :which-key "Help") ;
  "h f" 'describe-function
  "h k" 'describe-key
  "h v" 'describe-variable
  "h i" 'info-emacs-manual
  "h I" 'info

  ;; Launching shells

  ":" 'shell-command
  ";" 'eval-expression
  "o" '(:ignore t :which-key "Open a program") ;
  "o e" 'eshell
  "o t" 'vterm

  ;; Magit
  "g" '(:ignore t :which-key "Magit") ;
  "g g" 'magit-status
  )

;; TODO
;; python
;; magit
;; org mode
;; lisp eval

;; ** Mode Keybindings
(local-lead-def
  :states '(normal visual)
  :keymaps '(lisp-mode-map emacs-lisp-mode-map)
  "m" '(:ignore t :which-key "Lisp")
  "e" '(:ignore t :which-key "Evaluate Lisp")
  "e e" 'pp-eval-last-sexp
  ;;"e E" 'eval-expression
  "e d" 'eval-defun
  "e p" 'eval-print-last-sexp
  ;; ...
  )
