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

(defun delete-backup-files ()
  (interactive)
  (if (null (directory-files "." t "^\#"))
    (message "All Backup files in %s deleted"
      (file-name-directory (buffer-file-name)))
    (let ((files (directory-files "." t "^\#")))
            (file-name-directory (buffer-file-name))
        (delete-file (car files))
        (delete-backup-files))))

(defun youtube-dl (url)
  "Download the specified URL from YouTube as an mp3"
  (interactive "sEnter URL: ")
  (let ((dir default-directory)
        (com (concat "youtube-dl -xq --audio-format mp3" " " url)))
  (progn
    (cd "~/Music/")
    (shell-command com)
    (cd dir))))


(defun youtube-dl-from-list (url-list)
  "Download each youtube url in a list"
  (if (eq nil url-list) (message "All done!")
    (progn
      (shell-command
       (concat
        "youtube-dl -xq --audio-format mp3" " "
        (car url-list)))
      (youtube-dl-from-list (cdr url-list)))))

(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defun youtube-dl-multi (filePath)
  (interactive "sEnter Filepath of URLs to Download: ")
  (let ((lines (read-lines filePath))
        (dir default-directory))
    (progn
      (cd "~/Music/")
      (youtube-dl-from-list lines)
      (cd dir))))

(provide 'functions)
;;; functionsl.el ends here



;; Config ends here
