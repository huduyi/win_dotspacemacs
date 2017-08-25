;;; packages.el --- huchen-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <curiousbull@DESKTOP-CMVBTF6>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `huchen-org-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `huchen-org/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `huchen-org/pre-init-PACKAGE' and/or
;;   `huchen-org/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst huchen-org-packages
  '(
    org
    org-pomodoro
    )
  )

(defun huchen-org/post-init-org-pomodoro()
  (with-eval-after-load 'org
    (progn
      (setq org-pomodoro-audio-player "mplayer.exe")
      )
    )
  )

(defun huchen-org/post-init-org()
 (with-eval-after-load 'org
   (progn
     (setq org-refile-targets
           '((nil :maxlevel . 4)
             (org-agenda-files :maxlevel . 4)))

     (setq org-agenda-inhibit-startup t) ;; ~50x speedup
     (setq org-agenda-span 'day)
     (setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup
     (setq org-agenda-window-setup 'current-window)
     (setq org-log-done t)

     (setq org-agenda-span 'day)

     (setq org-agenda-files (quote ("~/workflow/main")))

     (setq org-directory "~/workflow/main")

     (setq org-directory "~/workflow/main")

     ;; Agenda Configuration
     (setq org-agenda-custom-commands
           '(
             ("n" todo "NEXT")
             ("w" todo "WAITING")
             ("d" "Agenda + Next Actions" ((agenda) (todo "NEXT")))
             )
           )

     (setq org-agenda-diary-file "~/workflow/main/diary.org")
     ;; Task States Configuration
     (setq org-todo-keywords
           (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                   (sequence "WAITING(w)" "HOLD(h)" "|" "CANCELLED(c)" "PHONE" "MEETING"))))

     ;; Date insertion Configuration
     ;; Allow automatically handing of created/expired meta data.
     ;; Configure it a bit to my liking
     (setq
      ;; Name of property when an item is created
      org-expiry-created-property-name "CREATED"
      ;; Don't show everything in the agenda view
      org-expiry-inactive-timestamps   t
      )

     ;; Automatically add tags when state changes occur
     (setq org-todo-state-tags-triggers
           (quote (("CANCELLED" ("CANCELLED" . t))
                   ("WAITING" ("WAITING" . t))
                   ("HOLD" ("WAITING") ("HOLD" . t))
                   (done ("WAITING") ("HOLD"))
                   ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                   ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                   ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

     ;;Org Mode Capture
     ;; Source: https://www.suenkler.info/docs/emacs-orgmode/
     (setq org-capture-templates
           '(
             ;; Create Todo under GTD.org -> Work -> Tasks
             ;; file+olp specifies to full path to fill the Template
             ("w" "Work TODO" entry (file+olp "~/workflow/main/gtd.org" "Work" "Tasks")
              "* TODO %? \n:PROPERTIES:\n:CREATED: %U\n:END:" :clock-in t :clock-resume t)
             ("t" "todo" entry (file+olp "~/workflow/main/gtd.org" "Miscellaneous" "TODOs")
              "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
             ("r" "respond" entry (file+olp "~/workflow/main/gtd.org" "Miscellaneous" "Response")
              "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
             ;; Create Todo under GTD.org -> Private -> Tasks
             ;; file+olp specifies to full path to fill the Template
             ("p" "Private TODO" entry (file+olp "~/workflow/main/gtd.org" "Personal" "Tasks")
              "* TODO %? \n:PROPERTIES:\n:CREATED: %U\n:END:" :clock-in t :clock-resume t)
             ("h" "Habit" entry (file+olp "~/workflow/main/gtd.org" "Habit")
              "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"
              :clock-in t :clock-resume t)
             ))

     ;; Change task state to NEXT when clocking in
     (setq org-clock-in-switch-to-state "NEXT")

     ;; Separate drawers for clocking and logs
     (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))

     ;; Save clock data and state changes and notes in the LOGBOOK drawer
     (setq org-clock-into-drawer t)
     ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
     (setq org-clock-out-remove-zero-time-clocks t)

     ;; org latex export setting
     (require 'ox-publish)
     ;; Latex setting
     (add-to-list 'org-latex-classes '("ctexart" "\\documentclass[11pt]{ctexart}
                                      [NO-DEFAULT-PACKAGES]
                                      \\usepackage[utf8]{inputenc}
                                      \\usepackage[T1]{fontenc}
                                      \\usepackage{fixltx2e}
                                      \\usepackage{graphicx}
                                      \\usepackage{longtable}
                                      \\usepackage{float}
                                      \\usepackage{wrapfig}
                                      \\usepackage{rotating}
                                      \\usepackage[normalem]{ulem}
                                      \\usepackage{amsmath,bm,mathrsfs}
                                      \\usepackage{textcomp}
                                      \\usepackage{marvosym}
                                      \\usepackage{wasysym}
                                      \\usepackage{amssymb}
                                      \\usepackage{booktabs}
                                      \\usepackage[colorlinks,linkcolor=black,anchorcolor=black,citecolor=black]{hyperref}
                                      \\tolerance=1000
                                      \\usepackage{listings}
                                      \\usepackage{xcolor}
                                      \\lstset{
                                      %行号
                                      numbers=left,
                                      %背景框
                                      framexleftmargin=10mm,
                                      frame=none,
                                      %背景色
                                      %backgroundcolor=\\color[rgb]{1,1,0.76},
                                      backgroundcolor=\\color[RGB]{245,245,244},
                                      %样式
                                      keywordstyle=\\bf\\color{blue},
                                      identifierstyle=\\bf,
                                      numberstyle=\\color[RGB]{0,192,192},
                                      commentstyle=\\it\\color[RGB]{0,96,96},
                                      stringstyle=\\rmfamily\\slshape\\color[RGB]{128,0,0},
                                      %显示空格
                                      showstringspaces=false
                                      }
                                      "
                                       ("\\section{%s}" . "\\section*{%s}")
                                       ("\\subsection{%s}" . "\\subsection*{%s}")
                                       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                       ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

     ;; {{ export org-mode in Chinese into PDF
     ;; @see http://freizl.github.io/posts/tech/2012-04-06-export-orgmode-file-in-Chinese.html
     ;; and you need install texlive-xetex on different platforms
     ;; To install texlive-xetex:
     ;;    `sudo USE="cjk" emerge texlive-xetex` on Gentoo Linux
     ;; }}
     (setq org-latex-default-class "ctexart")
     (setq org-latex-pdf-process
           '(
             "xelatex -interaction nonstopmode -output-directory %o %f"
             "xelatex -interaction nonstopmode -output-directory %o %f"
             "xelatex -interaction nonstopmode -output-directory %o %f"
             "rm -fr %b.out %b.log %b.tex auto"))

      ;;(spacemacs|disable-company org-mode)
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "," 'org-priority)

      ;; (add-to-list 'org-modules "org-habit")
      (add-to-list 'org-modules 'org-habit)
      (require 'org-habit)
     ;; org babel configuration
     (org-babel-do-load-languages
      'org-babel-load-languages
      '((perl . t)
        (ruby . t)
        (sh . t)
        (dot . t)
        (js . t)
        (latex .t)
        (python . t)
        (ipython . t)
        (emacs-lisp . t)
        (plantuml . t)
        (C . t)
        (ditaa . t)))
     ;; execute org babel without confirmation
     (setq org-confirm-babel-evaluate nil)

     (setq org-ditaa-jar-path "~/.spacemacs.d/ditaa.jar")
     (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
     (setq org-plantuml-jar-path
           (expand-file-name "~/.spacemacs.d/plantuml.jar"))

     (setq org-file-apps (quote ((auto-mode . emacs)
                                 ("\\.mm\\'" . system)
                                 ("\\.x?html?\\'" . system)
                                 ("\\.pdf\\'" . system))))

 )))

;;; packages.el ends here
