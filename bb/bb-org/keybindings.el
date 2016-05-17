;;(define-key evil-leader--default-map "oy" 'youdao-dictionary-search-at-point+)
(evil-leader/set-key "SPC" 'avy-goto-char)

;; Some basic keybindings.
(eval-after-load 'org
    '(progn
        (define-key global-map (kbd "<f1>") 'bb-org/hotspots)

        (define-key global-map (kbd "M-\\") 'org-ctrl-c-ret)

        
        (define-key global-map (kbd "C-c L") 'org-store-link)
        (define-key global-map (kbd "C-c a") 'org-agenda)
        ;;(define-key global-map (kbd "C-c r") 'org-remember)
        (define-key global-map (kbd "C-c g") 'gtd)

        (define-key global-map (kbd "M-c") 'copy-region-as-kill)
        (define-key global-map (kbd "M-v") 'evil-paste-after)
        (define-key global-map (kbd "<f9>") 'org-capture)
        (define-key org-mode-map (kbd "s-p") 'org-priority)
        (define-key org-mode-map (kbd "C-c l") 'org-mac-grab-link)
        (global-set-key (kbd "C-c b") 'org-iswitchb)
        (define-key evil-normal-state-map (kbd "C-c C-w") 'org-refile)
        (evil-leader/set-key-for-mode'org-mode
        "owh" 'plain-org-wiki-helm
        "owf" 'plain-org-wiki)
        (require 'ob-js)
        (require 'ob-shell)
       )
    )


