;;
;; Spell check using hunspell and flyspell
;; update 2020/12/11 
;;

;; Spell check by flyspell, hunspell
(use-package flyspell
  :init
  (add-to-list 'exec-path "c:/Users/tskdkim/hunspell/bin")
  (setq ispell-program-name "hunspell")
  (setq ispell-personal-dictionary "C:/User/tskdkim/.ispell")
  (setq ispell-extra-args '("--sug-mode=ultra"))

  (progn
	(dolist (mode '(LaTeX-mode-hook
					python-mode-hook
					emacs-lisp-mode-hook
					text-mode-hook
					git-commit-setup-hook
					git-commit-setup-hook
					git-commit-turn-on-flyspell					
					))
	  (add-hook mode (lambda () (flyspell-mode 1)))))
  )
	
	
  

;; (require 'flyspell)
;; (add-to-list 'exec-path "c:/Users/tskdkim/hunspell/bin")
;; (setq ispell-program-name "hunspell")
;; (setq ispell-personal-dictionary "C:/User/tskdkim/.ispell")
;; (setq ispell-extra-args '("--sug-mode=ultra"))
;; (dolist (mode '(LaTeX-mode-hook
;; 				python-mode-hook
;; 				emacs-lisp-mode-hook
;; 				text-mode-hook
;; 				))
;;   (add-hook mode (lambda () (flyspell-mode 1))))

;; ;; Magit Flyspell Set up
;; (add-hook 'git-commit-setup-hook 'git-commit-turn-on-flyspell)
