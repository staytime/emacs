




;; setup package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons-dired dired-single org-roam org-ream "use-package" ox-twbs org-auto-tangle org-bullets rg diminish counsel-projectile projectile general all-the-icons doom-themes org-mode eaf-browser helpful counsel ivy-rich which-key ivy command-log-mode use-package pyvenv pyenv-mode yaml-mode terraform-mode web-mode auto-complete php-mode))
 '(show-paren-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
;; (package-install-selected-packages)
(package-install 'use-package)



(require 'use-package)
(setq use-package-always-ensure t)
(use-package diminish)
(use-package general)

;; setup use-package


;; (use-package zeno-theme)

;; (if window-system
;;   (load-theme 'deeper-blue 't))



;; setup env
(tool-bar-mode -1)
(menu-bar-mode -1)
;;(scroll-bar-mode -1)

(setq history-length 30)
(savehist-mode 1)

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
(setq st-chosen-font "Fira Code 16")
(set-face-attribute 'default nil :font st-chosen-font)
(set-frame-font st-chosen-font nil t)

(defun post-load-stuff ()
  (interactive)
  (split-window-horizontally))

(add-hook 'window-setup-hook 'post-load-stuff t)




(defun smarter-move-beginning-of-line (arg)
  "source: http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/

Move point back to indentation of beginning of line.
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

  (global-unset-key (kbd "C-b"))
  (global-unset-key (kbd "M-b"))

  (global-unset-key (kbd "C-y"))
  (global-unset-key (kbd "M-y"))
  (global-unset-key (kbd "C-M-y"))

  (global-unset-key (kbd "C-q"))

  (global-unset-key (kbd "M-f"))
  (global-unset-key (kbd "C-M-o"))
  ;; (global-unset-key (kbd "C-["))
  ;; (global-unset-key (kbd "C-]"))

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
  (define-key v-mode-map (kbd "C-a") 'counsel-find-file)
  (define-key v-mode-map (kbd "M-a") 'find-file-other-window)
  (define-key v-mode-map (kbd "C-a") 'find-file)
  (define-key v-mode-map (kbd "C-M-v") 'end-of-buffer)

  )

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer :ignore-auto :noconfirm)
  (recenter))


(setup-default-behaviour)
(global-auto-revert-mode)





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
(setup-base-keymap shell-mode-map)
(define-key shell-mode-map (kbd "C-p") 'comint-previous-input)
(define-key shell-mode-map (kbd "M-p") 'comint-next-input)
(define-key shell-mode-map (kbd "C-d") 'isearch-forward)

(require 'comint)
(setup-base-keymap comint-mode-map)




;; (ido-mode 1)
;; (add-hook 'ido-setup-hook 'ido-my-bindings)
;; (defun ido-my-bindings ()
;;   "Add keybindings for ido."
;;   (define-key ido-completion-map " " 'ido-next-match))



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
(setq-default c-basic-offset 4)
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
(global-set-key (kbd "C-M-v") 'end-of-buffer)



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
(global-set-key (kbd "C-a") 'counsel-find-file)
(global-set-key (kbd "M-a") 'find-file-other-window)

(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "M-o") 'revert-buffer-no-confirm)


(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-\;") 'comment-line)
(global-set-key (kbd "M-\;") 'comment-dwim)





(global-set-key (kbd "C-M-j") 'smarter-move-beginning-of-line)
(global-set-key (kbd "C-r") 'marking-line)
(global-set-key (kbd "M-r") 'exchange-point-and-mark)



(global-set-key (kbd "C-x w") 'create-buffer)


(add-hook 'before-save-hook 'delete-trailing-whitespace)


(global-set-key (kbd "C-s") 'replace-string)


(global-set-key (kbd "C-b") 'scroll-other-window)
(global-set-key (kbd "M-b") 'scroll-other-window-down)


;; new function in trial
;; M-.		xref-find-definitions
;; (global-set-key (kbd "C-\,") 'next-buffer)
;; (global-set-key (kbd "M-\,") 'previous-buffer)

(setq-default indent-tabs-mode nil)







(defun staytime/open-config ()
  (interactive)
  (find-file "~/.emacs"))

(defun staytime/open-notebook ()
  (interactive)
  (find-file "~/notebook.org"))

(general-define-key
 :prefix "C-h"
 "u" 'staytime/open-config
 "DEL" 'staytime/open-notebook)

(general-define-key
 :prefix "C-x"
 "!" 'eval-region)
;; (dired "~/work-sync")



;; (add-hook 'dired-mode-hook (lambda () (auto-revert-mode)))


(use-package lua-mode
  :config
  (setq lua-indent-level 2))

(put 'upcase-region 'disabled nil)






;; setup run-python setting

(use-package python
  :bind (:map inferior-python-mode-map
              ("M-n" . backward-kill-word)
              )
  :config
  (setq python-shell-interpreter "python3")
  (setq python-shell-completion-native-disabled-interpreters '("python3"))

  )

;; new stuff
(use-package ivy
  :diminish ivy-mode
  :bind (

         :map ivy-minibuffer-map
         ;("TAB" . ivy-alt-done)
         ;("C-l" . ivy-alt-done)
         ("C-p" . ivy-next-line)
         ("M-p" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-p" . ivy-next-line)
         ("M-p" . ivy-previous-line)
         ("C-j" . nil)
         ;;("C-m" . ivy-done)
         )


  :init
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers  (setq ivy-wrap t))

  )

(use-package swiper
  :after ivy
  :bind (([remap isearch-forward] . swiper)
         :map swiper-map
         ("C-d" . swiper-C-s)
         ("C-s" . swiper-isearch-C-r)))


(use-package ivy-rich
  :diminish
  :init (ivy-rich-mode 1))

(use-package counsel
  :diminish
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap execute-extended-command] . counsel-M-x)
  ([remap dired] . counsel-dired)
  ("C-x d" . counsel-dired)
  ("C-M-o" . counsel-switch-buffer)
  )

(general-define-key
 :keymaps 'counsel-describe-map
 "C-l" 'forward-char
 "C-j" 'backward-char
 "C-u" 'staytime/open-notebook)

;;(global-display-line-numbers-mode t)


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))



(use-package which-key
  :diminish
  :init (which-key-mode 1)
  :config
  (setq which-key-idle-delay 2))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; (use-package helpful
;;   :bind
;;   ([remap describe-command] . helpful-command)
;;   ([remap describe-key] . helpful-key)
;;   )



(use-package doom-themes
  :if window-system
  :init (load-theme 'doom-palenight 't))

;; :if window-system
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 16))

(use-package all-the-icons
  :if (display-graphic-p)
  :custom (all-the-icons 1.1))

(setq-default left-margin-width 1 right-margin-width 1)




(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom (projectile-completion-system 'ivy)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired))

(use-package rg)

(use-package counsel-projectile
  :config (counsel-projectile-mode))



(use-package magit
  :config
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t)
  :bind
  ("C-p" . magit-display-buffer))




(use-package pyvenv
  :config
  (pyvenv-mode t)

  ;; Set correct Python interpreter
  (setq pyvenv-post-activate-hooks
        (list (lambda ()
                (setq python-shell-interpreter (concat pyvenv-virtual-env "bin/python3")))))
  (setq pyvenv-post-deactivate-hooks
        (list (lambda ()
                (setq python-shell-interpreter "python3")))))

(defun staytime/org-toggle-display ()
  (interactive)
  (org-toggle-link-display)
  (if org-link-descriptive (org-display-inline-images) (org-remove-inline-images)))

(defun staytime/org-mode-setup ()
  (org-indent-mode)
  (org-display-inline-images))

(use-package org
  :pin org
  ;; :custom
  ;; (org-time-stamp-custom-formats '("<%Y-%m-%d %a>" . "<%Y-%m-%d %a %H:%M>" . "<%Y-%m>"))

  :config
  (setq org-html-checkbox-type 'unicode)
  (setq org-image-actual-width 'nil)
  (setq shr-max-image-proportion 0.8)
  (setq org-confirm-babel-evaluate 'nil)

  ;; setup python command for org-babel-execute-src-block
  (setq org-babel-python-command "python3")


  :hook (org-mode . staytime/org-mode-setup))


(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)
    (org . t))
  )

(general-define-key
 :keymaps 'org-mode-map
 "C-j" 'backward-char
 [remap backward-paragraph] 'org-backward-element
 [remap forward-paragraph] 'org-forward-element
 "C-c C-x C-v" 'staytime/org-toggle-display
 )




(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package org-auto-tangle
  :defer t)


(use-package dired-single)
(require 'dired-single)
(setq delete-by-moving-to-trash t)
(setq global-auto-revert-mode t)
(add-hook 'dired-mode-hook (lambda () (auto-revert-mode)))

(general-define-key
 :keymaps 'dired-mode-map
 "C-o" 'other-window
 "C-p" 'dired-display-file
 "C-c d" 'dired-create-directory
 [remap dired-find-file] 'dired-single-buffer
 [remap dired-mouse-find-file-other-window] 'dired-single-buffer-mouse
 [remap dired-up-directory] 'dired-single-up-directory
 )

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode)
  )




(use-package org-roam
  :custom
  (org-roam-directory "~/work-sync/org-roam")
  (org-roam-dailies-directory "journal/")
  ;; (org-roam-directory "~/work-sync/org-roam/")
  ;; (org-roam-completion-everywhere t)
  :config
  (org-roam-db-autosync-enable)
  :bind
  ("C-h DEL" . org-roam-dailies-find-today)
  ("C-c SPC" . org-roam-dailies-capture-today)
  )

(general-define-key
 :prefix "C-c n"
 "l" 'org-roam-buffer-toggle
 "f" 'org-roam-node-find
 "i" 'org-roam-node-insert
 "d" 'org-roam-dailies-find-date
 "SPC" 'org-roam-dailies-capture-today
)

;; (general-define-key
;;  :keymaps 'org-roam-mode-map

;;  )

(general-define-key
 "C-M-p" 'completion-at-point)
;; (dired "~/work-sync/")
