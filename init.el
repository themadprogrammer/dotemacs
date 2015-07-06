(setq inhibit-startup-message t)

(if (file-exists-p "~/.emacs.d/pre-init.el")
    (load-file "~/.emacs.d/pre-init.el"))

(require 'package)
; fetch the list of packages available 
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(or (file-exists-p package-user-dir)
    (package-refresh-contents))
(package-initialize)

; list the packages you want
(setq package-list '( auto-complete
		      auto-complete-c-headers
                      company
		      diminish
		      magit
		      vc
		      sr-speedbar
		      cl
		      yasnippet
		      rtags))

;(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
;                         ("gnu" . "http://elpa.gnu.org/packages/")
;                         ("marmalade" . "http://marmalade-repo.org/packages/")))


; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(add-to-list 'load-path "~/.emacs.d/modules")
(require 'init-general)
(require 'init-bde-style)
(require 'init-cpp)
(require 'init-rtags)
