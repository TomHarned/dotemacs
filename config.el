(use-package emacs
  :preface
  (defvar ian/indent-width 4) ; change this value to your preferred width
  :config
  (setq frame-title-format '("Emacs") ; Yayyyyy Evil!
        ring-bell-function 'ignore       ; minimize distraction
        frame-resize-pixelwise t
        default-directory "~/")

  (tool-bar-mode -1)
  (menu-bar-mode -1)

  ;; better scrolling experience
  (setq scroll-margin 0
        scroll-conservatively 101 ; > 100
        scroll-preserve-screen-position t
        auto-window-vscroll nil)

  ;; line) numbers
  (global-display-line-numbers-mode)

  ;; Always use spaces for indentation
  (setq-default indent-tabs-mode nil
                tab-width ian/indent-width)

  ;; Omit default startup screen
  (setq inhibit-startup-screen t))

;; The Emacs default split doesn't seem too intuitive for most users.
(use-package emacs
  :ensure nil
  :preface
  (defun ian/split-and-follow-horizontally ()
    "Split window below."
    (interactive)
    (split-window-below)
    (other-window 1))
  (defun ian/split-and-follow-vertically ()
    "Split window right."
    (interactive)
    (split-window-right)
    (other-window 1))
  :config
  (global-set-key (kbd "C-x 2") #'ian/split-and-follow-horizontally)
  (global-set-key (kbd "C-x 3") #'ian/split-and-follow-vertically))

(use-package delsel
  :ensure nil
  :config (delete-selection-mode +1))

(use-package scroll-bar
  :ensure nil
  :config (scroll-bar-mode -1))

(use-package simple
  :ensure nil
  :config (column-number-mode +1))

(use-package files
  :ensure nil
  :config
  (setq confirm-kill-processes nil
        create-lockfiles nil ; don't create .# files (crashes 'npm start')
        make-backup-files nil))

(use-package autorevert
  :ensure nil
  :config
  (global-auto-revert-mode +1)
  (setq auto-revert-interval 2
        auto-revert-check-vc-info t
        global-auto-revert-non-file-buffers t
        auto-revert-verbose nil))

(use-package eldoc
  :ensure nil
  :diminish eldoc-mode
  :config
  (setq eldoc-idle-delay 0.4))

;; C, C++, and Java
(use-package cc-vars
  :ensure nil
  :config
  (setq-default c-basic-offset ian/indent-width)
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "k&r"))))


(use-package mwheel
  :ensure nil
  :config (setq mouse-wheel-scroll-amount '(2 ((shift) . 1))
                mouse-wheel-progressive-speed nil))

(use-package paren
  :ensure nil
  :init (setq show-paren-delay 0)
  :config (show-paren-mode +1))

(use-package frame
  :preface
  (defun ian/set-default-font ()
    (interactive)
    (when (member "Consolas" (font-family-list))
      (set-face-attribute 'default nil :family "FiraCode"))
    (set-face-attribute 'default nil
                        :height 110
                        :weight 'normal))
  :ensure nil
  :config
  (setq initial-frame-alist '((fullscreen . maximized)))
  (ian/set-default-font))

(use-package ediff
  :ensure nil
  :config
  (setq ediff-window-setup-function #'ediff-setup-windows-plain)
  (setq ediff-split-window-function #'split-window-horizontally))

(use-package elec-pair
  :ensure nil
  :hook (prog-mode . electric-pair-mode))

(use-package whitespace
  :ensure nil
  :hook (before-save . whitespace-cleanup))

(use-package dired
  :ensure nil
  :config
  (setq delete-by-moving-to-trash t)
  (eval-after-load "dired"
    #'(lambda ()
        (put 'dired-find-alternate-file 'disabled nil)
        (define-key dired-mode-map (kbd "RET") #'dired-find-alternate-file))))

(use-package cus-edit
  :ensure nil
 :config
  (setq custom-file (concat user-emacs-directory "to-be-dumped.el")))



(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes/"))
;;(load-theme 'wilmersdorf t nil)

(use-package tao-theme
  :ensure t)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo
        dashboard-banner-logo-title "Emacs"
        dashboard-items nil
        dashboard-set-footer nil))

(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

;;(use-package highlight-escape-seqences
;;  :hook (prog-mode . hes-mode))

(use-package evil
  :diminish undo-tree-mode
  :init
  (setq evil-want-C-u-scroll t
        evil-want-keybinding nil
        evil-shift-width ian/indent-width)
  :hook (after-init . evil-mode)
  :preface
  (defun ian/save-and-kill-this-buffer ()
    (interactive)
    (save-buffer)
    (kill-this-buffer))
  :config
  (with-eval-after-load 'evil-maps ; avoid conflict with company tooltip selection
    (define-key evil-insert-state-map (kbd "C-n") nil)
    (define-key evil-insert-state-map (kbd "C-p") nil))
  (evil-ex-define-cmd "q" #'kill-this-buffer)
  (evil-ex-define-cmd "wq" #'ian/save-and-kill-this-buffer))

(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-company-use-tng nil)
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :diminish
  :config (evil-commentary-mode +1))

(use-package magit
  :bind ("C-x g" . magit-status)
  :config (add-hook 'with-editor-mode-hook #'evil-insert-state))

(use-package ido
  :config
  (ido-mode +1)
  (setq ido-everywhere t
        ido-enable-flex-matching t))

(use-package ido-vertical-mode
  :config
  (ido-vertical-mode +1)
  (setq ido-vertical-define-keys 'C-n-C-p-up-and-down))

(use-package ido-completing-read+ :config (ido-ubiquitous-mode +1))

(use-package flx-ido :config (flx-ido-mode +1))

(use-package company
  :diminish company-mode
  :hook (prog-mode . company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.1
        company-selection-wrap-around t
        company-tooltip-align-annotations t
        company-frontends '(company-pseudo-tooltip-frontend ; show tooltip even for single candidate
                            company-echo-metadata-frontend))
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

(use-package flycheck
             :config (global-flycheck-mode +1))

(setq flycheck-check-syntax-automatically '(mode-enabled save))
;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Org Mode   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode)))

(use-package org-bullets :hook (org-mode . org-bullets-mode))

(setq org-directory "~/org/")
(setq org-agenda-files (list "~/org/"))
(setq org-agenda-file-regexp "\\`[^.].*\\.org\\'")

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Inbox")
         "* TODO %?\n  %i\n  %a")
        ("n" "Note" entry (file+datetree "~/org/notes.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;; Open org links in a a different window
(require 'org)

(defun set-up-org-other-window ()
  (add-to-list 'org-link-frame-setup '(file . find-file-other-window)))

(add-hook 'after-init-hook #'set-up-org-other-window)


(setq org-todo-keywords '("TODO" "WAIT" "DEFERRED" "DONE"))

(defun org-wait ()
  (interactive)
  (org-todo)
  (org-todo))

(defun org-defer ()
  (interactive)
  (org-todo)
  (org-todo)
  (org-todo))

(defun org-done ()
  (interactive)
  (org-todo)
  (org-todo)
  (org-todo)
  (org-todo))

;; Stay in evil mode when working with org agendas
(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;;;;;;;;;;;;;;;;;
;; Markdown    ;;
;;;;;;;;;;;;;;;;;
(use-package markdown-mode
  :hook (markdown-mode . visual-line-mode))

(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.css\\'"   . web-mode)
         ("\\.jsx?\\'"  . web-mode)
         ("\\.tsx?\\'"  . web-mode)
         ("\\.json\\'"  . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2) ; HTML
  (setq web-mode-css-indent-offset 2)    ; CSS
  (setq web-mode-code-indent-offset 2)   ; JS/JSX/TS/TSX
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))

(use-package diminish
  :demand t)

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode +1)
  (setq which-key-idle-delay 0.4
        which-key-idle-secondary-delay 0.4))

(use-package exec-path-from-shell
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

;; Python (both v2 and v3)
(use-package python
  :ensure nil
  :config (setq python-indent-offset ian/indent-width
                python-indent-guess-indent-offset nil))

;; elpy
(use-package elpy
  :ensure t
  :init (elpy-enable)
  :config
  (setq elpy-rpc-python-command "python3"
        python-shell-interpreter "ipython3"
        python-shell-interpreter-args "--simple-prompt --pprint"
        tab-width 4))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

;; Racket Mode
(use-package racket-mode
  :ensure t
  :init)

;; Clojure cider
(use-package clojure-mode)

(use-package cider
  :ensure t)

;; Ripgrep
(use-package rg)

(use-package ivy
  :ensure t
  :init
  (ivy-mode)
  (setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t))

(use-package counsel
  :ensure t
  :init
  (counsel-mode))

(use-package swiper
  :ensure t
  :init)

(use-package counsel-jq)

(use-package olivetti
  :ensure t
  :init)

(olivetti-set-width 80)

;; Break lines at 80 chars
(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook #'auto-fill-mode)

;; Improved Copy/Paste
(use-package xclip
  :ensure t
  :config
  (xclip-mode))

(custom-set-variables '(x-select-enable-clipboard t))


;; Virtual Environments
(defun set-venv (env)
   "Set a python venv from your default dir, i.e. '.virtualenvs'.
    If you want to use another directory, use 'pyvenv-activate'

    'env' is the name of your venv, i.e. the dir where it's stored"
   (interactive (list (read-file-name "Select venv: " "~/.virtualenvs"
nil nil nil)))
   (setq env (expand-file-name env))
   (pyvenv-activate env)
   (setq venv-name (file-name-nondirectory
                   (directory-file-name env)))
   (message "Venv set to: %s" venv-name))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; THIS NEEDS PROJECTILE FIRST ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Ivy don't use ^ to start
(setq ivy-initial-inputs-alist nil)

(provide 'config) ;; Config ends here

;;;;;;;;;;;;;;;;;;;;;;;
;;  BACKUP Settings  ;;
;;;;;;;;;;;;;;;;;;;;;;;
(setq make-backup-files nil)

;; (setq backup-directory-alist `(("." . "~/emacs_auto_backups")))
;; (setq backup-by-copying t)
;; (setq delete-old-versions t
;;   kept-new-versions 6
;;   kept-old-versions 2)

;
(use-package projectile
  ;; for some reason you need this to work around a bug
  :init (projectile-add-known-project "~/org")
  :ensure t)

(defun my-new-tab (tab-name)
  "Create a tab and assign a user-supplied name"
  (interactive "sTab name: ")
  (tab-new)
  (tab-rename tab-name)
  (dashboard-refresh-buffer)
  (message "Tab %s created" tab-name))

(use-package general)

(use-package vterm
    :load-path "/home/theuser/emacs-libvterm"
    :ensure t)


(defun scratch-buffer ()
    (interactive)
    (switch-to-buffer "*scratch*")
    (fundamental-mode))

(defun scratch-elisp-buffer ()
    (interactive)
    (switch-to-buffer "*scratch*")
    (emacs-lisp-mode))
(if (fboundp 'blink-cursor-mode)
     (blink-cursor-mode 0))

(use-package doom-themes
   :ensure t
   :config
   ;; Global settings (defaults)
   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
         doom-themes-enable-italic t) ; if nil, italics is universally disabled
   (load-theme 'doom-one t nil)

   ;; Enable flashing mode-line on errors
   ;;(doom-themes-visual-bell-config)
   ;; Enable custom neotree theme (all-the-icons must be installed!)
   (doom-themes-neotree-config)
   ;; or for treemacs users
   (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
   (doom-themes-treemacs-config)
   ;; Corrects (and improves) org-mode's native fontification.
   (doom-themes-org-config))

(use-package mood-line
   :hook (after-init . mood-line-mode))

(use-package paredit
  :ensure t)

;; Scheme
;; Set Chicken scheme as your default
(if (string= system-type "berkeley-unix")
    (setq scheme-program-name "chicken-csi -:c"))

(if (eq system-type 'berkeley-unix)
    (setq geiser-chicken-binary "chicken-csi"))

;; Load Keymappings
(add-to-list 'load-path "~/.emacs.d/lisp")
(load-library "functions.el")
(load-library "keymappings.el")

(add-hook 'after-init-hook 'global-company-mode)


(if (string= system-type "berkeley-unix")
    (setenv "PS1" "${PWD##*/} λ "))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                   ;;
;;          eshell                   ;;
;;                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq eshell-prompt-regexp "^[^#$\n]*[#$] "
;;       eshell-prompt-function
;;       (lambda nil
;;         (concat
;;      "[" (user-login-name) "@" (system-name) " "
;;      (if (string= (eshell/pwd) (getenv "HOME"))
;;          "~" (eshell/basename (eshell/pwd)))
;;      "]\n"
;;      (if (= (user-uid) 0) "# " "λ "))))

(provide 'config)
;;; Config ends hereu
