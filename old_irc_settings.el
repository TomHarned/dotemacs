;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with SPC f f and enter text in its buffer.


(setq
 erc-server "irc.libera.chat"
 erc-current-nick "irontom"
 )
;; Add SASL server to list of SASL servers (start a new list, if it did not exist)
(add-to-list 'erc-sasl-server-regexp-list "irc\\.libera\\.chat")
;; Redefine/Override the erc-login() function from the erc package, so that
;; it now uses SASL
(defun erc-login ()
  "Perform user authentication at the IRC server. (PATCHED)"
  (erc-log (format "login: nick: %s, user: %s %s %s :%s"
           (erc-current-nick)
           (user-login-name)
           (or erc-system-name (system-name))
           erc-session-server
           erc-session-user-full-name))
  (if erc-session-password
      (erc-server-send (format "PASS %s" erc-session-password))
    (message "Logging in without password"))
  (when (and (featurep 'erc-sasl) (erc-sasl-use-sasl-p))
    (erc-server-send "CAP REQ :sasl"))
  (erc-server-send (format "NICK %s" (erc-current-nick)))
  (erc-server-send
   (format "USER %s %s %s :%s"
       ;; hacked - S.B.
       (if erc-anonymous-login erc-email-userid (user-login-name))
       "0" "*"
       erc-session-user-full-name))
  (erc-update-mode-line))

(erc-tls :server "irc.libera.chat" :port 6697 :nick "YourNick"
    :full-name "Text to display as your realname/gecos"
    :password "NickServPassword"))
;; (setq auth-source-pass-filename "~/.password-store")

;; (setq irc-auth (password-store-get "irc-freenode"))
