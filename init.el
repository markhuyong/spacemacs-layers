(defun dotspacemacs/layers ()
  (setq-default

   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation nil
   dotspacemacs-ask-for-lazy-installation nil
   dotspacemacs-configuration-layer-path '("~/.spacemacs.private/")
   dotspacemacs-delete-orphan-packages t

   dotspacemacs-configuration-layers
   '((auto-completion
      :variables
      auto-completion-return-key-behavior nil
      auto-completion-tab-key-behavior 'cycle
      auto-completion-private-snippets-directory "~/.spacemacs.d/snippets/"
      :disabled-for org erc)
     ;;bibtex
     (c-c++ :variables c-c++-enable-clang-support t)
     clojure
     command-log
     csharp
     dash
     django
     elixir
     elfeed
     emacs-lisp
     emoji
     erc
     ess
     (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     extra-langs
     fasd
     games
     git
     github
     haskell
     html
     (ibuffer :variables ibuffer-group-buffers-by nil)
     ipython-notebook
     javascript
     latex
     lua
     markdown
     org
     (python :variables python-test-runner 'pytest)
     ranger
     react
     ruby
     rust
     ;;Scala
     scala
     (scala :variables scala-enable-eldoc-mode t)
     
     semantic
     (shell :variables shell-default-shell 'eshell)
     shell-scripts
     (spell-checking :variables spell-checking-enable-by-default nil)
     spotify
     (syntax-checking :variables syntax-checking-enable-by-default nil)
     typography
     (version-control :variables version-control-diff-tool 'diff-hl)
     vimscript
     yaml

     ;; Non-contrib layers
     encoding
     evil-little-word
     no-dots
     operators

     ;; Personal config layers
     bb-c
     bb-erc
     bb-ibuffer
     bb-git
     bb-keys
     bb-latex
     bb-org
     bb-theming
     bb-web)

   dotspacemacs-additional-packages
   '(cuda-mode
     defproject
     editorconfig
     helm-flycheck
     kivy-mode
     nameless
     nginx-mode
     powerline
     (spaceline :location "~/repos/spaceline/"))

   dotspacemacs-excluded-packages
   '(clj-refactor
     elfeed-org
     julia-mode
     volatile-highlights
     vi-tilde-fringe)))

(defun dotspacemacs/layers/SINTEFPC6985 ()
  (bb/remove-elts-or-cars 'dotspacemacs-configuration-layers
    '(dash fasd spell-checking spotify))
  (bb/remove-elts-or-cars 'dotspacemacs-additional-packages
    '(powerline spaceline)))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 10
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'vim
   dotspacemacs-startup-banner nil
   dotspacemacs-startup-lists '(recents bookmarks projects)
   dotspacemacs-startup-recent-list-size 5
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes
   '(monokai material spacemacs-dark spacemacs-light solarized-dark leuven zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font
   `("Source Code Pro"
     :size ,(if (spacemacs/system-is-mswindows) 16 13)
     :weight demibold :width normal :powerline-scale 1.15)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab t
   dotspacemacs-command-key "SPC"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-ex-substitute-global t
   dotspacemacs-default-layout-name "Home"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 10
   dotspacemacs-helm-resize t
   dotspacemacs-helm-no-header t
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-transient-state t
   dotspacemacs-which-key-delay 1.0
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide nil
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling nil
   dotspacemacs-line-numbers nil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed))

(defun dotspacemacs/user-init ()
(global-set-key (kbd "C-+") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease)

  (setq configuration-layer--elpa-archives
        '(("melpai-cn" . "http://elpa.zilongshanren.com/melpa/")
          ("org-cn"   . "http://elpa.zilongshanren.com/org/")
          ("gnu-cn"   . "http://elpa.zilongshanren.com/gnu/")))
  
  ;; https://github.com/syl20bnr/spacemacs/issues/2705
  ;; (setq tramp-mode nil)
  (setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

  ;; ss proxy. But it will cause anacond-mode failed.
  (setq socks-server '("Default server" "127.0.0.1" 1080 5))
  (setq evil-shift-round nil)
  (setq byte-compile-warnings '(not obsolete))

  (set-default 'server-socket-dir "~/.emacs.d/server")
  (if (functionp 'window-system)
      (when (and (window-system)
                 (>= emacs-major-version 24))
        (server-start)))
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(ansi-color-faces-vector
     [default default default italic underline success warning error])
   '(custom-enabled-themes (quote (tango-dark))))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )
  (set-face-attribute 'default nil :height 160)
  (toggle-frame-maximized)
  ;;(fset 'evil-visual-update-x-selection 'ignore)

  (setq-default

   ;; Miscellaneous
   vc-follow-symlinks t
   ring-bell-function 'ignore
   require-final-newline t
   indent-tabs-mode nil
   system-time-locale "C"
   paradox-github-token t
   open-junk-file-find-file-function 'find-file

   ;; Backups
   backup-directory-alist `((".*" . ,temporary-file-directory))
   auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
   backup-by-copying t
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   make-backup-files nil

   ;; Evil
   evil-shift-round nil

   ;; Whitespace mode
   whitespace-style '(face tabs tab-mark newline-mark)
   whitespace-display-mappings
   '((newline-mark 10 [172 10])
     (tab-mark 9 [9655 9]))

   ;; Smartparens
   sp-highlight-pair-overlay nil
   sp-highlight-wrap-overlay nil
   sp-highlight-wrap-tag-overlay nil

   ;; Magit
   magit-popup-show-common-commands nil
   magit-gh-pulls-pull-detail-limit 200

   ;; Flycheck
   flycheck-check-syntax-automatically '(save mode-enabled)

   ;; Avy
   avy-all-windows 'all-frames

   ;; Ranger
   ranger-override-dired t

   ;; Matlab
   matlab-auto-fill nil
   matlab-fill-code nil
   matlab-functions-have-end t
   matlab-indent-function-body t

   ;; LaTeX
   font-latex-fontify-script nil
   TeX-newline-function 'reindent-then-newline-and-indent

   ;; Shell
   shell-default-term-shell "/bin/zsh"

   ;; Web
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2

   ;; Emacs Lisp
   nameless-global-aliases
   '(("sm" . "spacemacs")
     ("dsm" . "dotspacemacs")
     ("cfl" . "configuration-layer")
     ("sl" . "spaceline")
     ("et" . "evil-targets")
     ("eip" . "evil-indent-plus"))
   nameless-discover-current-name nil
   nameless-prefix ""
   nameless-separator nil

   ;; Rust
   rust-indent-method-chain t

   ;; Elfeed
   elfeed-feeds
   '("https://www.reddit.com/r/emacs/.rss"
     "http://xkcd.com/rss.xml")

   ;; IRC
   ;;erc-server-list
   ;;`(("irc.gitter.im" :port "6667" :nick "TheBB" :full-name ,bb/full-name
   ;;   :ssl t :password ,bb/gitter-pwd)
   ;;  ("irc.freenode.net" :port "6667" :nick "TheBB" :full-name ,bb/full-name))
   ;;erc-autojoin-channels-alist
   ;;'(("1\\.0\\.0" "#syl20bnr/spacemacs" "#syl20bnr/spacemacs-devel") ; Gitter
   ;;  ("irc.gitter.im" "#syl20bnr/spacemacs" "#syl20bnr/spacemacs-devel")
   ;;  ("freenode\\.net" "#emacs" "#emacs-beginners" "#spacemacs" "#evil-mode"))
   ))

(defun dotspacemacs/user-config ()

  ;; Settings
  (setq-default
   tab-width 8
   evil-move-beyond-eol nil
   helm-echo-input-in-header-line nil)

  ;; Spaceline
  (setq powerline-default-separator 'arrow
        spaceline-buffer-encoding-abbrev-p nil
        spaceline-version-control-p nil)

  ;; Filenames
  (dolist (e '(("xml" . web-mode)
               ("xinp" . web-mode)
               ("C" . c++-mode)
               ("h" . c++-mode)
               ("service" . conf-mode)
               ("timer" . conf-mode)))
    (push (cons (concat "\\." (car e) "\\'") (cdr e)) auto-mode-alist))
  (dolist (e '(("PKGBUILD" . shell-script-mode)
               ("conky.conf" . lua-mode)))
    (push e auto-mode-alist))
  (with-eval-after-load 'projectile
    (push '("C" "h") projectile-other-file-alist))

  ;; Miscellaneous
  (add-hook 'text-mode-hook 'auto-fill-mode)
  (add-hook 'text-mode-hook 'typo-mode)
  (add-hook 'makefile-mode-hook 'whitespace-mode)
  (add-hook 'prog-mode-hook 'page-break-lines-mode)
  (remove-hook 'prog-mode-hook 'spacemacs//show-trailing-whitespace)

  ;; Evil MC
  (add-hook 'prog-mode-hook 'turn-on-evil-mc-mode)
  (add-hook 'text-mode-hook 'turn-on-evil-mc-mode)
  (add-hook 'evil-mc-after-cursors-deleted
            (defun bb/clear-anzu () (interactive) (setq anzu--state nil)))

  ;; Semantic
  (with-eval-after-load 'semantic
    (setq semantic-default-submodes
          (remove 'global-semantic-stickyfunc-mode semantic-default-submodes)))

  ;; Diminish
  (spacemacs|diminish hybrid-mode)
  (spacemacs|diminish which-key-mode)
  (spacemacs|diminish evil-mc-mode)
  (with-eval-after-load 'emoji-cheat-sheet-plus
    (diminish 'emoji-cheat-sheet-plus-display-mode))
  (with-eval-after-load 'racer
    (diminish 'racer-mode))
  (with-eval-after-load 'command-log-mode
    (diminish 'command-log-mode))

  ;; Disable smartparens highlighting
  (with-eval-after-load 'smartparens
    (show-smartparens-global-mode -1))

  ;; Thanks StreakyCobra
  (evil-set-initial-state 'term-mode 'emacs)
  (push 'term-mode evil-escape-excluded-major-modes)
  (evil-define-key 'emacs term-raw-map (kbd "C-c") 'term-send-raw)

  (add-hook 'inferior-emacs-lisp-mode-hook 'smartparens-mode)

  ;; Evilification
  (with-eval-after-load 'haskell-interactive-mode
    (evilified-state-evilify-map haskell-error-mode-map
      :mode haskell-error-mode))
  (with-eval-after-load 'proced
    (evilified-state-evilify-map proced-mode-map
      :mode proced-mode))

  ;; Experimenting with transparency
  (let ((tp (cons dotspacemacs-active-transparency dotspacemacs-inactive-transparency)))
    (push `(alpha . ,tp) default-frame-alist)
    (set-frame-parameter (selected-frame) 'alpha tp))

  ;; Safe local variables
  (put 'helm-make-build-dir 'safe-local-variable 'stringp)

  ;; Additional packages
  (add-hook 'cuda-mode-hook (lambda () (run-hooks 'prog-mode-hook)))
  (use-package helm-flycheck
    :defer t
    :init
    (spacemacs/set-leader-keys "ee" 'helm-flycheck))
  (use-package nginx-mode
    :defer t
    :mode ("nginx\\.conf\\'" "/etc/nginx/.*\\'"))
  (use-package nameless
    :defer t
    :init
    (progn
      (add-hook 'emacs-lisp-mode-hook 'nameless-mode-from-hook)
      (spacemacs|add-toggle nameless
        :status nameless-mode
        :on (nameless-mode)
        :off (nameless-mode -1)
        :evil-leader-for-mode (emacs-lisp-mode . "o:"))))
  (use-package warnings
    :defer t
    :config
    (push '(undo discard-info) warning-suppress-types))
  (use-package editorconfig
    :config (editorconfig-mode 1))
  (use-package kivy-mode
    :defer t
    :init
    (push '(kivy-mode . kivy-indent-offset) spacemacs--indent-variable-alist))
  (use-package defproject
    :commands defproject))

(defun dotspacemacs/user-config/eivindf-sintef ()
  (defproject IFEM-PoroElasticity
    :path "~/work/IFEM/Apps/PoroElasticity"
    :nil
    ((helm-make-build-dir . "bld-sd"))))

(defun bb/remove-in-place (var pred)
  (set var (remove-if pred (symbol-value var))))

(defun bb/remove-elts-or-cars (var elts)
  (declare (indent 1))
  (bb/remove-in-place var (lambda (e)
                            (or (memq e elts)
                                (and (listp e) (memq (car e) elts))))))

(defmacro bb|wrap-func (func)
  (let ((advice-name (intern (format "%s--advice" func)))
        (target-name (intern (format "%s/%s" func system-name))))
    `(progn
       (defun ,advice-name (&rest args)
         (when (fboundp ',target-name)
           (apply ',target-name args)))
       (advice-add ',func :after ',advice-name))))

(bb|wrap-func dotspacemacs/layers)
(bb|wrap-func dotspacemacs/init)
(bb|wrap-func dotspacemacs/user-init)
(bb|wrap-func dotspacemacs/user-config)

(when (file-exists-p "~/local.el")
  (load "~/local.el"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (uuidgen typit mmt thrift rake org-download livid-mode skewer-mode live-py-mode link-hint helm-hoogle flyspell-correct eyebrowse evil-visual-mark-mode evil-ediff eshell-z company-shell column-enforce-mode clojure-snippets volatile-highlights ensime sbt-mode scala-mode2 yaml-mode xterm-color ws-butler wolfram-mode window-numbering which-key web-mode web-beautify vimrc-mode use-package typo toml-mode toc-org tagedit stickyfunc-enhance stan-mode srefactor spotify spacemacs-theme smooth-scrolling smeargle slim-mode shm shell-pop scss-mode scad-mode sass-mode rvm ruby-tools ruby-test-mode ruby-end rubocop rspec-mode robe restart-emacs rbenv ranger rainbow-delimiters racer quelpa qml-mode pyvenv pytest pyenv-mode py-yapf pony-mode pip-requirements persp-mode paradox page-break-lines pacmacs orgit org-repo-todo org-present org-pomodoro org-plus-contrib org-bullets open-junk-file omnisharp nginx-mode neotree nameless multi-term move-text monokai-theme mmm-mode matlab-mode markdown-toc magit-gitflow magit-gh-pulls macrostep lua-mode lorem-ipsum linum-relative leuven-theme less-css-mode kivy-mode json-mode js2-refactor js-doc jade-mode info+ indent-guide ido-vertical-mode ibuffer-projectile hy-mode hungry-delete htmlize hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-spotify helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flyspell helm-flycheck helm-flx helm-descbinds helm-dash helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gnuplot github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gist gh-md flycheck-rust flycheck-pos-tip flycheck-haskell flx-ido fish-mode fill-column-indicator fasd fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-args evil-anzu ess-smart-equals ess-R-object-popup ess-R-data-view eshell-prompt-extras esh-help erc-yt erc-view-log erc-terminal-notifier erc-social-graph erc-image erc-hl-nicks emoji-cheat-sheet-plus emmet-mode elisp-slime-nav elfeed-web elfeed-goodies ein editorconfig disaster diff-hl defproject define-word dash-at-point dactyl-mode cython-mode cuda-mode company-web company-tern company-statistics company-racer company-quickhelp company-ghc company-emoji company-cabal company-c-headers company-auctex company-anaconda command-log-mode coffee-mode cmm-mode cmake-mode clean-aindent-mode clang-format cider-eval-sexp-fu cider chruby bundler buffer-move bracketed-paste auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile arduino-mode alchemist aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-annotation ((t (:foreground "#ff9eb8"))))
 '(company-tooltip-annotation-selection ((t (:background "#66d9ef"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(erc-timestamp-face ((t (:inherit font-lock-comment-face :foreground nil))))
 '(evil-search-highlight-persist-highlight-face ((t (:background "#fc5fef" :foreground "#000000"))))
 '(flycheck-fringe-error ((t (:background nil))))
 '(flycheck-fringe-info ((t (:background nil))))
 '(flycheck-fringe-warning ((t (:background nil))))
 '(font-latex-sectioning-0-face ((t (:inherit default :height 1.0 :weight bold))))
 '(font-latex-sectioning-1-face ((t (:inherit default :height 1.0 :weight bold))))
 '(font-latex-sectioning-2-face ((t (:inherit default :height 1.0 :weight bold))))
 '(font-latex-sectioning-3-face ((t (:inherit default :height 1.0 :weight bold))))
 '(font-latex-sectioning-4-face ((t (:inherit default :height 1.0 :weight bold))))
 '(font-latex-sectioning-5-face ((t (:inherit default :height 1.0 :weight bold))))
 '(font-latex-slide-title-face ((t (:inherit default :height 1.0 :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "#ff9eb8" :weight semi-bold))))
 '(font-lock-comment-face ((t (:slant italic))))
 '(font-lock-doc-face ((t (:slant italic))))
 '(font-lock-keyword-face ((t (:weight bold))))
 '(font-lock-string-face ((t (:slant italic))))
 '(font-lock-warning-face ((t (:underline nil))))
 '(header-line ((t (:box (:color "#555555" :line-width 1)))))
 '(helm-ff-prefix ((t (:background nil :foreground "#666666" :weight bold))))
 '(helm-prefarg ((t (:foreground "PaleGreen"))))
 '(info-title-1 ((t (:inherit default :height 1.0 :weight bold))))
 '(info-title-2 ((t (:inherit default :height 1.0 :weight bold))))
 '(info-title-3 ((t (:inherit default :height 1.0 :weight bold))))
 '(info-title-4 ((t (:inherit default :height 1.0 :weight bold))))
 '(markdown-header-face ((t (:inherit default :height 1.0 :weight bold))))
 '(markdown-header-face-1 ((t (:inherit default :height 1.0 :weight bold))))
 '(markdown-header-face-2 ((t (:inherit default :height 1.0 :weight bold))))
 '(markdown-header-face-3 ((t (:inherit default :height 1.0 :weight bold))))
 '(markdown-header-face-4 ((t (:inherit default :height 1.0 :weight bold))))
 '(markdown-header-face-5 ((t (:inherit default :height 1.0 :weight bold))))
 '(markdown-header-face-6 ((t (:inherit default :height 1.0 :weight bold))))
 '(mode-line ((t (:box (:color "#999999" :line-width 1 :style released-button)))))
 '(mode-line-inactive ((t (:box (:color "#666666" :line-width 1 :style released-button)))))
 '(org-document-title ((t (:inherit default :height 1.0 :weight bold))))
 '(org-done ((t (:foreground "MediumSpringGreen"))))
 '(org-level-1 ((t (:inherit default :height 1.0 :weight bold))))
 '(org-level-2 ((t (:inherit default :height 1.0 :weight bold))))
 '(org-level-3 ((t (:inherit default :height 1.0 :weight bold))))
 '(org-level-4 ((t (:inherit default :height 1.0 :weight bold))))
 '(org-level-5 ((t (:inherit default :height 1.0 :weight bold))))
 '(org-level-6 ((t (:inherit default :height 1.0 :weight bold))))
 '(org-level-7 ((t (:inherit default :height 1.0 :weight bold))))
 '(org-level-8 ((t (:inherit default :height 1.0 :weight bold))))
 '(powerline-active1 ((t (:box (:color "#999999" :line-width 1 :style released-button) :background "#5a5a5a"))))
 '(powerline-active2 ((t (:box (:color "#999999" :line-width 1 :style released-button)))))
 '(powerline-inactive1 ((t (:box (:color "#666666" :line-width 1 :style released-button)))))
 '(powerline-inactive2 ((t (:box (:color "#666666" :line-width 1 :style released-button)))))
 '(region ((t (:background "#998f84"))))
 '(spacemacs-transient-state-title-face ((t (:background nil :foreground nil :inherit font-lock-warning-face))))
 '(term ((t (:foreground nil :background nil))))
 '(web-mode-comment-face ((t (:inherit font-lock-comment-face :foreground nil))))
 '(web-mode-html-attr-name-face ((t (:inherit font-lock-variable-name-face :foreground nil))))
 '(web-mode-html-attr-value-face ((t (:inherit font-lock-string-face :foreground nil))))
 '(web-mode-html-tag-bracket-face ((t (:inherit web-mode-html-tag-face :foreground nil))))
 '(web-mode-html-tag-face ((t (:inherit font-lock-builtin-face :foreground nil :weight bold)))))
