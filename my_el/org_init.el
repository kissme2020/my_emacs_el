;;
;; Org Doc set up 
;; update 2020/12/11 
;;

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :hook (org-mod . efs/org-mode-setup)
  :config
  ;; (define-key global-map "\C-cl" 'org-store-link)
  ;; (define-key global-map "\C-ca" 'org-agenda)
  ;; (setq org-agenda-start-with-log-mode t)
  ;; (setq	org-log-mode 'time)
  ;; (setq	org-log-into-drawer t)
  (setq org-ellipsis " ▼"
		org-agenda-start-with-log-mode t
		org-log-mode 'time
		org-log-into-drawer t)	
  ;; org-hide-emphasis-markers t
  (setq org-agenda-files (list "~/Org/Personal.org"
							   "~/Org/Learning.org"
							   "~/Org/Work_Regular.org"
							   "~/Org/Work_Project.org")))

; Nicer Heading Bullets
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "○" "●" "○")))

(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1))))

;; Failed to Set Up Font 
;; (set-face-attribute (car face) nil :font "Times New Roman" :weight 'regular :height (cdr face)))

;; Replace list hyphen to dot.
(font-lock-add-keywords 'org-mode
                        '(("^ +\\([-*]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)

(setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "INIT(i)" "PLAN(p)" "EXECUTE(e)" "MOTIONER(m)" "WAIT(w@/!)" "HOLD(h)" "|" "CLOSE(c)" "CANC(k@)")))

;; (setq org-refile-targets
;;     '(("Archive.org" :maxlevel . 1)
;;       ("Tasks.org" :maxlevel . 1)))

;; Save Org buffers after refiling!
;; (advice-add 'org-refile :after 'org-save-all-org-buffers)



;; Center Org Buffers
(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))


;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))
