;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Nolan Freeman Abbott"
      user-mail-address "nolan@freemanabbott.com")

(setq doom-theme 'doom-one)

(setq org-directory "~/Documents/new/Notes/")

(setq display-line-numbers-type 'relative)

(setq js-jsx-indent-level 2)
(setq css-indent-offset 2)

;; only master (29.x)
; (set-frame-parameter nil 'alpha-background 80)

(add-to-list 'exec-path "/home/theno/.local/bin")

;;
;; org-roam
;;
(after! org-roam
        :ensure t
        :init
        (setq org-roam-v2-ack t)
        :custom
        (setq org-roam-directory "~/Documents/new/Roam/")
        (setq org-roam-completion-everywhere t)
        (setq org-roam-dailies-directory "./daily/")
        (setq org-roam-graph-filetype "png")
        (setq org-roam-capture-templates
                '(("d" "default" plain
                "#+filetags: %?"
                :if-new (file+head "./%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
                :unnarrowed t))
                )
        ; (setq org-roam-db-autosync-mode t)
        (setq org-roam-node-display-template
                (concat "${title:*} " (propertize "${tags:24}" 'face 'org-tag)))
        :config
        (org-roam-db-autosync-enable)
)


(after! magit
  (use-package forge)
)
;;
;; Mapping Keys
;;
(map! :leader
      (:prefix-map ("n" . "notes")
       (:prefix ("r" . "roam")
         :desc "Toggle List Buffer" "l" #'org-roam-buffer-toggle
         :desc "Find Node" "f" #'org-roam-node-find
         :desc "Insert Node Here" "i" #'org-roam-node-insert
         :desc "Sync Database" "s" #'org-roam-db-sync
         :desc "Update ID Locations" "u" #'org-roam-update-org-id-locations
         :desc "Open Random Node" "*" #'org-roam-node-random
         :desc "Graph" "g" #'org-roam-graph
         (:prefix ("d" . "dailies")
           :desc "Capture Today" "d" #'org-roam-dailies-capture-today
           :desc "Capture Tomorrow" "t" #'org-roam-dailies-capture-tomorrow
           :desc "Capture Yesterday" "y" #'org-roam-dailies-capture-yesterday
           :desc "Capture Date" "x" #'org-roam-dailies-capture-date
           :desc "Go To Today" "D" #'org-roam-dailies-goto-today
           :desc "Go To Tomorrow" "T" #'org-roam-dailies-goto-tomorrow
           :desc "Go To Yesterday" "Y" #'org-roam-dailies-goto-yesterday
           :desc "Go To Next Note" "N" #'org-roam-dailies-goto-next-note
           :desc "Go To Date" "X" #'org-roam-dailies-goto-date
           :desc "Go To Previous Note" "P" #'org-roam-dailies-goto-previous-note
))))
;;
;; org-mode
;;
(after! org

        (setq org-agenda-files '("~/new/Agenda/"))

        ;; -- Supply multiple items from wildcards
        ;; -- doesn't dynamically check for new ones unless doom/sync
        ;; (append '("~/Projects/master.org")
        ;;       (file-expand-wildcards "~/Projects/*/agenda.org")
        ;;       ))

        (add-to-list 'org-modules 'org-habit t)

        (setq org-agenda-custom-commands
        '(("p" "Agenda and all PROG tasks"
                ((agenda "")
                (todo "PROG")))))

        (setq org-todo-keywords '((sequence "TODO(t)"
                                            "IDEA(i)" "NEXT(n)" "PREP(b)" "PROG(p)" "REVIEW(v)"
                                            "TEST(s)" "HOLD(h)" "REFACTOR(r)"
                                            "|" "DONE(d)" "CANC(c)")))

        (setq org-todo-keyword-faces
                '(("TODO" . org-warning)
                  ("IDEA" . "white")
                  ("NEXT" . "green")
                  ("PREP" . "lime green")
                  ("PROG" . "dodger blue")
                  ("REVIEW" . "yellow")
                  ("TEST" . "orange")
                  ("HOLD" . "violet red")
                  ("REFACTOR" . "firebrick")
                  ("CANC" . org-done)
                  ("DONE" . org-done)))

        (setq org-log-done 'time)
)

;;
;; other things
;;

;; open *.h header files in C++ mode by default (not C mode)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(defun browse-url-mpv (url &optional new-window)
    (start-process "mpv" "*mpv*" "mpv" url))

(setq browse-url-browser-function '(("https:\\/\\/www\\.youtube." . browse-url-mpv)
    ("." . browse-url)))
