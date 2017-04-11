;;; packages.el --- huchen-misc layer packages file for Spacemacs.
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
;; added to `huchen-misc-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `huchen-misc/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `huchen-misc/pre-init-PACKAGE' and/or
;;   `huchen-misc/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst huchen-misc-packages
  '(
    (plantuml-mode :location elpa)
    )
)

(defun huchen-misc/init-plantuml-mode()
  (use-package plantuml-mode))

(defun huchen-misc/init-plantuml-mode()
  (add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
  (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
  (setq plantuml-jar-path "～/.spacemacs.d/plantuml.jar")
  )
;;; packages.el ends here
