(defun er-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))

    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))



(defun vterm-launch ()
  "Launch a new vterm process. If one exists, give it a unique name"
  (interactive)
  (if (get-buffer "*vterm*")
    (progn
      ;; Using a large random number to avoid collisions
      (vterm (concat "*vterm-" (format "%s" (random 10000)) "*")))
    (vterm)))



(defun eshell-launch ()
  "Launch a new vterm process. If one exists, give it a unique name"
  (interactive)
  (if (get-buffer "*eshell*")
    (progn
      ;; Using a large random number to avoid collisions
      (eshell (concat "*eshell-" (format "%s" (random 10000)) "*")))
    (eshell)))



(defun th-goto-scratch-buffer ()
    "Open a scratch buffer in another window"
  (interactive)
  (progn
    (switch-to-buffer-other-window "*scratch*")
    (emacs-lisp-mode)))



(defun th-goto-scratch-buffer-here ()
    "Open a scratch buffer in another window"
  (interactive)
  (progn
    (switch-to-buffer "*scratch*")
    (emacs-lisp-mode)))


(defun open-emacs-config ()
  "Open a file in ~/.emacs.d/"
  (interactive)
  (projectile-find-file-in-directory "~/.emacs.d"))


(provide 'functions)
;;; functionsl.el ends here


;; Config ends here
