;; =====================
;;; Windows & Frames ;;;
;; =====================
(server-start); For windows

;; =====================
;; Startup Performance
;; =====================
;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; =====================
;; Keep .emacs.d Clean
;; =====================
;; Keep transient cruft out of ~/.emacs.d
(setq user-emacs-directory "~/.cache/emacs/"
;; (setq user-emacs-directory "~/.cache/emacs/"
      backup-directory-alist `(("." . ,(expand-file-name "backups" user-emacs-directory)))
      url-history-file (expand-file-name "url/history" user-emacs-directory)
      auto-save-list-file-prefix (expand-file-name "auto-save-list/.saves-" user-emacs-directory)
      projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" user-emacs-directory))

;; Keep customization settings in a temporary file (thanks Ambrevar!)
(setq custom-file
      (if (boundp 'server-socket-dir)
          (expand-file-name "custom.el" server-socket-dir)
        (expand-file-name (format "emacs-custom-%s.el" (user-uid)) temporary-file-directory)))
(load custom-file t)


;; =====================
;; Coding System and Korean Language Support 
;; =====================
;; korean language and locale
;; Use Unix's \n (LF- Line Feed) and
;; utf instead of Windows \r\n (CRLF - Carriage Return and Line Feed) as end of line character. 
(setq-default buffer-file-coding-system 'utf-8-unix) 
(set-terminal-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "Korean")
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)

;; =====================
;; Package System Setup
;; =====================
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; =====================
;; Set System Configuration
;; =====================
;; Set user Initializes files DIR as user-init-dir
(defconst user-init-dir
  (cond ((boundp 'user-emacs-init-directory)
         user-emacs-init-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/my_el/")))

;; Set function of load custom.el 
(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
(load-file (expand-file-name file user-init-dir)))

(load-user-file "spell_check.el")  ;; Load Spell check hun spell + flyspell
(load-user-file "org_init.el")     ;; Org mode
(load-user-file "python_init.el")  ;; python mode
;; (load-user-file "term_init.el")    ;; Term mode 
;; ;; (load-user-file "latex_init.el")   ;; latex mode

;; Set Browse
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe")

;; Command to run cmd.exe. Usage: M-x run-cmdexe
;; (defun run-cmdexe ()
;;       (interactive)
;;       (let ((shell-file-name "cmd.exe"))
;;         (shell "*cmd.exe*")))

;; =====================
;; Basic UI Configuration
;; =====================
;; You will most likely need to adjust this font size for your system!
(defvar efs/default-font-size 180)
(defvar efs/default-variable-font-size 180)

;; Make frame transparency overridable
(defvar efs/frame-transparency '(90 . 90))

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))


(setq inhibit-startup-message t)    ;; Hide the startup message
(scroll-bar-mode -1)                ;; Disable visible scroller 
(tool-bar-mode -1)                  ;; Disable the toolbar
(tooltip-mode -1)                   ;; Disable tooltips 
(set-fringe-mode 10)                ;; Give some breathing room
(menu-bar-mode -1)                  ;; Disable the menu bar 
(setq visible-bell t)               ;; disable beep ring
(setq-default tab-width 4) ; emacs 23.1, 24.2, default to 8
(setq tab-width 4) ;; set current buffer's tab char's display width to 4 spaces

(setq frame-title-format "emacs@KD KIM")
(setq user-full-name "KD, KIM")
(setq user-mail-address "kissme2020@icloud.com")

;; line number of column
(column-number-mode)
(global-display-line-numbers-mode t)
;; Disable line numbers for some mode
(dolist (mode '(org-mode-hook
				term-mode-hook
				shell-mode-hook
				eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
;; (show-paren-mode)
;; (global-hl-line-mode) ; highlight line 
;; (winner-mode t)
;; (windmove-default-keybindings)

;; Font Configure 
;; ;; Not work "Font not available"
;; ;; (set-face-attribute 'default nil :font "Fira Code Retina" :height 280)
;; (set-face-attribute 'default nil :font "Fira Code Retina" :height efs/default-font-size)
;; ;; Set the fixed pitch face
;; (set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height efs/default-font-size)
;; ;; Set the variable pitch face
;; (set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)
;; Theme from doom-theme
;; https://github.com/hlissner/emacs-doom-themes
;; (load-theme 'material t)            ;; Load material theme


;; =====================
;; Keybinding Configuration
;; =====================
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; ;; General, Key mapping
;; (use-package general)
;; (general-define-key
;;  "C-M-j" 'counsel-switch-buffer    ;; counsel-switch-buffer
;;  "<escape>" 'keyboard-escape-quit  ;; Make ESC quit prompt 
;;  )

;; =====================
;; UI Configuration
;; =====================
;; Displaying a panel showing each key binding you use
;; in a panel on the right side of the frame
(use-package command-log-mode)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-hight 15)
  (doom-modeline-lsp t)
  (doom-modeline-github nil))

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-palenight t)

   ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  ;; :init
  (ivy-mode 1))


;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the folllowing command interactively so this mode line icons
;; display correctly
;;
;; M-x all-the-icons-install-fonts
;; downloaded folder: c:/Users/tskdkim/.emacs.d/downloaded_icons_fonts
;; Provide a temp directory where you'd like the fonts to be downloaded (let's call it $tempFonts)
;; Then, using Powershell, you can install them for your user with this:
;; > cd $tempFonts
;; > $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
;; > ls *.ttf | % { $destination.CopyHere($_.FullName, 0x10) }
(use-package all-the-icons) 



(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-ide-delay 1))

;; ivy-rich
(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         ("C-M-l" . counsel-imenu)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; Helpful 
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom (projectile-completion-system 'ivy)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; Magit 
(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Lsp mode
(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  :ensure t
  :hook (lsp-mode . dap-mode)
  
  :config
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (require 'dap-node)
  (dap-node-setup)


  :custom
  ;; ;; (lsp-enable-dap-auto-configure t)  
  ;; ;; Set up Node debugging
  ;; (require 'dap-node)
  (require 'dap-python)  
  ;; (dap-node-setup) ;; Automatically installs Node debug adapter if needed
  (dap-register-debug-template "Node: Attach"
    (list :type "node"
          :cwd nil
          :request "attach"
          :program nil
          :port 9229
          :name "Node::Run"))
  )

;; eshell
(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; ;; Bind some useful keys for evil-mode
  ;; (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  ;; (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  ;; (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt)

(use-package eshell
  :hook (eshell-first-time-mode . efs/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'git-radar))
  ;; (eshell-git-prompt-use-theme 'powerline))

;; File Management Dired
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first")))
  ;; :config
  ;; (evil-collection-define-key 'normal 'dired-mode-map
  ;;   "h" 'dired-single-up-directory
  ;;   "l" 'dired-single-buffer)))
  
