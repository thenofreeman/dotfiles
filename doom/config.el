
(setq user-full-name "Nolan Freeman Abbott"
      user-mail-address "nolan@freemanabbott.com")

(setq doom-theme 'doom-one)

(setq org-directory "~/Documents/Org/")

(setq display-line-numbers-type 'relative)

(setq js-jsx-indent-level 2)
(setq css-indent-offset 2)

(add-to-list 'exec-path "/home/theno/.local/bin")
(add-to-list 'exec-path "/home/theno/.ghcup/bin")

;;
;; org-roam
;;
(use-package! org-roam
  :custom
  (org-roam-database-connector 'sqlite3))

(after! org-roam
; THIS DOESNT WORK
;       (defun my/org-roam-title-normalize (title)
;       "Normalize apostrophes in Org-roam titles for better searching."
;       (replace-regexp-in-string "'" "" title))

;       (setq org-roam-db-node-title-correct-function #'my/org-roam-title-normalize)
; END THIS DOESNT WORK

        :ensure t
        :init
        (setq org-roam-v2-ack t)
        :custom
        (setq org-roam-directory "~/Documents/Org/Roam/")
        (setq org-roam-completion-everywhere t)
        (setq org-roam-dailies-directory "~Documents/Org/Daily/")
        (setq org-roam-graph-filetype "png")
        (setq org-roam-capture-templates
        '(("d" "default" plain
                "%?"
                :if-new (file+head "./%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
                :unnarrowed t)))
        ; (setq org-roam-db-autosync-mode t)
        (setq org-roam-node-display-template
                (concat "${title:*} " (propertize "${tags:24}" 'face 'org-tag)))
        :config
        (org-roam-db-autosync-enable)
)

(setq org-babel-timeout 10) ; seconds


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

        (setq org-agenda-files '("~/Documents/Org/Agenda/"))

        ; (add-to-list 'org-modules 'org-habit t)

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

        (setq org-cycle-separator-lines 1)
)

;; (use-package! org-transclusion
  ;; :after org
  ;; :init
  ;; (map!
   ;; :map global-map "<f12>" #'org-transclusion-add
   ;; :leader
   ;; :prefix "n"
   ;; :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

;;
;; other things
;;

;; open *.h header files in C++ mode by default (not C mode)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-include-path
                           (list (expand-file-name "/usr/local/include/c++/11/")))))


(after! company
  ;; Remap accept completion to Ctrl-Y
  (map! :map company-active-map
        "C-y" #'company-complete-selection
        "<return>" nil  ;; Unbind ENTER
        "RET" nil))
