(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

(package-initialize)

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
    (stickyfunc-enhance monokai-theme monokai-alt-theme helm-etags-plus function-args flycheck-clang-analyzer cuda-mode cpputils-cmake company-irony-c-headers company-irony company-c-headers common-lisp-snippets cmake-project cmake-mode auto-correct auto-complete-c-headers ac-slime ac-clang ac-c-headers))))
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

(column-number-mode 1)

;; auto complete
(global-auto-complete-mode t)

;; for c++, cuda
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
; (fa-config-default)
(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)
              )))
(add-hook 'c++-mode-hook 'irony-mode)
;;(eval-after-load 'company
;;  '(add-to-list 'company-backends 'company-irony))


;; for lisp environment
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;; syntax check
(global-flycheck-mode)

;; highlight current light
(global-hl-line-mode +1)


;; for shell color
 (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
