;;; packages.el --- bb-org Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq bb-org-packages
      '(
        ;; package names go here
        org-mac-link
        ;;fcitx
        ;; realgud
        org-bullets
        org
        uimage
        org-octopress
        hl-sexp
        aggressive-indent
        elfeed
        sws-mode
        helm-dash
        nameless
        org-page
        ))

;; List of packges to exclude.
(setq bb-org-excluded-packages '())

;; For each package, define a function bb-org/init-<package-name>
;;

(defun bb-org/init-org-page ()
  (use-package org-page
    :init
    (progn
      (setq op/repository-directory "~/blog-org")
      (setq op/site-domain "https://bb-org.com/")
      (setq op/personal-disqus-shortname "bb-org")
      ;;(setq op/personal-google-analytics-id "")
      (setq op/theme 'mdo)
      (setq op/site-main-title "M-x bb-org")
      (setq op/site-sub-title "coding")
      (setq op/personal-github-link "https://github.com/markhuyong")

      (defun op/generate-force-hexo-uri (default-uri-template creation-date title)
        "Generate URI like hexo"
        (let ((uri-template (or (op/read-org-option "URI")
                                default-uri-template))
              (filename (f-no-ext (f-filename buffer-file-name)))
              (date-list (split-string (if creation-date
                                           (fix-timestamp-string creation-date)
                                         (format-time-string "%Y-%m-%d"))
                                       "-"))
              (encoded-title (encode-string-to-url title)))
          (format-spec uri-template `((?y . ,(car date-list))
                                      (?m . ,(cadr date-list))
                                      (?d . ,(caddr date-list))
                                      (?t . ,filename)))))


      (setq op/category-config-alist
            '(("blog" ;; this is the default configuration
               :show-meta t
               :show-comment t
               :uri-generator op/generate-force-hexo-uri
               :uri-template "/%y/%m/%d/%t/"
               :sort-by :date     ;; how to sort the posts
               :category-index t) ;; generate category index or not
              ("index"
               :show-meta nil
               :show-comment nil
               :uri-generator op/generate-uri
               :uri-template "/"
               :sort-by :date
               :category-index nil)
              ("about"
               :show-meta nil
               :show-comment nil
               :uri-generator op/generate-uri
               :uri-template "/about/"
               :sort-by :date
               :category-index nil)))
      )
    ))

(defun bb-org/init-nameless ()
  (use-package nameless
    :defer t
    :init (add-hook 'emacs-lisp-mode-hook #'nameless-mode-from-hook)
    ))

(defun bb-org/init-org-mac-link  ()
  (use-package org-mac-link
    :defer t
    :init (add-hook'org-mode-hook (lambda () (require 'org-mac-link)))
    ))

(defun bb-org/init-org-octopress ()
  (use-package org-octopress
    :config
    (progn
      (setq org-octopress-directory-top       "~/blog/source")
      (setq org-octopress-directory-posts     "~/blog/source/_posts")
      (setq org-octopress-directory-org-top   "~/blog/source")
      (setq org-octopress-directory-org-posts "~/blog/source/_posts")
      )

    ;; rewrite in org-octopress.el
    (defun org-octopress--summary-table (contents keymap)
      (let ((param (copy-ctbl:param ctbl:default-rendering-param)))
        (ctbl:create-table-component-region
         :param param
         :width  nil
         :height nil
         :keymap keymap
         :model
         (make-ctbl:model
          :data contents
          :sort-state '(-1 2)
          :column-model
          (list (make-ctbl:cmodel
                 :title "Date"
                 :sorter 'ctbl:sort-string-lessp
                 :min-width 10
                 :align 'left)
                (make-ctbl:cmodel
                 :title "Category"
                 :align 'left
                 :sorter 'ctbl:sort-string-lessp)
                (make-ctbl:cmodel
                 :title "Title"
                 :align 'left
                 :min-width 40
                 :max-width 140)
                )))))
    (define-key org-octopress-summary-mode-map "w" 'bb-org/hexo-org-new-open-post)

    (defun org-octopress--scan-post ()
      (mapcar
       (lambda (filename)
         (org-jekyll-property
          '(:date
            :jekyll-categories
            :title
            :input-file)
          filename))
       (directory-files
        (expand-file-name
         org-octopress-directory-org-posts) t "^.*\\.org$")))

    (defun org-octopress (&optional title)
      "Org-mode and Octopress."
      (interactive)
      (setq org-octopress-summary-buffer (get-buffer-create "Octopress"))
      (switch-to-buffer org-octopress-summary-buffer)
      (setq buffer-read-only nil)
      (erase-buffer)
      (insert (org-octopress--summary-header title))
      (save-excursion
        (setq org-octopress-component (org-octopress--summary-table
                                       (org-octopress--scan-post) org-octopress-summary-mode-map)))
      (ctbl:cp-add-click-hook
       org-octopress-component
       (lambda ()
         (find-file (nth 3 (ctbl:cp-get-selected-data-row org-octopress-component)))))
      (org-octopress-summary-mode)
      (ctbl:navi-goto-cell
       (ctbl:find-first-cell (ctbl:component-dest org-octopress-component)))
      )

    ;; rewrite in ox-jekyll.el
    (defcustom org-jekyll-date ""
      "Default date used in Jekyll article."
      :group 'org-export-jekyll
      :type 'string)
    (org-export-define-derived-backend'jekyll 'html
                                              :export-block '("HTML" "JEKYLL")
                                              :menu-entry
                                              '(?j "Jekyll: export to HTML with YAML front matter."
                                                   ((?H "As HTML buffer" org-jekyll-export-as-html)
                                                    (?h "As HTML file" org-jekyll-export-to-html)))
                                              :translate-alist
                                              '((template . org-jekyll-template) ;; add YAML front matter.
                                                (src-block . org-jekyll-src-block)
                                                (inner-template . org-jekyll-inner-template)) ;; force body-only
                                              :options-alist
                                              '((:jekyll-layout "LAYOUT" nil org-jekyll-layout)
                                                (:jekyll-categories "CATEGORIES" nil org-jekyll-categories)
                                                (:jekyll-tags "TAGS" nil org-jekyll-tags)
                                                (:date "DATE" nil org-jekyll-date)
                                                (:jekyll-published "PUBLISHED" nil org-jekyll-published)
                                                (:jekyll-comments "COMMENTS" nil org-jekyll-comments)))
    ))

(defun bb-org/init-uimage ()
  (use-package uimage
    :defer t
    ))

(defun bb-org/init-realgud ()
  (use-package realgud
    :defer t
    :init (load-library "realgud")
    ))

(defun bb-org/init-erc-colorize ()
  (use-package colorize
    :defer t
    :init (add-hook 'erc-mode-hook 'erc-colorize-mode)
    ))
(defun bb-org/init-hl-sexp ()
  (use-package hl-sexp
    :defer t
    :init
    (progn
      (add-hook 'lisp-mode-hook 'hl-sexp-mode)
      (add-hook 'emacs-lisp-mode-hook 'hl-sexp-mode)
      )))

(defun bb-org/post-init-aggressive-indent ()
  (progn
    (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
    (add-hook 'css-mode-hook #'aggressive-indent-mode)
    ))

(defun bb-org/init-fcitx  ()
  (use-package fcitx
    :defer t
    :init
    (fcitx-aggressive-setup)
    ))


(defun bb-org/post-init-org-bullets ()
  (setq org-bullets-bullet-list '("☰" "☷" "⋗" "⇀")))

(defun bb-org/post-init-org ()
  (setq org-agenda-dir "~/Dropbox/org")
  (setq org-agenda-file-gtd (expand-file-name "gtd.org" org-agenda-dir))
  (setq org-agenda-file-note (expand-file-name "note.org" org-agenda-dir))
  (setq org-agenda-file-journal (expand-file-name "journal.org" org-agenda-dir))
  (setq org-agenda-file-snippets (expand-file-name "snippets.org" org-agenda-dir))
  (setq org-agenda-file-gtd-archive (expand-file-name "gtd_archive.org" org-agenda-dir))
  (setq org-agenda-files `(,org-agenda-file-gtd ,org-agenda-file-gtd-archive ,org-agenda-file-note))

  (setq org-default-notes-file org-agenda-file-gtd)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "DOING(i)" "|" "WAITTING(w)" "DONE(d)")
          (sequence "|" "CANCELLED(c)" "DEFERRED(f)")))

  (setq org-tag-alist `(
                        ("WORK"     . ?w)
                        ("MEETING"  . ?m)
                        ("COMPUTER" . ?c)
                        ("READING"  . ?r)
                        ("WRITING"  . ?t)
                        ("BLOG"     . ?b)
                        ("PROJECT"  . ?p)
                        ("HOME"     . ?h)
                        ("ERRAND"   . ?e)))

  (setq org-refile-targets
        '(("gtd.org" :maxlevel . 1)))

  (setq org-log-into-drawer t)
  ;; the %i would copy the selected text into the template
  ;;http://www.howardism.org/Technical/Emacs/journaling-org.html
  ;;add multi-file journal
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-agenda-file-gtd "Tasks")
           "* TODO [#B] %?\n  %i\n"
           :empty-lines 1)
          ("i" "Inbox" entry (file+headline org-agenda-file-gtd "Inbox")
           "* DOING %?\n  %i\n"
           :empty-lines 1)
          ("n" "Notes" entry (file+headline org-agenda-file-note "Notes")
           "* %?\n  %i\n %U"
           :empty-lines 1)
          ("b" "Blog" entry (file+headline org-agenda-file-note "Blog")
           "* TODO [#B] %?\n  %i\n %U"
           :empty-lines 1)
          ("s" "Code Snippet" entry
           (file org-agenda-file-snippets)
           "* %?\t%^g\n#+BEGIN_SRC %^{language}\n\n#+END_SRC")
          ("p" "Projects" entry (file+headline org-agenda-file-gtd "Projects")
           "* TODO [#A] %?\n  %i\n %U"
           :empty-lines 1)
          ("c" "Chrome" entry (file+headline org-agenda-file-note "Notes")
           "* TODO [#C] %?\n %(org-mac-chrome-get-frontmost-url)\n %i\n %U"
           :empty-lines 1)
          ("l" "links" entry (file+headline org-agenda-file-note "Notes")
           "* TODO [#C] %?\n  %i\n %a \n %U"
           :empty-lines 1)
          ("j" "Journal Entry"
           entry (file+datetree org-agenda-file-journal)
           "* %?"
           :empty-lines 1)))

  ;;http://orgmode.org/worg/org-tutorials/org-custom-agenda-commands.html
  (setq org-agenda-custom-commands
        '(
          ("i" "Inbox" todo "INBOX")
          ("p" . "Priorities")
          ("pa" "Urgent" tags-todo "+PRIORITY=\"A\"")
          ("pb" "Important" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
          ("pc" "Normal" tags-todo "+PRIORITY=\"C\"")
          ("b" "Blog" tags-todo "BLOG")
          ("j" . "Project")
          ("jw" tags-todo "PROJECT+WORK+CATEGORY=\"programming\"")
          ("jl" tags-todo "PROJECT+DREAM+CATEGORY=\"winston\"")
          
          ("W" "Weekly Review"
           ((stuck "")            ;; review stuck projects as designated by org-stuck-projects
            (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
            ))

          ;;see deadlines due within the next 60 days
          ("d" "Upcoming deadlines" agenda ""
           ((org-agenda-entry-types '(:deadline))
            ;; a slower way to do the same thing
            ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'notdeadline))
            (org-agenda-ndays 1)
            (org-deadline-warning-days 60)
            (org-agenda-time-grid nil)))

          ("P" "Printed agenda"
           ((agenda "" ((org-agenda-ndays 7)                      ;; overview of appointments
                        (org-agenda-start-on-weekday nil)         ;; calendar begins today
                        (org-agenda-repeating-timestamp-show-all t)
                        (org-agenda-entry-types '(:timestamp :sexp))))
            (agenda "" ((org-agenda-ndays 1)                      ;; daily agenda
                        (org-deadline-warning-days 7)             ;; 7 day advanced warning for deadlines
                        (org-agenda-todo-keyword-format "[ ]")
                        (org-agenda-scheduled-leaders '("" ""))
                        (org-agenda-prefix-format "%t%s")))
            (todo "TODO"                                          ;; todos sorted by context
                  ((org-agenda-prefix-format "[ ] %T: ")
                   (org-agenda-sorting-strategy '(tag-up priority-down))
                   (org-agenda-todo-keyword-format "")
                   (org-agenda-overriding-header "\nTasks by Context\n------------------\n"))))
           ((org-agenda-with-colors nil)
            (org-agenda-compact-blocks t)
            (org-agenda-remove-tags t)
            (ps-number-of-columns 2)
            (ps-landscape-mode t))
           ("~/agenda.ps"))
          ))

  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)  ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

  (add-hook'org-after-todo-statistics-hook 'org-summary-todo)
  ;; used by org-clock-sum-today-by-tags
  (defun filter-by-tags ()
    (let ((head-tags (org-get-tags-at)))
      (member current-tag head-tags)))

  (defun org-clock-sum-today-by-tags (timerange &optional tstart tend noinsert)
    (interactive "P")
    (let* ((timerange-numeric-value (prefix-numeric-value timerange))
           (files (org-add-archive-files (org-agenda-files)))
           (include-tags'("WORK" "COMPUTER" "READING" "WRITING" "MEETING" "BLOG" "HOME"
                          "ERRAND" "PROJECT"))
           (tags-time-alist (mapcar (lambda (tag) `(,tag . 0)) include-tags))
           (output-string "")
           (tstart (or tstart
                       (and timerange (equal timerange-numeric-value 4) (- (org-time-today) 86400))
                       (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "Start Date/Time:"))
                       (org-time-today)))
           (tend (or tend
                     (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "End Date/Time:"))
                     (+ tstart 86400)))
           h m file item prompt donesomething)
      (while (setq file (pop files))
        (setq org-agenda-buffer (if (file-exists-p file)
                                    (org-get-agenda-file-buffer file)
                                  (error "No such file %s" file)))
        (with-current-buffer org-agenda-buffer
          (dolist (current-tag include-tags)
            (org-clock-sum tstart tend'filter-by-tags)
            (setcdr (assoc current-tag tags-time-alist)
                    (+ org-clock-file-total-minutes (cdr (assoc current-tag tags-time-alist)))))))
      (while (setq item (pop tags-time-alist))
        (unless (equal (cdr item) 0)
          (setq donesomething t)
          (setq h (/ (cdr item) 60)
                m (- (cdr item) (* 60 h)))
          (setq output-string (concat output-string (format "[-%s-] %.2d:%.2d\n" (car item) h m)))))
      (unless donesomething
        (setq output-string (concat output-string "[-Nothing-] Done nothing!!!\n")))
      (unless noinsert
        (insert output-string))
      output-string))

  ;; Resume clocking task when emacs is restarted
  (org-clock-persistence-insinuate)
  ;; Save the running clock and all clock history when exiting Emacs, load it on startup
  (setq org-clock-persist t)
  ;; Do not prompt to resume an active clock
  (setq org-clock-persist-query-resume nil)

  ;; Sync with google calander
  (setq org-caldav-url "https://www.google.com/calendar/dav")
  (setq org-caldav-calendar-id "markhuyong@gmail.com")
  (setq org-caldav-files org-agenda-files)
  (setq org-icalendar-date-time-format ";TZID=%Z:%Y%m%dT%H%M%S")

  )

(defun bb-org/post-init-elfeed ()
  (setq-default elfeed-search-filter "@1-week +unread")
  )

(defun bb-org/post-init-helm-dash ()
  (setq helm-dash-browser-func 'eww)
  )

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
