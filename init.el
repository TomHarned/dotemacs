
(require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

; List the packages you want
(setq package-list '(evil
                     evil-leader))

;; activate all the packages
(package-initialize)
;;evil mode settings
(require 'evil)
(evil-mode 1)

;; evil leader key
(require 'evil-leader)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "," 'execute-extended-command
  "ff" 'find-file
  "fs" 'save-file
  "fl" 'load-file
  "b" 'switch-to-buffer
  "w/" 'split-window-horizontally
  "w-" 'split-window-vertically
  "wh" 'windmove-left  
  "wl" 'windmove-right  
  "wk" 'windmove-up  
  "wj" 'windmove-down  
  "kbw" 'kill-buffer-and-window
  ;;"bn" 'next-buffer
  ;;"bp" 'previous-buffer
  "ls" 'list-buffers
  "kk" 'kill-buffer
  "kw" 'delete-window
  )
(setq evil-leader/in-all-states t)
(global-evil-leader-mode)


;; theme
(load-theme 'solarized-light t)

;; DON'T Edit this stuff here, it's auto generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit evil-leader solarized-theme evil-tutor evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


