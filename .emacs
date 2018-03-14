

;; emacs configuration





;; point moving command

;; disconnect C-i from TAB
;; more info:
;; https://emacs.stackexchange.com/questions/220/how-to-bind-c-i-as-different-from-tab
;; https://emacs.stackexchange.com/questions/17509/how-to-distinguish-c-i-from-tab
(define-key input-decode-map [?\C-i] [C-i])
(global-set-key (kbd "<C-i>") 'previous-line) ;; mapping C-i
(local-set-key [tab] 'indent-for-tab-command) ;; remap tab

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

;; remove old key setting
(global-set-key (kbd "C-M-r") 'nil)
(define-key isearch-mode-map [?\C-r] nil)

(global-set-key (kbd "C-d") 'isearch-forward)
(global-set-key (kbd "C-M-d") 'isearch-forward-regexp)
(global-set-key (kbd "C-s") 'isearch-backward)
(global-set-key (kbd "C-M-s") 'isearch-backward-regexp)

;; keybinding in isearch-mode
(define-key isearch-mode-map [?\C-d] 'isearch-repeat-forward)
(define-key isearch-mode-map [?\C-s] 'isearch-repeat-backward)
(define-key isearch-mode-map [?\C-e] 'isearch-yank-kill)       ;; pasting into search box (when search)
;; (define-key isearch-mode-map (kbd "C-c") 'isearch-edit-string)



;; editing command
(global-set-key (kbd "C-n") nil)

(define-key key-translation-map [?\C-n] [?\C-?]) ;; remap backspace
(global-set-key (kbd "M-n") 'backward-kill-word)
(global-set-key (kbd "M-m") 'kill-whole-line)

(global-set-key (kbd "C-y") 'nil)
(global-set-key (kbd "M-y") 'nil)
(global-set-key (kbd "C-w") 'kill-ring-save) ;; copy
(global-set-key (kbd "M-w") 'kill-region)    ;; cut
(global-set-key (kbd "C-e") 'yank)           ;; paste
(global-set-key (kbd "M-e") 'yank-pop)
;; (global-set-key (kbd "C-\'") 'undo)



;; misc stuff
(global-set-key (kbd "C-a") 'find-file)
(global-set-key (kbd "M-a") 'find-file-other-window)

(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "M-o") 'recenter)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-\;") 'comment-line)
(global-set-key (kbd "C-r") (kbd "C-M-j C-SPC C-M-l")) ;; mark line
(define-key key-translation-map (kbd "C-\'") (kbd "\-")) ;; temporary adding in

(global-set-key (kbd "C-M-i") 'completion-at-point)
(global-set-key (kbd "C-M-k") 'hippie-expand)
(define-key key-translation-map (kbd "C-f") (kbd "TAB"))





(ido-mode 1)
(tool-bar-mode -1)
(electric-pair-mode 1)          ;; enbale electric-pair-mode

(setq column-number-mode t)     ;; display column
(setq inhibit-startup-screen t) ;; disable welcome screen

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


