;;
;; Python mode 
;; Need to Check after separation configure  
;; update 2020/12/11 
;;
;; ================================================================
;; python mode Update 2020/03/07
;; ================================================================

;; Creating an anaconda environment with commands
;; https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html
;; conda create --name myenv
;; C:/Users/tskdkim/AppData/Local/Continuum/anaconda3/envs/myenv
;; Set python version
;; conda create -n myenv_3_7 python=3.7
;; Active
;; conda activate myenv_3_7
;; Update env to yml file
;; conda env export > enviroment.yml 

(use-package pyvenv
  :demand t
  :init
  (setenv "WORKON_HOME" "/Users/tskdkim/AppData/Local/Continuum/anaconda3/envs/myenv_3_7")
  (setenv "PYTHONIOENCODING" "utf-8")
  ;; (setq pyvenv-workon "emacs")  ; Default venv  
  :config
  (pyvenv-mode 1))     ; Automatically use pyvenv-workon via dir-locals

(use-package python-mode
  :ensure t
  ;; :mode
  ;; ("\\.py\\'" . python-mode)
  ;; ("\\.wsgi$" . python-mode)  
  :hook
  (python-mode . lsp-deferred)

  :custom
  (dap-python-debugger 'debugpy)  

  :config
  (setq python-indent-offset 4
		python-shell-interpreter "ipython"
		python-shell-interpreter-args "--simple-prompt -i")
  (require 'dap-python)
  ;; :custom
  ;; (require 'dap-python)
  ;; (dap-python-debugger 'debugpy)
  ;; :config
  ;; (setq python-indent-offset 4
  ;; 		python-shell-interpreter "ipython"
  ;; 		python-shell-interpreter-args "--simple-prompt -i")
  ;; :config
  ;; (require 'dap-python)
)

;; pytest 
(use-package pytest) 

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; (use-package python-mode
;;   :ensure t
;;   ;; :hook (python-mode . lsp-deferred)

;;   :interpreter
;;   (python-shell-interpreter "ipython")
;;   (python-shell-interpreter-args "--simple-prompt -i"))
  
  ;; :custom
  ;; (python-shell-interpreter "ipython")
  ;; (python-shell-interpreter-args "--simple-prompt -i"))


;; (use-package python-mode
;;   :ensure t
;;   :hook (python-mode . lsp-deferred)
;;   :custom
;;   (python-shell-interpreter "ipython")
;;   (python-shell-interpreter-args "--simple-prompt -i"))

;; (use-package lsp-mode
;;   :config
;;   (setq lsp-idle-delay 0.5
;;         lsp-enable-symbol-highlighting t
;;         lsp-enable-snippet nil  ;; Not supported by company capf, which is the recommended company backend
;;         lsp-pyls-plugins-flake8-enabled t)
;;   (lsp-register-custom-settings
;;    '(("pyls.plugins.pyls_mypy.enabled" t t)
;;      ("pyls.plugins.pyls_mypy.live_mode" nil t)
;;      ("pyls.plugins.pyls_black.enabled" t t)
;;      ("pyls.plugins.pyls_isort.enabled" t t)

;;      ;; Disable these as they're duplicated by flake8
;;      ("pyls.plugins.pycodestyle.enabled" nil t)
;;      ("pyls.plugins.mccabe.enabled" nil t)
;;      ("pyls.plugins.pyflakes.enabled" nil t)))
;;   :hook
;;   ((python-mode . lsp)
;;    (lsp-mode . lsp-enable-which-key-integration))
;;   :bind (:map evil-normal-state-map
;;               ("gh" . lsp-describe-thing-at-point)
;;               :map md/leader-map
;;               ("Ff" . lsp-format-buffer)
;;               ("FR" . lsp-rename)))

;; (use-package lsp-ui
;;   :config (setq lsp-ui-sideline-show-hover t
;;                 lsp-ui-sideline-delay 0.5
;;                 lsp-ui-doc-delay 5
;;                 lsp-ui-sideline-ignore-duplicates t
;;                 lsp-ui-doc-position 'bottom
;;                 lsp-ui-doc-alignment 'frame
;;                 lsp-ui-doc-header nil
;;                 lsp-ui-doc-include-signature t
;;                 lsp-ui-doc-use-childframe t)
;;   :commands lsp-ui-mode
;;   :bind (:map evil-normal-state-map
;;               ("gd" . lsp-ui-peek-find-definitions)
;;               ("gr" . lsp-ui-peek-find-references)
;;               :map md/leader-map
;;               ("Ni" . lsp-ui-imenu)))

;; (use-package pyvenv
;;   :demand t
;;   :config
;;   (setq pyvenv-workon "emacs")  ; Default venv
;;   (pyvenv-tracking-mode 1))  ; Automatically use pyvenv-workon via dir-locals
  



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
;; (setenv "WORKON_HOME" "/Users/tskdkim/AppData/Local/Continuum/anaconda3/envs")
;; (pyvenv-mode 1)

;; (require 'python)
;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "--simple-prompt -i")

;; (setenv "PYTHONIOENCODING" "utf-8")

;; (setq python-shell-interpreter "C:/Users/tskdkim/AppData/Local/Continuum/Anaconda3/python.exe"
;;       python-shell-interpreter-args
;; 	  ;; "-i C:/Users/tskdkim/AppData/Local/Continuum/Anaconda3/Scripts/ipython-script.py")
;; 	  "-i C:/Users/tskdkim/AppData/Local/Continuum/Anaconda3/Scripts/ipython-script.py --pylab=auto")

;; ;; jedi
;; (require 'jedi)

;; (add-hook 'python-mode-hook
;; 		  'jedi:setup
;; 		  'jedi:ac-setup)

;; (setq jedi:complete-on-dot t)

;; (defvar jedi-config:with-vitualenv nil
;;   "/Users/tskdkim/AppData/Local/Continuum/anaconda3/envs")

;; ;; Variables to help find the project root
;; (defvar jedi-config:vsc-root-sentinel ".git")
;; (defvar jedi-config:python-module-sentinal "__init__.py")

;; ;; Function to find project root given a buffer
;; (defun get-project-root (buf repo-type init-file)
;;   (vc-find-root (expand-file-name (buffer-file-name buf)) repo-type))

;; (defvar jedi-config:find-root-function 'get-project-root)

;; ;; And call this on initialization
;; (defun current-buffer-project-root ()
;;   (funcall jedi-config:find-root-function
;; 		   (current-buffer)
;; 		   jedi-config:vsc-root-sentinel
;; 		   jedi-config:python-module-sentinal))

;; (defun jedi-config:setup-server-args ()
;;   ;; little helper macro
;;   (defmacro add-args (agr-list arg-name arg-value)
;; 	'(setq ,arg-list (append, arg-list (agr-list arg-name arg-value))))

;;   (let ((project-root (current-buffer-project-root)))

;; 	;; variable for this buffer only
;; 	(make-local-variable 'jedi:server-args)

;; 	;; And set our variable
;; 	(when project-root
;; 	  (add-args jedi:server-args "--sys-path" project-root))
;; 	(when jedi-config:with-virtualenv
;; 	  (add-args jedi:server-args "--virtual-enc"
;; 				jedi-config:with-virtualenv))))

;; (defvar jedi-config:use-system-python t)


;; ;; Use system python
;; (defun jedi-config:set-python-excutable ()
;;   (set-exec-path-from-shell-PATH)
;;   (make-local-variable 'jedi:server-command)
;;   (set 'jedi:server-command
;; 	   (list (executable-find "python")
;; 			 (cadr defalut-jedi-server-command))))

;; (add-to-list 'ac-sources  ;; Hook up autocomplete
;; 			 'ac-source-jedi-direct)

;; ;; py-autopep8
;; (require 'py-autopep8)
;; (add-hook 'python-mode-hook
;; 		  'py-autopep8-enable-on-save)


;; ;; Enable Jedi setup on mode start
;; (add-hook 'python-mode-hook 'jedi:setup)

;; (add-hook 'python-mode-hook
;; 		  'jedi-config:set-server-args)
;; (when jedi-config:use-system-python
;;   (add-hook 'python-mode-hook
;; 			'jedi-config:set-python-excutable))

;; ;; Don't let tooltip show up automatically
;; (setq jedi:get-in-function-call-delay 10000000)
;; ;; Start completion at method dot
;; (setq jedi:complete-on-dot t)


;; ;; Enable elpy
;; (elpy-enable) 
;; (setq elpy-rpc-python-command "python")

;; ;; flycheck 
;; (defun flycheck-python-setup () 
;;   (flycheck-mode))
;; (add-hook 'python-mode-hook #'flycheck-python-setup)

;; ;; Enable autopep8
;; (require 'py-autopep8) 
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; (when (require 'flycheck nil t) ;; Enable Flycheck
;; (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;; (add-hook 'elpy-mode-hook 'flycheck-mode))
;; (setq elpy-rpc-backend "jedi")


;; ;; Complition with Company mode
;; (require 'company)
;; (add-hook 'after-init-hook 'global-company-mode)

;; ;;Python mode
;; (require 'python)
;; (add-hook 'python-mode-hook 'anaconda-mode) ; anaconda-mode
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode) ; eldoc mode
;; (eval-after-load "company"
;;   '(add-to-list 'company-backends '(company-anaconda :with company-capf)))
;; (defun flycheck-python-setup () ; flycheck 
;;   (flycheck-mode))
;; (add-hook 'python-mode-hook #'flycheck-python-setup)
;; (setq python-shell-interpreter "C:/Users/tskdkim/AppData/Local/Continuum/Anaconda3/python.exe"
;;       python-shell-interpreter-args
;;       "-i C:/Users/tskdkim/AppData/Local/Continuum/Anaconda3/Scripts/ipython3.exe")	  
;;       ;"-i C:/Users/tskdkim/AppData/Local/Continuum/Anaconda3/Scripts/ipython-script.py")

;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "--simple-prompt -i")

