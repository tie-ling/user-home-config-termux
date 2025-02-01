;; add melpa package archive for ledger mode
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


(use-package emacs
  :custom
  (auto-fill-function 'do-auto-fill t)
  (calendar-week-start-day 1)
  (custom-enabled-themes '(modus-operandi) nil nil "Customized with use-package custom")
  (default-input-method "german")
  (enable-local-variables nil)
  (inhibit-startup-screen t)
  (menu-bar-mode nil)
  (mail-envelope-from 'header)
  (mail-specify-envelope-from t)
  (message-sendmail-envelope-from 'header)
  (mode-line-compact 'long)
  (modus-themes-bold-constructs nil)
  (modus-themes-inhibit-reload nil)
  (modus-themes-italic-constructs t)
  (modus-themes-mixed-fonts t)
  (network-security-level 'paranoid)
  (read-buffer-completion-ignore-case t)
  (ring-bell-function nil)
  (scroll-bar-mode nil)
  (send-mail-function 'sendmail-send-it)
  (sendmail-program "msmtp")
  (tab-always-indent 'complete)
  (tool-bar-mode nil)
  (tramp-mode nil)
  (xterm-mouse-mode nil)
  (user-mail-address "gyuchen86@gmail.com"))

(use-package elec-pair
  :custom
  (electric-pair-mode t))

(use-package battery
  :custom
  (display-battery-mode t))

(use-package time
  :custom
  (display-time-mode t))

(use-package shr
  :custom
  (shr-cookie-policy nil)
  (shr-inhibit-images t)
  (shr-use-colors nil))

(use-package files
  :custom
  (require-final-newline t))

(use-package minibuffer
  :custom
  (read-file-name-completion-ignore-case t))

(use-package simple
  :custom
  (indent-tabs-mode nil))

(use-package magit
  :ensure t)

(global-set-key (kbd "C-c a") #'org-agenda)
(use-package org
  :custom
  (org-startup-folded t)
  (org-agenda-prefix-format
   '((agenda . "%?-12t% s")
     (todo . "")
     (tags . " %i %-12:c")
     (search . " %i %-12:c")))
  (org-agenda-files '("~/user-docs/agenda/2025"))
  (org-agenda-span 'day)
  (org-display-custom-times t)
  (org-time-stamp-custom-formats '("%m-%d" . "%H:%M"))
  (org-latex-compiler "lualatex")
  (org-babel-load-languages '((haskell . t) (python . t) (emacs-lisp . t) (shell . t)))
  (org-export-initial-scope 'buffer)
  (org-modules
   '(ol-bbdb ol-bibtex ol-doi ol-eww ol-info ol-irc ol-mhe ol-rmail org-tempo))
  (org-structure-template-alist
   '(("a" . "export ascii")
     ("c" . "center")
     ("C" . "comment")
     ("e" . "example")
     ("E" . "export")
     ("h" . "export html")
     ("l" . "export latex")
     ("q" . "quote")
     ("s" . "src")
     ("v" . "verse")
     ("hs" . "src haskell")
     ("py" . "src python")))
  :hook
  ;; in org mode, do not use <> electric pairs, as this is used by
  ;; org-tempo for structure templates
  (org-mode . (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t
                    (,electric-pair-inhibit-predicate c))))))
  :config
  (defun org-my-timestamp-range ()
    (interactive)
    (while (org-at-timestamp-p)
      (forward-char))
    (backward-char 1)
    (insert "--")
    (org-insert-time-stamp (current-time) t)))

(use-package counsel
  :ensure t
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) "))
