;;; package --- Sumnmary
;;; Commentary:
;;; Code:

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

(dolist (package '(ivy counsel-gtags semantic flylisp flycheck-inline flycheck-irony compact-docstrings company-shell dtrt-indent smartparens yasnippet hl-todo auto-highlight-symbol multi-term elpy stickyfunc-enhance monokai-theme monokai-alt-theme function-args flycheck-clang-analyzer paren-face cuda-mode cpputils-cmake company-irony-c-headers company-irony company-c-headers common-lisp-snippets cmake-project cmake-mode auto-correct auto-complete-c-headers ac-slime ac-clang ac-c-headers yaml-mode hl-anything cdb julia-mode counsel-etags  helm-gtags modern-cpp-font-lock lsp-mode auctex latex-preview-pane pdf-tools gscholar-bibtex julia-vterm julia-repl gptel lsp-latex markdown-mode auto-header))
 (unless (package-installed-p package)
   (package-install package)))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(monokai))
 '(custom-safe-themes
   '("8dbbcb2b7ea7e7466ef575b60a92078359ac260c91fe908685b3983ab8e20e3f"
     "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27"
     "d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279"
     "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9"
     "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9"
     "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff"
     default))
 '(helm-completion-style 'helm)
 '(ignored-local-variable-values
   '((company-clang-arguments
      "-I/home/rayzhang/unified_cvo/include/UnifiedCvo/"
      "-I/usr/include/c++/9/" "-I/usr/include/opencv2/"
      "-I/usr/include/ceres/" "-I/usr/include/eigen3/"
      "-I/usr/include/pcl-1.9/")))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(auto-header avy company dap-mode dockerfile-mode flycheck helm-lsp
                 helm-xref highlight-doxygen hydra julia-repl
                 julia-shell julia-vterm lsp-mode lsp-treemacs
                 markdown-preview-mode pdf-tools projectile
                 racket-mode skeletor which-key yasnippet)))


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
;(setq path-to-ctags "/usr/bin/ctags") 
;(defun create-tags (dir-name)
;    "Create tags file."
;    (interactive "DDirectory: ")
;    (shell-command
;     (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name))))


(setq-default indent-tabs-mode nil)
(c-set-offset 'substatement-open 0)
(setq-default c-basic-offset 2)
;(setq c-default-style "K&R"
;      c-basic-offset 2)


;;(setq default-tab-width 4)

(column-number-mode 1)

;; auto complete
;(global-auto-complete-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for c++, cuda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cc-mode)
;(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
;; for cuda 
;;(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
;;(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

; (fa-config-default)
;(add-hook 'c-mode-common-hook
;          (lambda ()
;            (if (derived-mode-p 'c-mode 'c++-mode)
;                (cppcm-reload-all)
                                        ;              )))



(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
    projectile hydra flycheck company avy which-key helm-xref dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'python-mode-hook 'lsp)
(add-hook 'LaTeX-mode-hook 'lsp)
 (setq company-minimum-prefix-length 2)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))



;; highlight current light
(global-hl-line-mode +1)


;; for shell color
 (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

(require 'flycheck)
;; Force flycheck to always use c++11 support. We use
;; the clang language backend so this is set to clang
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-language-standard "c++11")))
;(eval-after-load 'flycheck
;  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
(global-flycheck-mode)


;; for yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; highlight symbol
(add-hook 'after-init-hook 'global-auto-highlight-symbol-mode)

;; enable search at current symbol
(global-set-key (kbd "M-s") 'isearch-forward-symbol-at-point)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for julia
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package julia-mode
  :ensure t)


(defun my/julia-repl-send-cell() 
  ;; "Send the current julia cell (delimited by ###) to the julia shell"
  (interactive)
  (save-excursion (setq cell-begin (if (re-search-backward "^###" nil t) (point) (point-min))))
  (save-excursion (setq cell-end (if (re-search-forward "^###" nil t) (point) (point-max))))
  (set-mark cell-begin)
  (goto-char cell-end)
  (julia-repl-send-region-or-line)
  (next-line))

;;(evil-add-command-properties #'my/julia-repl-send-cell :jump t)

(use-package julia-repl
  :ensure t
  :hook (julia-mode . julia-repl-mode)

  :init
  (setenv "JULIA_NUM_THREADS" "8")

  :config
  ;; Set the terminal backend
  (julia-repl-set-terminal-backend 'vterm)
  
  ;; Keybindings for quickly sending code to the REPL
  (define-key julia-repl-mode-map (kbd "<f5>") 'my/julia-repl-send-cell)
  (define-key julia-repl-mode-map (kbd "<f6>") 'julia-repl-send-line)
  (define-key julia-repl-mode-map (kbd "<S-return>") 'julia-repl-send-buffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for scheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cmuscheme)
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; for eshall color
(add-hook 'eshell-preoutput-filter-functions
          'ansi-color-filter-apply)

;; for python
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt --InteractiveShell.display_page=True")


;; for latex
(require 'gscholar-bibtex)
;(add-to-list 'load-path "/path/to/lsp-latex")
(require 'lsp-latex)
(setq TeX-engine 'xetex)
;; "texlab" must be located at a directory contained in `exec-path'.
;; If you want to put "texlab" somewhere else,
;; you can specify the path to "texlab" as follows:
(cond ((eq window-system 'gnu/linux) (setq lsp-latex-texlab-executable "/usr/bin/texlab"))
      ((eq window-system 'darwin) (progn
                                    (setq markdown-command "/opt/homebrew/bin/multimarkdown --smart --notes")
                                    (setq lsp-latex-texlab-executable "/opt/homebrew/bin/texlab")))
  (t (setq lsp-latex-texlab-executable nil)))


(with-eval-after-load "tex-mode"
 (add-hook 'tex-mode-hook 'lsp)
 (add-hook 'latex-mode-hook 'lsp)
 (add-hook 'Latex-mode-hook 'lsp))

;(defvar tex-electric-pairs '((?$ . ?$)) "Electric pairs for LaTeX-mode.")
;(defun tex-add-electric-pairs ()
;  (setq-local electric-pair-pairs (append electric-pair-pairs tex-electric-pairs))
;  (setq-local electric-pair-text-pairs electric-pair-pairs))
;(add-hook 'LaTeX-mode-hook 'tex-add-electric-pairs)

(use-package tex-site
  :defer t
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :config (progn
            (setq TeX-auto-save t)
            (setq TeX-parse-self t)
            (setq  TeX-source-correlate-mode t)
            (setq-default TeX-master nil)
            (setq TeX-command-force "LaTeX")
            (setq TeX-view-program-selection
                  '((output-dvi "PDF Tools")
                    (output-pdf "PDF Tools")))
            (add-hook 'LaTeX-mode-hook 'visual-line-mode)
            ;(add-hook 'LaTeX-mode-hook '(lambda () Tex-source-correlate-mode))
            (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)       
            (add-hook 'LaTeX-mode-hook 'linum-mode)
            (add-hook 'LaTeX-mode-hook 'flyspell-mode)
            (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
            (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
            (add-hook 'LaTeX-mode-hook
                      '(lambda ()
                         (define-key LaTeX-mode-map (kbd "$") 'self-insert-command)))
            (add-hook 'pdf-view-mode-hook
                      (lambda ()
                        (pdf-view-fit-page-to-window) ))
            (setq TeX-PDF-mode t)
            (latex-preview-pane-enable)
  )
)


;;;
(require 'saveplace)
(setq-default save-place t)


;;; llm
;; DeepSeek offers an OpenAI compatible API
(require 'gptel)
(gptel-make-openai "DeepSeek"       ;Any name you want
  :host "api.deepseek.com"
  :endpoint "/chat/completions"
  :stream t
  :key "sk-c87f76a358a74f06b40a93d206f99de4"               ;can be a function that returns the key
  :models '(deepseek-chat deepseek-coder))

;(use-package copilot
;  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
;  :ensure t)
;(add-hook 'prog-mode-hook 'copilot-mode)
;(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
;(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
;(add-to-list 'copilot-major-mode-alist '("python" . "ruby"))

;; markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("\\.md\\'" . gfm-mode)))


;; my own customized scripts
(add-to-list 'load-path "~/.emacs.d/non-elpa/")


;; header
(load "header2.el")
(load "setup-header2.el")
;;(add-hook 'write-file-hooks 'auto-update-file-header)     
;(add-hook 'emacs-lisp-mode-hook 'auto-make-header)     
;(add-hook 'c-mode-common-hook 'auto-make-header)     
;;(add-hook 'tex-mode-hook 'auto-make-header) 
                                        ;(add-hook 'julia-mode-hook 'auto-make-header)


;; skeleton
(load "skeleton_macro.el")

;; date
(load "datetime.el")


;; doxygen
;; c
(load "gendoxy.el")
