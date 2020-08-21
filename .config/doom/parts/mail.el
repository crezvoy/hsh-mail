
(if (file-exists-p "/usr/share/emacs/site-lisp/mu4e")
    (add-load-path!  "/usr/share/emacs/site-lisp/mu4e"))

(setq +mu4e-backend nil)

(after! mu4e
  (setq mu4e-use-fancy-chars t
        mu4e-view-use-gnus t
        mu4e-attachment-dir "~/Downloads"
        sendmail-program "~/bin/sendmail"
        message-send-mail-function 'message-send-mail-with-sendmail
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-sendmail-f-is-evil 't
        sendmail-program "~/bin/sendmail"
        mu4e-get-mail-command "~/bin/fetchmail"
        mu4e-bookmarks '(("maildir:/.*/inbox/" "Unread messages" ?u)
                         ("date:today..now" "Today's messages" ?t)
                         ("date:7d..now" "Last Seven Days" ?w)
                         ("size:500k.. AND date:..1y" "Large and old mails" ?c))))



;; (require 'org-mu4e)
;; (require 'org-mime)
;; (setq +mu4e-mu4e-mail-path "~/Maildir"
;;       message-kill-buffer-on-exit t
;;       mu4e-change-filenames-when-moving t
;;       mu4e-compose-compose-in-new-frame t
;;       mu4e-confirm-quit nil
;;       mu4e-get-mail-command "~/bin/fetchmail"
;;       mu4e-headers-show-threads t
;;       mu4e-headers-skip-duplicates t
;;       mu4e-headers-sort-direction 'ascending
;;       mu4e-headers-sort-field :date
;;       mu4e-headers-auto-update t
;;       mu4e-use-fancy-chars t
;;       mu4e-view-prefer-html t
;;       mu4e-view-show-addresses t
;;       mu4e-view-show-images t
;;       message-sendmail-f-is-evil 't
;;       org-mu4e-convert-to-html t
;;       sendmail-program "~/bin/sendmail"))
;; (add-to-list 'mu4e-view-actions
;;              '("ViewInBrowser" . mu4e-action-view-in-browser) t))
;;
;; :ghook
;; ('mu4e-view-mode-hook #'visual-line-mode)
;; ('mu4e-headers-mode-hook
;;  #'(lambda ()
;;      (interactive)
;;      (setq mu4e-headers-fields
;;            `((:human-date . 25) ;; alternatively, use :date
;;              (:flags . 6)
;;              (:from . 22)
;;              (:thread-subject . ,(- (window-body-width) 70)) ;; alternatively, use :subject
;;              (:size . 7)))
;; ('mu4e-compose-mode-hook
;;  #'(lambda ()
;;      "My settings for message composition."
;;      (visual-line-mode)
;;      (org-mu4e-compose-org-mode)
;;      (use-hard-newlines -1)
;;      (flyspell-mode)))
;; ('mu4e-compose-post-hook
;;  #'(lambda ()
;;      "My settings for message composition."
;;      (org-mu4e-compose-org-mode)))
