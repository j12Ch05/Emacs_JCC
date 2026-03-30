;; --- PURE BLACK MONOKAI LOOK ---

;; 1. Install necessary UI packages
(defvar appearance-packages
  '(monokai-theme all-the-icons neo-tree doom-modeline dashboard))

(dolist (p appearance-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; 2. Load Theme & Force Absolute Black (#000000)
(load-theme 'monokai t)
(set-face-background 'default "#000000")
(set-face-background 'fringe "#000000")
(set-face-background 'line-number "#000000")
(set-face-foreground 'line-number "#49483e")
(set-face-background 'vertical-border "#000000")
(set-face-foreground 'vertical-border "#272822")

;; 3. Modern Status Bar (Doom Modeline)
(require 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-icon t)

;; 4. VS Code Sidebar (NeoTree)
(require 'neotree)
(setq neo-theme 'icons)
(global-set-key (kbd "M-b") 'neotree-toggle) ; Alt+B to toggle

;; 5. UI Cleanup
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(global-display-line-numbers-mode 1)

;; 6. Startup Dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-items '((recents . 8) (projects . 5)))

(provide 'bearded_monokai_black)
