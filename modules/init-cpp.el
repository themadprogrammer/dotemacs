;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Development
; Version Control
(require 'vc)

(require 'sr-speedbar)
(custom-set-variables '(sr-speedbar-right-side nil)
              '(sr-speedbar-skip-other-window-p t)
              '(sr-speedbar-max-width 40)
              '(sr-speedbar-width 40))

(global-set-key (kbd "C-<f3>") 'sr-speedbar-toggle)
(global-set-key (kbd "C-<f4>") 'sr-speedbar-refresh-toggle)
					;(sr-speedbar-open)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C++ Fun

;; Indent on newline
(global-set-key (kbd "RET") 'newline-and-indent)
(add-hook 'c-mode-common-hook   'hs-minor-mode)

; Setup Keys for C++ Programming
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'gdb)

(global-set-key [f11] 'goto-line )
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)					;

; Load Bloomberg helper routines
(require 'init-src)
(global-set-key (kbd "M-1") 'rotate-sources)

; Yeah Clang
;(;load-file "~/emacs/clang-format.el")
;(;global-set-key (kbd "C-<f1>") 'clang-format-region)

(require 'xcscope)
(define-key global-map [(control f3)]  'cscope-set-initial-directory)
(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
(define-key global-map [(control f5)]  'cscope-find-this-symbol)
(define-key global-map [(control f6)]  'cscope-find-global-definition)
(define-key global-map [(control f7)]
  'cscope-find-global-definition-no-prompting)
(setq cscope-do-not-update-databsae t )

(add-hook 'c-mode-common-hook 'hs-minor-mode)

(autoload 'company-mode "company" nil t)
(global-company-mode)
(require 'yasnippet)
(yas-load-directory "~/.emacs.d/snippets" )
(diminish 'yas-minor-mode )
(add-to-list 'c-mode-common-hook (lambda () (yas-minor-mode)))
(define-key yas-minor-mode-map (kbd "C-c y") 'yas-expand)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<tab>") nil)

(provide 'init-cpp)  
