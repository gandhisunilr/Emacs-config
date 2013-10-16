(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; Key settings
(global-set-key [C-tab] 'next-multiframe-window)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-.") 'hs-hide-block)
(global-set-key (kbd "C-,") 'hs-show-block)

;; Org Mode
(add-to-list 'load-path "~/.emacs.d/packages/org-mode")
(setq org-directory "/home/sunil/Dropbox/TodoList")
(require 'org-mode-crate-init)

;; Mobile Org
(require 'org-mobile)
(setq org-mobile-inbox-for-pull "/home/sunil/Dropbox/TodoList/emacstodo.org")
(setq org-mobile-directory "/home/sunil/Dropbox/mobileOrg")
(define-key org-mode-map "\C-cp" 'org-mobile-pull)
(define-key org-agenda-mode-map "\C-cp" 'org-mobile-pull)
(setq org-mobile-directory "/home/sunil/Dropbox/mobileOrg")
(setq org-mobile-inbox-for-pull "/home/sunil/Dropbox/TodoList/emacstodo.org")

;; Theme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes (quote ("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" default)))
 '(fci-rule-color "#eee8d5")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors (quote (("#073642" . 0) ("#546E00" . 20) ("#00736F" . 30) ("#00629D" . 50) ("#7B6000" . 60) ("#8B2C02" . 70) ("#93115C" . 85) ("#073642" . 100))))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#cb4b16") (60 . "#b58900") (80 . "#859900") (100 . "#2aa198") (120 . "#268bd2") (140 . "#d33682") (160 . "#6c71c4") (180 . "#dc322f") (200 . "#cb4b16") (220 . "#b58900") (240 . "#859900") (260 . "#2aa198") (280 . "#268bd2") (300 . "#d33682") (320 . "#6c71c4") (340 . "#dc322f") (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defcustom magit-use-highlights nil
  "Use highlights in diff buffer."
  :group 'magit
  :type 'boolean)

(defun magit-highlight-section ()
  (let ((section (magit-current-section)))
    (when (not (eq section magit-highlighted-section))
      (when (and (not (eq section magit-highlighted-section))
                 magit-use-highlights)))))


;;  Auto complete
(add-to-list 'load-path "~/.emacs.d/packages/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/packages/auto-complete/ac-dict")
(ac-config-default)

;; Clocking Mode
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; Matlab Mode
(add-to-list 'load-path "~/.emacs.d/matlab-emacs")
(require 'matlab-load)
(matlab-cedet-setup)
(add-to-list 'ac-modes 'matlab-mode)
(provide 'init-matlab)

(setq matlab-indent-function-body t)  ; if you want function bodies indented
(setq matlab-verify-on-save-flag nil) ; turn off auto-verify on save
(defun my-matlab-mode-hook ()
    (setq fill-column 76))		; where auto-fill should wrap
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
(defun my-matlab-shell-mode-hook ()
    '())
(add-hook 'matlab-shell-mode-hook 'my-matlab-shell-mode-hook)
(setq matlab-shell-command-switches '("-nodesktop")) 
(setq matlab-shell-command "/usr/local/MATLAB/R2012a/bin/matlab")

;; Code Folding
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
(autoload 'hideshowvis-minor-mode
  "hideshowvis"
  "Will indicate regions foldable with hideshow in the fringe."
  'interactive)
(add-hook 'emacs-lisp-mode-hook
            '(lambda () (unless (equal "*scratch*" (buffer-name))
                          (hideshowvis-enable))))
(dolist (hook (list 'emacs-lisp-mode-hook
                    'c++-mode-hook))
  (add-hook hook 'hideshowvis-enable))
(hideshowvis-symbols)
