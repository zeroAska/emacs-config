(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

(package-initialize)


(dolist (package '(use-package))
   (unless (package-installed-p package)
     (package-install package)))

(dolist (package '(ivy counsel-gtags  cpp-capf flylisp flycheck-inline flycheck-irony compact-docstrings company-shell company-lsp dtrt-indent smartparens yasnippet hl-todo auto-highlight-symbol multi-term elpy stickyfunc-enhance monokai-theme monokai-alt-theme helm-etags-plus function-args flycheck-clang-analyzer cuda-mode cpputils-cmake company-irony-c-headers company-irony company-c-headers common-lisp-snippets cmake-project cmake-mode auto-correct auto-complete-c-headers ac-slime ac-clang ac-c-headers ))
 (unless (package-installed-p package)
   (package-install package)))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (counsel-gtags cpp-capf flylisp flycheck-inline flycheck-irony compact-docstrings company-shell company-lsp dtrt-indent smartparens yasnippet hl-todo auto-highlight-symbol multi-term elpy stickyfunc-enhance monokai-theme monokai-alt-theme helm-etags-plus function-args flycheck-clang-analyzer cuda-mode cpputils-cmake company-irony-c-headers company-irony company-c-headers common-lisp-snippets cmake-project cmake-mode auto-correct auto-complete-c-headers ac-slime ac-clang ac-c-headers))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;(setq semantic-c-obey-conditional-section-parsing-flag nil)

;; cedet
;;(load-file "/usr/share/emacs/24.5/lisp/cedet/cedet.elc")
;(global-ede-mode 1)                      ; Enable the Project management system
;;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
;;(global-srecode-minor-mode 1)            ; Enable template insertion menu
;;(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;;(semantic-mode 1)

;; hight current

;; for auto complete
;(ac-config-default)
;(global-auto-complete-mode t)
(electric-pair-mode 1)

;; for ctags
(setq path-to-ctags "/usr/bin/ctags-exuberant") 
(defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name))))


(setq-default indent-tabs-mode nil)
(c-set-offset 'substatement-open 0)
(setq-default c-basic-offset 2)
;(setq c-default-style "K&R"
;      c-basic-offset 2)


;;(setq default-tab-width 4)

(column-number-mode 1)

;; auto complete
;(global-auto-complete-mode t)

;; for c++, cuda
(require 'cc-mode)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
; (fa-config-default)
(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)
              )))
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


;;(eval-after-load 'company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(require 'company-c-headers)
(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))
(setq company-idle-delay 0)
(setq company-backends (delete 'company-semantic company-backends))
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
;(add-to-list 'company-irony-c-headers-path-system "/usr/include/c++/5/")


;;  '(add-to-list 'company-backends 'company-irony))


;; for lisp environment
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;; syntax check
;; (global-flycheck-mode)

;; highlight current light
(global-hl-line-mode +1)


;; for shell color
 (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)


;; for yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; highlight symbol
(add-hook 'after-init-hook 'global-auto-highlight-symbol-mode)

;; enable search at current symbol
(global-set-key (kbd "C-S-s") 'isearch-forward-symbol-at-point)


;; sticky function mode -> show which function you are in currently
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(semantic-mode 1)
(require 'stickyfunc-enhance)
(which-function-mode 1)


;; auto complete templates
(require 'yasnippet)
(yas-global-mode 1)



;; Package: smartparens
;; when you press RET, the curly braces automatically
;; add another newline
(require 'smartparens-config)
(show-smartparens-global-mode +1)
(smartparens-global-mode 1)
(sp-with-modes '(c-mode c++-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                            ("* ||\n[i]" "RET"))))

;; guess indent from files
(require 'dtrt-indent)
(dtrt-indent-mode 1)
(setq dtrt-indent-verbosity 0)




;; semantic completion
(require 'semantic)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-mode 1)
