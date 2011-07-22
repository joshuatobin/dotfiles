(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(add-to-list 'load-path "~/.emacs.d/python-mode-6.0/")


;; show whitespace
(require 'show-wspace)
(add-hook 'font-lock-mode-hook 'highlight-tabs)
(add-hook 'font-lock-mode-hook 'highlight-trailing-whitespace)


(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))

(autoload 'python-mode "python-mode" "Python editing mode." t) 

;; python
;;
(defun ll-python-mode-hook()
   (font-lock-mode 1)
   (font-lock-fontify-buffer)
   (set-variable 'indent-tabs-mode nil)
   (set-variable 'py-indent-offset 4)
   (message "ll coding style function executed"))
(add-hook 'python-mode-hook 'll-python-mode-hook)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((((class color) (min-colors 8)) (:foreground "yellow" :weight bold))))
 '(font-lock-function-name-face ((((class color) (min-colors 8)) (:foreground "magenta" :weight bold)))))
