;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;

(add-to-list 'initial-frame-alist '(fullscreen . maximized))


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Daniel Marques"
      user-mail-address "daniel.dmds1@gmail.com"
      org-directory "~/org/"
      doom-themes-treemacs-theme     "all-the-icons"
      doom-localleader-key ",")

(use-package! treemacs-all-the-icons
  :after treemacs)

(use-package! org-pomodoro
  :ensure t
  :commands (org-pomodoro)
  :config
  (setq
   org-pomodoro-length 45
   org-pomodoro-short-break-length 15
   org-pomodoro-long-break-length 30
   org-pomodoro-long-break-frequency 4))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; (use-package! lsp-treemacs
;;   :config
;;   (setq lsp-treemacs-error-list-current-project-only t))

(use-package! clojure-mode
  :config
  (setq clojure-indent-style 'align-arguments))

(use-package! cider
  :after clojure-mode
  :config
  (setq cider-show-error-buffer                 t   ;; to keep errors only at the REPL
        cider-font-lock-dynamically             nil
        cider-eldoc-display-for-symbol-at-point nil
        cider-prompt-for-symbol                 nil
        cider-use-xref                          nil)
  (set-lookup-handlers! '(cider-mode cider-repl-mode) nil)
  (add-hook 'cider-mode-hook (lambda () (remove-hook 'completion-at-point-functions #'cider-complete-at-point))))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Jetbrains Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-monokai-pro)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; make commands go to the second register
(set-register ?1 (cons 'evil-paste-after-marker ?y))
(set-register ?1 (cons 'evil-delete-marker ?d))
(set-register ?1 (cons 'evil-change-marker ?c))



;; Open Treemacs with leader 0
(map! :leader
      :desc "Toggle Treemacs"
      "0" #'treemacs)

(map! :leader
      :desc "Select Treemacs Window"
      "o p" #'treemacs-select-window)


;; Bind centaur-tabs-forward to Ctrl + Tab
(map! :n "C-<tab>" #'centaur-tabs-forward)

;; Bind centaur-tabs-backward to Ctrl + Shift + Tab
(map! :n "C-S-<tab>" #'centaur-tabs-backward)

(map! :n "C-S-v" #'yank-from-kill-ring)
