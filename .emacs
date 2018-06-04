




;; setup package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (auto-complete)))
)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; removing keybinding
;; (global-unset-key (kbd "C-h"))
(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "M-s"))
(global-unset-key (kbd "C-M-s"))



;; config for auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
(setq ac-auto-show-menu 0.2)
(setq ac-use-menu-map t)
(define-key ac-menu-map (kbd "C-n") 'nil)
(define-key ac-menu-map (kbd "C-M-k") 'ac-next)

;; shell mode binding
(require 'shell)
(require 'comint)
(define-key shell-mode-map (kbd "C-M-i") 'comint-previous-input)
(define-key shell-mode-map (kbd "C-M-k") 'comint-next-input)
(define-key shell-mode-map (kbd "M-n") 'backward-kill-word)
(define-key shell-mode-map (kbd "C-M-l") 'end-of-line)



;; point moving command

;; disconnect C-i from TAB
;; more info:
;; https://emacs.stackexchange.com/questions/220/how-to-bind-c-i-as-different-from-tab
;; https://emacs.stackexchange.com/questions/17509/how-to-distinguish-c-i-from-tab
(define-key input-decode-map [?\C-i] [C-i])
(global-set-key (kbd "<C-i>") 'previous-line) ;; mapping C-i
(local-set-key [tab] 'indent-for-tab-command) ;; remap tab to indent
(define-key key-translation-map (kbd "C-f") (kbd "TAB")) ;; remapping TAB

(global-set-key (kbd "C-k") 'next-line)
(global-set-key (kbd "C-l") 'forward-char)
(global-set-key (kbd "C-j") 'backward-char)

;; quick moving command
(global-set-key (kbd "M-k") 'forward-paragraph)
(global-set-key (kbd "M-i") 'backward-paragraph)
(global-set-key (kbd "M-l") 'forward-word)
(global-set-key (kbd "M-j") 'backward-word)
(global-set-key (kbd "C-M-j") 'beginning-of-line)
(global-set-key (kbd "C-M-l") 'end-of-line)
(global-set-key (kbd "C-p") 'scroll-up-command)
(global-set-key (kbd "M-p") 'scroll-down-command)



;; Searching command

;; remove old key setting
(global-unset-key (kbd "C-M-r"))
(define-key isearch-mode-map [?\C-r] nil)
(global-unset-key (kbd "M-d"))

(global-set-key (kbd "C-d") 'isearch-forward)
(global-set-key (kbd "C-M-d") 'isearch-forward-regexp)
;; (global-set-key (kbd "C-s") 'isearch-backward)
;; (global-set-key (kbd "C-M-s") 'isearch-backward-regexp)

;; keybinding in isearch-mode
(define-key isearch-mode-map [?\C-d] 'isearch-repeat-forward)
(define-key isearch-mode-map [?\C-s] 'isearch-repeat-backward)
(define-key isearch-mode-map [?\C-e] 'isearch-yank-kill)
;; (define-key isearch-mode-map (kbd "C-n") 'isearch-del-char)



;; Editing command
(global-unset-key (kbd "C-n"))
(define-key key-translation-map [?\C-n] [?\C-?]) ;; remap backspace
(global-set-key (kbd "M-n") 'backward-kill-word)
(global-set-key (kbd "M-m") 'kill-whole-line)

;; copy & paste
(global-set-key (kbd "C-w") 'kill-ring-save)
(global-set-key (kbd "M-w") 'kill-region)
(global-set-key (kbd "C-e") 'yank)
(global-set-key (kbd "M-e") 'yank-pop)



;; misc stuff
(global-set-key (kbd "C-a") 'find-file)
(global-set-key (kbd "M-a") 'find-file-other-window)

(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "M-o") 'recenter)
(global-set-key (kbd "C-M-o") 'switch-to-buffer)

(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-\;") 'comment-line)
(global-set-key (kbd "M-\;") 'comment-dwim)
;; (define-key key-translation-map (kbd "C-\'") (kbd "\-")) ;; temporary adding in
;; (global-set-key (kbd "C-x h") 'help-command)
;; (global-set-key (kbd "C-x s") 'previous-buffer)
;; (global-set-key (kbd "C-x d") 'next-buffer)
;; C-x s		save-some-buffers

;; custome function
(defun marking-line ()
  ;; marking the current line
  (interactive)
  (beginning-of-line)
  (set-mark-command nil)
  (end-of-line)
  (beep)
  )

(defun create-buffer ()
  "create empty buffer"
  (interactive)
  (switch-to-buffer (generate-new-buffer "new-file")))

;; binding custome command
(global-set-key (kbd "C-r") 'marking-line)
(global-set-key (kbd "M-r") 'exchange-point-and-mark)
(global-set-key (kbd "C-x w") 'create-buffer)



(ido-mode 1)

;; setup ui
(tool-bar-mode -1) ;; hide tool bar
(setq column-number-mode t)
(setq inhibit-startup-screen t) ;; disable welcome screen

(electric-pair-mode 1) ;; enbale electric-pair-mode
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-when-point-inside-paren t)

;; set custome font
;; (setq st-chosen-font '"Fira Code light-11")
(setq st-chosen-font "Fira Code-11")
(set-face-attribute 'default nil :font st-chosen-font)
(set-frame-font st-chosen-font nil t)

;; move backup file to /tmp
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(defun post-load-stuff ()
  (interactive)
  (toggle-frame-maximized)
  (split-window-horizontally)
  )

(add-hook 'window-setup-hook 'post-load-stuff t)


;; (global-set-key (kbd "M-\;") 'move-to-window-line-top-bottom)
;; M-!		shell-command
;; M-a		backward-sentence
;; mark-defun
