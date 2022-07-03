




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
 '(column-number-mode t)
 '(package-selected-packages
   '(
     yaml-mode
     fira-code-mode
     lua-mode
     terraform-mode
     web-mode
     auto-complete
     php-mode
     cc-mode
     ))
 
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; setup env
;; (tool-bar-mode -1) ;; hide tool bar
(if window-system
    (tool-bar-mode -1))
(setq column-number-mode t)
(setq inhibit-startup-screen t) ;; disable welcome screen
(electric-pair-mode 1) ;; enbale electric-pair-mode
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-when-point-inside-paren t)

;; move backup file to /tmp
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; set custome font
;; (setq st-chosen-font "Fira Code light-11")
(setq st-chosen-font "Fira Code-11")
(set-face-attribute 'default nil :font st-chosen-font)
(set-frame-font st-chosen-font nil t)

(defun post-load-stuff ()
  (interactive)
  (toggle-frame-maximized)
  (split-window-horizontally))

(add-hook 'window-setup-hook 'post-load-stuff t)



(defun smarter-move-beginning-of-line (arg)
  ;; http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
  "Move point back to indentation of beginning of line.
Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(defun marking-line ()
  "marking the current line"
  (interactive)
  (smarter-move-beginning-of-line nil)
  (set-mark-command nil)
  (end-of-line))

(defun create-buffer ()
  "create empty buffer"
  (interactive)
  (switch-to-buffer (generate-new-buffer "new-file")))



(defun setup-default-behaviour ()
  ;; removing keybinding
  (global-unset-key (kbd "M-s"))
  (global-unset-key (kbd "C-M-s"))
  (global-unset-key (kbd "C-p"))
  (global-unset-key (kbd "M-p"))
  (global-unset-key (kbd "C-M-k"))
  
  )

(defun setup-base-keymap (v-mode-map)
  "adjusting @v-mode-map to my liking." 


  (define-key v-mode-map (kbd "C-k") 'next-line)
  (define-key v-mode-map (kbd "C-l") 'forward-char)
  (define-key v-mode-map (kbd "C-j") 'backward-char)

  (define-key v-mode-map (kbd "C-M-j") 'smarter-move-beginning-of-line)
  (define-key v-mode-map (kbd "C-M-l") 'end-of-line)

  (define-key v-mode-map (kbd "C-\;") 'comment-line)
  (define-key v-mode-map (kbd "M-\;") 'comment-dwim)

  
  (define-key v-mode-map (kbd "M-n") 'backward-kill-word)
  (define-key v-mode-map (kbd "M-m") 'kill-whole-line)

  
  
  (define-key v-mode-map (kbd "C-r") 'marking-line)
  
  (define-key v-mode-map (kbd "C-s") 'replace-string)
  
  (define-key v-mode-map (kbd "C-d") 'isearch-forward)  
  (define-key v-mode-map (kbd "M-n") 'backward-kill-word)

  (define-key v-mode-map (kbd "C-e") 'yank)
  (define-key v-mode-map (kbd "M-e") 'yank-pop)
  (define-key v-mode-map (kbd "C-w") 'kill-ring-save)
  (define-key v-mode-map (kbd "M-w") 'kill-region)

  
  (define-key v-mode-map (kbd "C-o") 'other-window)
  (define-key v-mode-map (kbd "C-a") 'find-file)
  (define-key v-mode-map (kbd "M-a") 'find-file-other-window)

  )

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer :ignore-auto :noconfirm)
  (recenter))


(setup-default-behaviour)







;; setup for auto-complete
;; config for auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
(setq ac-auto-show-menu 0.2)
(setq ac-use-menu-map t)
(define-key ac-menu-map (kbd "C-n") 'nil)
(define-key ac-menu-map (kbd "C-p") 'ac-next)
(define-key ac-menu-map (kbd "M-p") 'ac-previous)




;; setup for shell
(require 'shell)
(require 'comint)
(setup-base-keymap shell-mode-map)
(define-key shell-mode-map (kbd "C-p") 'comint-previous-input)
(define-key shell-mode-map (kbd "M-p") 'comint-next-input)



(ido-mode 1)
(add-hook 'ido-setup-hook 'ido-my-bindings)
(defun ido-my-bindings ()
  "Add keybindings for ido."
  (define-key ido-completion-map " " 'ido-next-match))



;; setup for web-mode
(require 'web-mode)
(setup-base-keymap web-mode-map)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))





(require 'php-mode)
(setup-base-keymap php-mode-map)


(require 'cc-mode)
(setup-base-keymap c-mode-map)
(setup-base-keymap c++-mode-map)

(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

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



;; Searching command

;; remove old key setting & rebind
(global-unset-key (kbd "M-d"))
(global-unset-key (kbd "C-M-r"))
(global-set-key (kbd "C-d") 'isearch-forward)
(global-set-key (kbd "C-M-d") 'isearch-forward-regexp)

;; keybinding in isearch-mode
(define-key isearch-mode-map [?\C-r] nil)
(define-key isearch-mode-map [?\C-d] 'isearch-repeat-forward)
(define-key isearch-mode-map [?\C-s] 'isearch-repeat-backward)
(define-key isearch-mode-map [?\C-e] 'isearch-yank-kill)



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
(global-set-key (kbd "M-o") 'revert-buffer-no-confirm)
(global-set-key (kbd "C-M-o") 'switch-to-buffer)

(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-\;") 'comment-line)
(global-set-key (kbd "M-\;") 'comment-dwim)





(global-set-key (kbd "C-M-j") 'smarter-move-beginning-of-line)
(global-set-key (kbd "C-r") 'marking-line)
(global-set-key (kbd "M-r") 'exchange-point-and-mark)



(global-set-key (kbd "C-x w") 'create-buffer)


(defun open-config ()
  (interactive)
  (find-file "~/.emacs"))

(global-set-key (kbd "C-h u") 'open-config)
(global-set-key (kbd "C-s") 'replace-string)

;; new function in trial
;; M-.		xref-find-definitions
;; (global-set-key (kbd "C-\,") 'next-buffer)
;; (global-set-key (kbd "M-\,") 'previous-buffer)

(setq-default indent-tabs-mode nil)


(setq lua-indent-level 2)
(put 'upcase-region 'disabled nil)




;; (global-fira-code-mode)
