(use-package org-mime
  :ensure t)

(use-package mu4e
  :config
  (require 'org-mu4e)
  (require 'org-mime)
  (setq message-kill-buffer-on-exit t
	message-send-mail-function 'message-send-mail-with-sendmail
	mu4e-compose-compose-in-new-frame t
	mu4e-compose-format-flowed t
	mu4e-confirm-quit nil
	mu4e-headers-auto-update t
	mu4e-maildir "~/.local/share/mail"
	mu4e-show-addresses t
	mu4e-view-prefer-html t
        message-send-mail-function 'message-send-mail-with-sendmail
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-sendmail-f-is-evil 't
        mu4e-attachment-dir "~/Downloads"
        mu4e-show-images t
	org-mu4e-convert-to-html t)
  (add-to-list 'mu4e-view-actions
	       '("ViewInBrowser" . mu4e-action-view-in-browser) t)
  (add-hook 'mu4e-view-mode-hook #'visual-line-mode)
  (add-hook 'mu4e-view-mode-hook
	    (lambda()
	      ;; try to emulate some of the eww key-bindings
	      (local-set-key (kbd "<RET>") 'mu4e~view-browse-url-from-binding)
	      (local-set-key (kbd "<tab>") 'shr-next-link)
	      (local-set-key (kbd "<backtab>") 'shr-previous-link)))
  (add-hook 'mu4e-headers-mode-hook
	    (defun my/mu4e-change-headers ()
	      (interactive)
	      (setq mu4e-headers-fields
		    `((:human-date . 25) ;; alternatively, use :date
		      (:flags . 6)
		      (:from . 22)
		      (:thread-subject . ,(- (window-body-width) 70)) ;; alternatively, use :subject
		      (:size . 7)))))
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
  (add-hook 'mu4e-compose-mode-hook
	    (defun my-do-compose-stuff ()
	      "My settings for message composition."
	      (visual-line-mode)
	      (org-mu4e-compose-org-mode)
	      (use-hard-newlines -1)
	      (flyspell-mode)))
  (add-hook 'mu4e-compose-post-hook
            (defun do-compose-stuff ()
              "My settings for message composition."
              (org-mu4e-compose-org-mode)))

  (setq mu4e-bookmarks `(("(tag:\\\\Inbox) AND NOT flag:trash" "Unread messages" ?u)
			 ("date:today..now" "Today's messages" ?t)
			 ("date:7d..now" "Last Seven Days" ?w)
			 ("size:500k.. and date:..1y" "Large and old mails" ?c)))
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"
   :keymaps 'override
   "am" 'mu4e :desc "Mail"))
