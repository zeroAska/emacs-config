(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;'("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.org/packages/")
   t)
  )

(package-initialize)


(dolist (package '(use-package))
   (unless (package-installed-p package)
     (package-install package)))

(dolist (package '(ivy counsel-gtags semantic flylisp flycheck-inline flycheck-irony compact-docstrings company-shell dtrt-indent smartparens yasnippet hl-todo auto-highlight-symbol multi-term elpy stickyfunc-enhance monokai-theme monokai-alt-theme helm-etags-plus function-args flycheck-clang-analyzer paren-face cuda-mode cpputils-cmake company-irony-c-headers company-irony company-c-headers common-lisp-snippets cmake-project cmake-mode auto-correct auto-complete-c-headers ac-slime ac-clang ac-c-headers yaml-mode hl-anything cdb julia-mode counsel-etags  ))
 (unless (package-installed-p package)
   (package-install package)))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(monokai))
 '(custom-safe-themes
   '("d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(lice markdown-preview-mode markdown-mode counsel-etags company-rtags rtags company-jedi paren-face paredit paren-face scheme-complete docker julia-shell julia-mode julia-repl flycheck-julia haskell-mode ta ssh cdb rustic flycheck-rust cargo company counsel-gtags flylisp flycheck-inline flycheck-irony compact-docstrings company-shell dtrt-indent smartparens yasnippet hl-todo auto-highlight-symbol multi-term elpy stickyfunc-enhance monokai-theme monokai-alt-theme helm-etags-plus function-args flycheck-clang-analyzer cuda-mode cpputils-cmake company-irony-c-headers company-irony company-c-headers common-lisp-snippets cmake-project cmake-mode auto-correct auto-complete-c-headers ac-slime ac-clang ac-c-headers)))
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
(setq path-to-ctags "/usr/bin/ctags") 
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
(global-auto-complete-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for c++, cuda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cc-mode)
;(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
; (fa-config-default)
;(add-hook 'c-mode-common-hook
;          (lambda ()
;            (if (derived-mode-p 'c-mode 'c++-mode)
;                (cppcm-reload-all)
;              )))
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (if  (not (or (string-match "^/usr/local/include/.*" buffer-file-name)
                              (string-match "^/usr/src/linux/include/.*" buffer-file-name)))
                    (cppcm-reload-all))
              )))
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
(setq company-idle-delay nil)
(setq company-minimum-prefix-length 1)
; Use tab key to cycle through suggestions.
; ('tng' means 'tab and go')
(company-tng-configure-default)
;; weight by frequency
(setq company-transformers '(company-sort-by-occurrence))
(setq company-backends (delete 'company-semantic company-backends))
;(setq company-backends (delete 'company-dabbrev company-backends))
;(global-set-key "\t" 'company-complete-common)
;;(define-key c-mode-map [(tab)] 'company-complete)
;(define-key c++-mode-map [(tab)] 'company-complete)
;(add-hook 'c++-mode-hook 'flycheck-mode)
;(add-hook 'c-mode-hook 'flycheck-mode)
;(add-to-list 'company-irony-c-headers-path-system "/usr/include/c++/5/")
(add-hook 'c++-mode-hook '(lambda () (which-func-mode t)))
(add-hook 'c++-mode-hook '(lambda () (linum-mode t)))
(with-eval-after-load 'company
  (company-ctags-auto-setup))
(setq company-ctags-extra-tags-files '("$HOME/TAGS" "/usr/include/TAGS" "/usr/local/include/TAGS"))
;;  '(add-to-list 'company-backends 'company-irony))


;; for lisp environment
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")
;(setq slime-contribs '(slime-fancy))

;; syntax check
(global-flycheck-mode)

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
;(global-semantic-idle-scheduler-mode 1)
;(semantic-enable)
(semantic-mode 1)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(require 'stickyfunc-enhance)
(which-function-mode 1)


;; auto complete templates
(require 'yasnippet)
(yas-global-mode 1)
(defun yas-no-expand-in-comment/string ()
  (setq yas-buffer-local-condition
        '(if (nth 8 (syntax-ppss)) ;; non-nil if in a string or comment
             '(require-snippet-condition . force-in-comment)
           t)))
(add-hook 'c-mode-hook 'yas-no-expand-in-comment/string)
(add-hook 'c++-mode-hook 'yas-no-expand-in-comment/string)


;; Package: smartparens
;; when you press RET, the curly braces automatically
;; add another newline
(require 'smartparens-config)
(show-smartparens-global-mode +1)
;;(smartparens-global-mode 1)
;;(sp-with-modes '(c-mode c++-mode)
;;  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
;;  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
;;                                            ("* ||\n[i]" "RET"))))

;; guess indent from files
(require 'dtrt-indent)
(dtrt-indent-mode 1)
(setq dtrt-indent-verbosity 0)




;; semantic completion
;(require 'semantic)
;(global-semanticdb-minor-mode 1)
;(global-semantic-idle-scheduler-mode 1)
;(semantic-mode 1)
;(semantic :disabled-for emacs-lisp)

	;; clear eshell
;(defun eshell/clear ()
 ; "Clear the eshell buffer."
  ;(let ((inhibit-read-only t))
   ; (erase-buffer)
    ;    (eshell-send-input)))

;; for cuda 
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for julia
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'julia-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for scheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq scheme-program-name "petite")
(eval-after-load 'scheme                                                 
   '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent)) 
;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))

(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (delete-other-windows)
    (split-window-vertically (floor (* 0.68 (window-height))))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window 1))
   ((not (find "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))
               :test 'equal))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window -1))))

(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))

(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

(add-hook 'scheme-mode-hook
  (lambda ()
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))

(require 'paren-face)
(global-paren-face-mode 1)
(show-paren-mode 1)
;;(set-face-foreground 'paren-face "DimGray")


;; for ctags
(setq path-to-ctags "/usr/bin/ctags") 
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "find %s -name '*.hpp' -o -name '*.h' -o -name '*.cuh' -o -name '*.py' -o -name '*.c' -o -name '*.cpp' -o -name '*.cu' | xargs %s -f TAGS -e -R" (directory-file-name dir-name) path-to-ctags))
  )
(define-key global-map "\M-*" 'pop-tag-mark)



;; for custom files to load
;; for auto header insert
(add-to-list 'load-path "~/.emacs.d/custom")
(require 'header2)
;(autoload 'auto-update-file-header "header2")
;(add-hook 'write-file-hooks 'auto-update-file-header)
;(autoload 'auto-make-header "header2")
;(add-hook 'emacs-lisp-mode-hook 'auto-make-header)
;(add-hook 'c-mode-common-hook   'auto-make-header)
;(add-hook 'c++-mode-common-hook   'auto-make-header)
;(add-hook 'python-mode-common-hook   'auto-make-header)

