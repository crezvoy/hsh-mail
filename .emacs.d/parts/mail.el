(use-package org-mime
  :ensure t)

(use-package mu4e
  :requires org-mime
  :init
  (my/leader
   "am" 'mu4e :desc "Mail")
  :config
  (evil-collection-mu4e-setup)
  (require 'org-mu4e)
  (setq message-kill-buffer-on-exit t
	message-send-mail-function 'message-send-mail-with-sendmail
	mu4e-bookmarks '(("maildir:/.*/inbox/" "Unread messages" ?u)
			("date:today..now" "Today's messages" ?t)
			("date:7d..now" "Last Seven Days" ?w)
			("size:500k.. AND date:..1y" "Large and old mails" ?c))
	mu4e-change-filenames-when-moving t
	mu4e-compose-compose-in-new-frame t
	mu4e-compose-format-flowed t
	mu4e-confirm-quit nil
	mu4e-get-mail-command "~/bin/fetchmail"
	mu4e-headers-show-threads t
	mu4e-headers-skip-duplicates t
	mu4e-headers-sort-direction 'ascending
	mu4e-headers-sort-field :date
	mu4e-headers-auto-update t
	mu4e-maildir "~/Maildir"
	mu4e-use-fancy-chars t
	mu4e-view-prefer-html t
	mu4e-view-show-addresses t
	mu4e-view-show-images t
	message-send-mail-function 'message-send-mail-with-sendmail
	message-sendmail-extra-arguments '("--read-envelope-from")
	message-sendmail-f-is-evil 't
	mu4e-attachment-dir "~/Downloads"
	org-mu4e-convert-to-html t
	sendmail-program "~/bin/sendmail")
  (add-to-list 'mu4e-view-actions
	       '("ViewInBrowser" . mu4e-action-view-in-browser) t)

  ;; (defun htmlize-and-send ()
  ;;   "When in an org-mu4e-compose-org-mode message, htmlize and send it."
  ;;   (interactive)
  ;;   (when (member 'org~mu4e-mime-switch-headers-or-body post-command-hook)
  ;;     (org-mime-htmlize)
  ;;     (visual-line-mode)
  ;;     (org-mu4e-compose-org-mode)
  ;;     (mu4e-compose-mode)
  ;;     (message-send-and-exit)
  ;;     (use-hard-newlines -1)
  ;;     (flyspell-mode)))
  ;; (add-hook 'org-ctrl-c-ctrl-c-hook 'htmlize-and-send t)

  :ghook
  ('mu4e-view-mode-hook #'visual-line-mode)
  ('mu4e-view-mode-hook
   #'(lambda ()	
       ;; try to emulate some of the eww key-bindings
       (local-set-key (kbd "<RET>") 'mu4e~view-browse-url-from-binding)
       (local-set-key (kbd "<tab>") 'shr-next-link)
       (local-set-key (kbd "<backtab>") 'shr-previous-link)))
  ('mu4e-headers-mode-hook
   #'(lambda ()
       (interactive)
       (setq mu4e-headers-fields
	     `((:human-date . 25) ;; alternatively, use :date
	       (:flags . 6)
	       (:from . 22)
	       (:thread-subject . ,(- (window-body-width) 70)) ;; alternatively, use :subject
	       (:size . 7)))))
  ('mu4e-compose-mode-hook
   #'(lambda ()
       "My settings for message composition."
       (visual-line-mode)
       (org-mu4e-compose-org-mode)
       (use-hard-newlines -1)
       (flyspell-mode)))
  ('mu4e-compose-post-hook
   #'(lambda ()
       "My settings for message composition."
       (org-mu4e-compose-org-mode))))
