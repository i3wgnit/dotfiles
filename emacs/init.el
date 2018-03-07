(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

;;;;;;;

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(org-agenda-files (quote ("~/calendar/assignments.org")))
 '(package-selected-packages
   (quote
    (evil-magit ox-twbs paredit flycheck smex spaceline linum-relative racket-mode haskell-mode auctex-latexmk auctex avy beacon rainbow-delimiters which-key swiper hungry-delete ido-vertical-mode helm-company helm diminish nlinum-relative dashboard htmlize org-bullets evil-collection evil-indent-textobject evil-surround evil-leader evil spacemacs-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "PfEd" :family "Iosevka")))))
