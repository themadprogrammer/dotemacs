;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Customizations

; Customizations for window system
(when (window-system)
	(set-face-foreground 'minibuffer-prompt "black"))

; Customizations for no window system
(when (not (window-system))
  (menu-bar-mode -1)                                ; Turn off Menu Bar 
  (set-face-foreground 'minibuffer-prompt "white")) ; Set Forground of minibuffer

; Yeah for C-<arrow> window changes
(windmove-default-keybindings)

;; Text Mode is the default
(setq default-major-mode 'text-mode)
;;Why does this fail?
;;(add-hook ’text-mode-hook ’turn-on-auto-fill)

(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)
(provide 'init-general)
