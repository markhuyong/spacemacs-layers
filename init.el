(defun dotspacemacs/layers ()
  (setq-default

   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation nil
   dotspacemacs-ask-for-lazy-installation nil
   dotspacemacs-configuration-layer-path '("~/.spacemacs.d/")
   dotspacemacs-delete-orphan-packages t

   dotspacemacs-configuration-layers
   '((auto-completion
      :variables
      auto-completion-return-key-behavior nil
      auto-completion-tab-key-behavior 'cycle
      auto-completion-private-snippets-directory "~/.spacemacs.d/snippets/"
      :disabled-for org erc)
     ;;bibte
     gtags
     (c-c++ :variables c-c++-enable-clang-support t)
     pdf-tools
     clojure
     command-log
     csharp
     
     ;;dash
     ;;https://github.com/syl20bnr/spacemacs/issues/5694
     (dash :variables dash-helm-dash-docset-path "~/.docsets")
     puppet
     colors
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
     ;; (haskell :variables
     ;;          haskell-process-type 'stack-ghci
     ;;          haskell-enable-ghc-mod-support nil)
     html
     (ibuffer :variables ibuffer-group-buffers-by nil)
     ipython-notebook
     javascript
     latex
     lua
     markdown
     org
     (python :variables python-test-runner 'pytest)
     ;; ranger
     react
     ruby
     ;;rust
     go
     scala
     (scala :variables scala-enable-eldoc-mode t)
     semantic
     (shell :variables shell-default-shell 'eshell)
     shell-scripts
     (spell-checking :variables spell-checking-enable-by-default nil)
     ;;spotify
     (syntax-checking :variables syntax-checking-enable-by-default nil)
     typography
     (version-control :variables version-control-diff-tool 'diff-hl)
     vimscript
     yaml
     evernote
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
     gist
     eww
     volatile-highlights
     vi-tilde-fringe)))

(defun dotspacemacs/layers/SINTEFPC6985 ()
  (bb/remove-elts-or-cars 'dotspacemacs-configuration-layers
    '(fasd spell-checking spotify))
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
     :size 12
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
   dotspacemacs-smooth-scrolling t
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

  (setq create-lockfiles nil)
  (setq configuration-layer--elpa-archives
		'(("melpai-cn" . "http://elpa.zilongshanren.com/melpa/")
		  ("org-cn"   . "http://elpa.zilongshanren.com/org/")
		  ("gnu-cn"   . "http://elpa.zilongshanren.com/gnu/")
		  ;;   ("gnu" . "http://elpa.gnu.org/packages/")
		  ;;   ("org" . "http://orgmode.org/elpa/")
		  ;;   ("melpa" . "http://melpa.org/packages/")
		  ;;   ("melpa-stable" . "http://stable.melpa.org/packages/")
		  ))
  
  ;; https://github.com/syl20bnr/spacemacs/issues/2705
  ;; (setq tramp-mode nil)
  (setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

  ;; ss proxy. But it will cause anacond-mode failed.
  ;;(setq socks-server '("Default server" "127.0.0.1" 1086 5))
  (setq evil-shift-round nil)
  (setq byte-compile-warnings '(not obsolete))

  (set-default 'server-socket-dir "~/.emacs.d/server")
  (require 'server)
  (if (functionp 'window-system)
      (when (and (window-system)
                 (>= emacs-major-version 24))
        (unless (server-running-p) (server-start))))
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

  (setq-default dotspacemacs-configuration-layers
                '(auto-completion
                  (haskell :variables haskell-completion-backend 'intero)))

  ;;docView continuous
  (setq doc-view-continuous t)

  ;;(fset 'evil-visual-update-x-selection 'ignore)

  ;;helm-dash
  ;;(setq helm-dash-common-docsets '("C"))
  ;;(defvar helm-dash-common-docsets '(helm-dash-installed-docsets))
  ;;(setq dash/dash-helm-dash-docset-path '("/Users/apple/.docsets"))
  (setq dash/helm-dash-docset-newpath '("/Users/apple/.docsets"))
  
  (defun c-doc-hook ()
    (interactive)
    (setq-local helm-dash-docsets '("C" "C++" "OpenCV_C" "OpenCV_C++")))
  (add-hook 'c-mode-common-hook 'c-doc-hook)

  (defun emacs-doc-hook ()
    (interactive)
    (setq-local helm-dash-docsets '("Emacs Lisp")))
  (add-hook 'emacs-lisp-mode-hook 'emacs-doc-hook)

  (defun helm-dash-js ()
    (interactive)
    (setq-local helm-dash-docsets '("JavaScript" "BackboneJS" "jQuery")))
  (add-hook 'js2-mode-hook 'helm-dash-js)

  (defun bash-doc-hook ()
    (interactive)
    (setq-local helm-dash-docsets '("Bash")))
  (add-hook 'shell-mode-hook 'bash-doc-hook)

  ;;fixme: doesn't work here?
  ;;(setq browse-url-browser-function 'browse-url-default-macosx-browser)
  ;;(setq helm-dash-browser-func 'browse-url-default-macosx-browser)
  ;;(setq helm-dash-docsets-path "~/.docsets")

  ;;(defun eww-split (url)
  ;; (interactive)
  ;; (select-window (split-window-below))
  ;; (eww url))
  ;;(setq helm-dash-browser-func 'eww-split)
  ;;(setq helm-dash-common-docsets '(helm-dash-installed-docsets)) 
  (setq ns-pop-up-frames nil)

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

   ;;Ensime
   (push '("melpa-stable" . "stable.melpa.org/packages/") configuration-layer--elpa-archives)
   (push '(ensime . "melpa-stable") package-pinned-packages)

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

  ;;helm-dash
  (with-eval-after-load 'dash
    (setq helm-dash-browser-func 'browse-url-default-macosx-browser))

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

  ;;(set-face-attribute 'default nil :height 160)
  
  ;;(toggle-frame-maximized)

  ;;eww
  (setq shr-color-visible-luminance-min 70)
  (add-to-list 'exec-path "/usr/local/bin")
  ;; Additional packages
  (add-hook 'cuda-mode-hook (lambda () (run-hooks 'prog-mode-hook)))

  (use-package smooth-scroll
    :config
    (smooth-scroll-mode 1)
    (setq smooth-scroll/vscroll-step-size 3)
    )

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
 '(package-selected-packages
   (quote
    (evil-unimpaired yapfify yaml-mode xterm-color ws-butler wolfram-mode window-numbering which-key web-mode web-beautify vimrc-mode uuidgen use-package uimage typo typit mmt toc-org thrift tagedit stickyfunc-enhance stan-mode srefactor spacemacs-theme smeargle slim-mode shell-pop scss-mode scad-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restart-emacs rbenv rake rainbow-mode rainbow-identifiers rainbow-delimiters qml-mode pyvenv pytest pyenv-mode py-isort puppet-mode pony-mode pip-requirements persp-mode pdf-tools tablist pcre2el paradox pacmacs orgit org-projectile org-present org-pomodoro alert log4e gntp org-plus-contrib org-page git mustache org-octopress orglue epic org org-mac-link org-download org-bullets open-junk-file omnisharp nginx-mode neotree nameless multi-term move-text mmm-mode matlab-mode markdown-toc markdown-mode magit-gitflow magit-gh-pulls macrostep lua-mode lorem-ipsum livid-mode skewer-mode live-py-mode linum-relative link-hint less-css-mode kivy-mode json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc jade-mode intero info+ indent-guide ido-vertical-mode ibuffer-projectile hydra hy-mode hungry-delete htmlize hlint-refactor hl-todo hl-sexp hindent highlight-parentheses highlight-numbers parent-mode highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make projectile helm-hoogle helm-gtags helm-gitignore helm-flycheck helm-flx helm-descbinds helm-dash helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets haml-mode google-translate golden-ratio go-eldoc gnuplot gitignore-mode github-search github-clone gh marshal logito pcache ht github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md ggtags geeknote flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck-mix flycheck-haskell flycheck flx-ido flx fish-mode fill-column-indicator fasd fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit magit magit-popup git-commit with-editor evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree ess-smart-equals ess-R-object-popup ess-R-data-view ctable ess julia-mode eshell-z eshell-prompt-extras esh-help erc-yt erc-view-log erc-terminal-notifier erc-social-graph erc-image erc-hl-nicks ensime sbt-mode scala-mode emoji-cheat-sheet-plus emmet-mode elisp-slime-nav elfeed-web simple-httpd elfeed-goodies ace-jump-mode noflet powerline popwin elfeed ein request websocket editorconfig dumb-jump disaster diminish diff-hl defproject define-word dash-at-point dactyl-mode cython-mode cuda-mode csharp-mode company-web web-completion-data company-tern dash-functional tern company-statistics company-shell company-go go-mode company-ghci company-ghc ghc haskell-mode company-emoji company-cabal company-c-headers company-auctex company-anaconda column-enforce-mode color-identifiers-mode coffee-mode cmm-mode cmake-mode clojure-snippets clean-aindent-mode clang-format cider-eval-sexp-fu eval-sexp-fu highlight cider seq spinner queue clojure-mode chruby bundler inf-ruby bind-map bind-key auto-yasnippet yasnippet auto-highlight-symbol auto-dictionary auto-compile packed auctex arduino-mode anaconda-mode pythonic f s alchemist company dash elixir-mode pkg-info epl aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup 2048-game quelpa package-build monokai-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages
   (quote
    (sudoku pug-mode ob-elixir minitest insert-shebang hide-comnt helm-purpose window-purpose imenu-list go-guru command-log-mode evil-unimpaired yapfify yaml-mode xterm-color ws-butler wolfram-mode window-numbering which-key web-mode web-beautify vimrc-mode uuidgen use-package uimage typo typit mmt toc-org thrift tagedit stickyfunc-enhance stan-mode srefactor spacemacs-theme smeargle slim-mode shell-pop scss-mode scad-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restart-emacs rbenv rake rainbow-mode rainbow-identifiers rainbow-delimiters qml-mode pyvenv pytest pyenv-mode py-isort puppet-mode pony-mode pip-requirements persp-mode pdf-tools tablist pcre2el paradox pacmacs orgit org-projectile org-present org-pomodoro alert log4e gntp org-plus-contrib org-page git mustache org-octopress orglue epic org org-mac-link org-download org-bullets open-junk-file omnisharp nginx-mode neotree nameless multi-term move-text mmm-mode matlab-mode markdown-toc markdown-mode magit-gitflow magit-gh-pulls macrostep lua-mode lorem-ipsum livid-mode skewer-mode live-py-mode linum-relative link-hint less-css-mode kivy-mode json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc jade-mode intero info+ indent-guide ido-vertical-mode ibuffer-projectile hydra hy-mode hungry-delete htmlize hlint-refactor hl-todo hl-sexp hindent highlight-parentheses highlight-numbers parent-mode highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make projectile helm-hoogle helm-gtags helm-gitignore helm-flycheck helm-flx helm-descbinds helm-dash helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets haml-mode google-translate golden-ratio go-eldoc gnuplot gitignore-mode github-search github-clone gh marshal logito pcache ht github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md ggtags geeknote flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck-mix flycheck-haskell flycheck flx-ido flx fish-mode fill-column-indicator fasd fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit magit magit-popup git-commit with-editor evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree ess-smart-equals ess-R-object-popup ess-R-data-view ctable ess julia-mode eshell-z eshell-prompt-extras esh-help erc-yt erc-view-log erc-terminal-notifier erc-social-graph erc-image erc-hl-nicks ensime sbt-mode scala-mode emoji-cheat-sheet-plus emmet-mode elisp-slime-nav elfeed-web simple-httpd elfeed-goodies ace-jump-mode noflet powerline popwin elfeed ein request websocket editorconfig dumb-jump disaster diminish diff-hl defproject define-word dash-at-point dactyl-mode cython-mode cuda-mode csharp-mode company-web web-completion-data company-tern dash-functional tern company-statistics company-shell company-go go-mode company-ghci company-ghc ghc haskell-mode company-emoji company-cabal company-c-headers company-auctex company-anaconda column-enforce-mode color-identifiers-mode coffee-mode cmm-mode cmake-mode clojure-snippets clean-aindent-mode clang-format cider-eval-sexp-fu eval-sexp-fu highlight cider seq spinner queue clojure-mode chruby bundler inf-ruby bind-map bind-key auto-yasnippet yasnippet auto-highlight-symbol auto-dictionary auto-compile packed auctex arduino-mode anaconda-mode pythonic f s alchemist company dash elixir-mode pkg-info epl aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup 2048-game quelpa package-build monokai-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
