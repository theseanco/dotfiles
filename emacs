(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'evil)
(evil-mode 1)

(global-set-key (kbd "M-o i") 'avy-goto-word-0)

(add-to-list 'load-path "~/src/github/co34pt_LiveCode/Tidal/emacs-tidal")
(require 'haskell-mode)
(require 'tidal)
