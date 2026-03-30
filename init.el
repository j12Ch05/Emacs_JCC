
;; --- 1. LOAD EXTERNAL CONFIGS ---
(add-to-list 'load-path "~/.emacs.d/") ; Ensure Emacs can find your .el files
(load "appearance1.el")

;; --- 2. UI CLEANUP ---
(setq inhibit-startup-message t)
(tool-bar-mode -1) (menu-bar-mode -1) (scroll-bar-mode -1)
(global-hl-line-mode t) (global-display-line-numbers-mode 1)

;; --- 3. AUTO-COMPLETION ---
(electric-pair-mode 1)
(setq sgml-quick-keys 't)

;; --- 4. DEFAULT DIRECTORY ---
(setq default-directory "C:/Users/User/OneDrive/Desktop/Semester 6/")

;; --- 5. THE OPENGL RUN FUNCTION (C++ ONLY) ---
(defun run-code ()
  (interactive)
  (save-buffer)
  (let* ((file (buffer-file-name))
         (ext (file-name-extension file))
         (base (file-name-sans-extension file)))
    (if (string= ext "cpp")
        (compile (concat "g++ \"" file "\" -o \"" base ".exe\" -lfreeglut -lopengl32 -lglu32 && \"" base ".exe\"") t)
      (compile (concat "gcc \"" file "\" -o \"" base ".exe\" -lfreeglut -lopengl32 -lglu32 && \"" base ".exe\"") t)
      
      (message "Manual run-code is only for C++ OpenGL."))))

;; --- 6. KEYBINDINGS ---
(global-set-key (kbd "C-x C-j") 'dired-jump)
(global-set-key (kbd "C-c b") 'browse-url-of-file)
(defalias 'r 'run-code)

;; --- 7. DISABLE MOUSE ---
(global-unset-key [mouse-1]) (global-unset-key [down-mouse-1])
(global-unset-key [mouse-2]) (global-unset-key [mouse-3])
(mouse-wheel-mode -1) (setq make-pointer-invisible t)

;; --- 8. INPUT FIX ---
(setq compilation-scroll-output t)
(with-eval-after-load 'compile
  (define-key compilation-shell-minor-mode-map (kbd "RET") 'comint-send-input))

(setq compilation-exit-message-function
      (lambda (status code msg)
        (if (and (eq status 'exit) (zerop code))
            (progn (delete-window (get-buffer-window "*compilation*")) (message "Success!"))
          (message "Build Failed."))))


;; --- 1. THE SUGGESTION ENGINE (Company) ---
(global-company-mode t)

;; Show suggestions instantly
(setq company-idle-delay 0.0
      company-minimum-prefix-length 1
      company-tooltip-align-annotations t)

;; --- 2. THE VISUAL POPUP (Company-Box) ---
;; This creates the modern look with icons from your screenshot
(with-eval-after-load 'company
  (company-box-mode 1))

;; --- 3. KEYBOARD CONTROLS ---
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<down>") 'company-select-next)
  (define-key company-active-map (kbd "<up>") 'company-select-previous)
  (define-key company-active-map (kbd "RET") 'company-complete-selection))



(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)


;;; -*- lexical-binding: t -*-

(require 'cogent-package)

(use-package pdf-tools
  :defer t
  :commands (pdf-view-mode pdf-tools-install)
  :mode ("\\.p[pd]f\\'" . pdf-view-mode)
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install)
  (define-pdf-cache-function pagelabels)
  :hook (pdf-view-mode-hook . (lambda () (display-line-numbers-mode -1)))
        (pdf-view-mode-hook . pdf-tools-enable-minor-modes))

(use-package org-pdftools
  :hook (org-load-hook . org-pdftools-setup-link))

(provide 'cogent-reading)
