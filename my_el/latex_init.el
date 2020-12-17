;;
;; Latex mode
;; Need to Check after separation configure  
;; update 2020/12/11 
;;

(require 'tex-site) ; invoke the AUCTeX package (LaTeX support)
;; (load "auctex.el" nil t t)
;; ;; (require 'auctex)
;; (require 'company-auctex) ;company auctex mode
;; (company-auctex-init)


(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook
		  (lambda()
			(company-auctex)
			(visual-line-mode)
			(flyspell-mode)
			(LaTeX-math-mode)
			(turn-on-reftex)
			))

(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t) ; To compile documents to PDF
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(setq reftex-cite-prompt-optional-args t) ; Prompt for empty optional arguments in cite
