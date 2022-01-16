;;; Keymapping --- Summary
;; This file contains keybindings made with the general.el package. This purpose
;; is to rely on the space key as a leader  to reduce the amount of chording
;; required and to make the keybindings more similar to doom/spacemacs


;;; Commentary:
;; This is a work in progress.  We're starting with the most commonly-used
;; commands.  The point here is NOT to reproduce all of the doom keybindings, but
;; rather to make the day-to-day editing experience more ergonomic


;;; Code:

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
  :states 'normal
  :keymaps 'override
  ;; General

  "SPC" 'counsel-M-x
  ;; Buffer Navigation
  "b" '(:ignore t :which-key "Buffer") ;
  "m" '(:ignore t :which-key "Local Leader") ;
  "b b" 'switch-to-buffer
  "b d" 'kill-current-buffer
  "b D" 'kill-buffer
  "b W" 'kill-buffer-and-window
  "b n" 'next-buffer
  "b p" 'previous-buffer
  "b s" 'th-goto-scratch-buffer
  "b S" 'th-goto-scratch-buffer-here
  "b m" '(:ignore t :which-key "Bookmarks") ;
  "b m l" 'bookmark-bmenu-list
  "b m s" 'bookmark-set

  ;;
  ;; Window Navigation
  "w" '(:ignore t :which-key "Window") ;
  "w v" 'evil-window-vsplit
  "w s" 'evil-window-split
  "w d" 'evil-window-delete
  "w h" 'evil-window-left
  "w l" 'evil-window-right
  "w j" 'evil-window-down
  "w k" 'evil-window-up
  "o c" 'org-capture
  "o a" 'org-agenda
  "o t" 'org-todo-list

  ;; file navigation
  "f" '(:ignore t :which-key "File") ;
  "f ," '(:ignore t :which-key "Other file commands") ;
  "f ." 'projectile-find-file
  "f f" 'counsel-find-file
  "f s" 'save-buffer
  "f S" 'write-file
  "f p" 'open-emacs-config

  ;; Dired
  "d" '(:ignore t :which-key "Dired") ;
  "d d" 'dired
  "d m" 'dired-hide-details-mode
  "d ," 'dired-create-directory
  "d f" 'dired-create-empty-file
  "d w" 'wdired-change-to-wdired-mode

  ;; help
  "h" '(:ignore t :which-key "Help") ;
  "h f" 'describe-function
  "h k" 'describe-key
  "h v" 'describe-variable
  "h i" 'info

  ;; Launching shells
  ":" 'shell-command
  ";" 'eval-expression

  ;; Projectile
  "p" '(:ignore t :which-key "Projectile") ;
  "p p" 'projectile-switch-project
  "p a" 'projectile-add-known-project
  "p r" 'projectile-remove-known-project
  "o" '(:ignore t :which-key "Open a program") ;
  "o e" 'eshell-launch
  "o t" 'vterm-launch

  ;; Search
  "s" '(:ignore t :which-key "Search") ;
  "s s" 'swiper
  "s r" 'rg
  "s o" 'occur
  "s g" 'grep
  "s p" 'counsel-rg

   ;; misc / modes
  ", e" 'emacs-lisp-mode
  ", c" 'org-capture

  ;; Magit
  "g" '(:ignore t :which-key "Magit") ;
  "g g" 'magit-status

  ;; Tab
  "TAB" '(:ignore t :which-key "Tab") ;
  ;;"TAB TAB" 'tab-bar--current-tab-index
  "TAB n" 'my-new-tab
  "TAB r" 'tab-rename
  "TAB TAB" 'tab-bar-select-tab-by-name
  "TAB l" 'tab-list
  "TAB d" 'tab-bar-close-tab

  ;; Quit
  "q" '(:ignore t :which-key "Quit") ;
  "q q" 'save-buffers-kill-terminal
  )

;; magit
;; org mode

(local-lead-def
  :states '(normal visual)
  :keymaps '(org-mode-map org-agenda-mode-map)
  ;;"m" '(:ignore t :which-key "Org")
  "d" '(:ignore t :which-key "Org-Date")
  "d d" 'org-deadline
  "d s" 'org-schedule
  "d t" 'org-time-stamp
  "l" '(:ignore t :which-key "Org-Link")
  "l l" 'org-insert-link
  "l s" 'org-store-link
  "o" 'org-open-at-point
  "p" '(:ignore t :which-key "Org-Priority")
  "p p" 'org-priority
  "p u" 'org-priority-up
  "p d" 'org-priority-down
  "t" '(:ignore t :which-key "Org-Todo")
  "t t" 'org-todo
  "t w" 'org-wait
  "t r" 'org-defer
  "t d" 'org-done
  )


;; elisp eval
;; ** Mode Keybindings
(local-lead-def
  :states '(normal visual)
  :keymaps '(lisp-mode-map emacs-lisp-mode-map)
  ;;"m" '(:ignore t :which-key "Lisp")
  "e" '(:ignore t :which-key "Evaluate Lisp")
  "e e" 'pp-eval-last-sexp
  ;;"e E" 'eval-expression
  "e d" 'eval-defun
  "e p" 'eval-print-last-sexp
  "f" '(:ignore t :which-key "Forward")
  "f b" 'paredit-forward-barf-sexp
  "f s" 'paredit-forward-slurp-sexp
  "b" '(:ignore t :which-key "Backward")
  "b b" 'paredit-backward-barf-sexp
  "b s" 'paredit-backward-slurp-sexp
  ;; ...
  )

;; Racket
(local-lead-def
  :states '(normal visual)
  :keymaps '(racket-mode-map)
  ;;"m" '(:ignore t :which-key "Lisp")
  "e" '(:ignore t :which-key "Racket Evaluate")
  "s" '(:ignore t :which-key "Racket Send")
  "e e" 'racket-eval-last-sexp
  "s d" 'racket-send-definition
  "s r" 'racket-send-region
  "s s" 'racket-send-last-sexp
  "f" '(:ignore t :which-key "Forward")
  "f b" 'paredit-forward-barf-sexp
  "f s" 'paredit-forward-slurp-sexp
  "b" '(:ignore t :which-key "Backward")
  "b b" 'paredit-backward-barf-sexp
  "b s" 'paredit-backward-slurp-sexp
  ;; ...
  )

;; Scheme
(local-lead-def
  :states '(normal visual)
  :keymaps '(scheme-mode-map)
  ;;"m" '(:ignore t :which-key "Lisp")
  "s" '(:ignore t :which-key "Scheme Send")
  "s e" 'scheme-send-last-sexp
  "s d" 'scheme-send-definition
  "s D" 'scheme-send-definition-and-go
  "s r" 'scheme-send-region
  "s R" 'scheme-send-region-and-go
  "f" '(:ignore t :which-key "Forward")
  "f b" 'paredit-forward-barf-sexp
  "f s" 'paredit-forward-slurp-sexp
  "b" '(:ignore t :which-key "Backward")
  "b b" 'paredit-backward-barf-sexp
  "b s" 'paredit-backward-slurp-sexp
  ;; ...
  )
;; Clojure
(local-lead-def
  :states '(normal visual)
  :keymaps '(clojure-mode-map)
  ;;"m" '(:ignore t :which-key "Lisp")
  "e" '(:ignore t :which-key "Clojure Evaluate")
  "s" '(:ignore t :which-key "Clojure Send")
  "p" '(:ignore t :which-key "Clojure Pretty Print")
  "e e" 'cider-eval-last-sexp
  "e d" 'cider-eval-defun-at-point
  "e r" 'cider-eval-region
  "p e" 'cider-pprint-eval-last-sexp
  "p p" 'cider-pprint-eval-last-sexp-to-comment
  "f" '(:ignore t :which-key "Forward")
  "f b" 'paredit-forward-barf-sexp
  "f s" 'paredit-forward-slurp-sexp
  "b" '(:ignore t :which-key "Backward")
  "b b" 'paredit-backward-barf-sexp
  "b s" 'paredit-backward-slurp-sexp
  ;; ...
  )

;; Python
;; ** Mode Keybindings
(local-lead-def
  :states '(normal visual)
  :keymaps '(python-mode-map elpy-mode-map)
  "s" '(:ignore t :which-key "Send to Python")
  "d" '(:ignore t :which-key "Documentation")
  "s l" 'elpy-shell-send-statement ;; Think "send-line"
  "s L" 'elpy-shell-send-statement-and-step-and-go
  "s r" 'elpy-shell-send-region-or-buffer
  "s R" 'elpy-shell-send-region-or-buffer-and-step-and-go
  "s s" 'elpy-shell-send-group
  "s S" 'elpy-shell-send-group-and-step-and-go
  "s f" 'elpy-shell-send-defun
  "s F" 'elpy-shell-send-defun-and-step-and-go
  "s c" 'elpy-shell-send-defclass
  "s C" 'elpy-shell-send-defclass-and-step-and-go
  "d k" 'elpy-doc
  "d s" 'elpy-folding-toggle-docstrings
)



;; eshell
;;
;;

;;;; Keybindings ends here
