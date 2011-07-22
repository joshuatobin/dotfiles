;;; dns-mode.el --- simple DNS zone file mode for Emacs

;; Copyright (C) 2002 Richard Kettlewell <rjk@greenend.org.uk>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

; $Header: /cvs/rjk/dotfiles/lib/emacs/dns-mode.el,v 1.9 2002/07/29 16:58:38 richard Exp $

(provide 'dns-mode)

(defgroup dns-mode nil
  "Customization of DNS mode"
  )

(defun dns-mode ()
  "Major mode for editing DNS zone files.
Commands:

\\{dns-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'dns-mode)
  (setq mode-name "DNS")
  (use-local-map dns-mode-map)
  (set-syntax-table dns-mode-syntax-table)
  (make-local-variable 'dns-search-term)
  (set (make-local-variable 'font-lock-defaults) 
       '(dns-mode-font-lock-keywords nil nil nil nil))
  (run-hooks 'dns-mode-hook)
  )

(defvar dns-mode-map nil
  "Keymap for DNS mode")

(if dns-mode-map ()
  (setq dns-mode-map (make-sparse-keymap))
  ;(define-key dns-mode-map [<mumble>] '<mumble>)
  )

(defvar dns-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\; "<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\\ "\\" table)
    (modify-syntax-entry ?. "w" table)
    (modify-syntax-entry ?- "w" table)
    (modify-syntax-entry ?@ "w" table)
    table)
  "Syntax table for DNS mode")

(defface dns-mode-suspect-name-face
  '(
    (((class color)
      (background dark))
     (:foreground "pink"))
    (((class color)
      (background light))
     (:foreground "firebrick"))
    (t
     (:bold t))
    )
  "Face used for suspect domains in DNS mode"
  :group 'dns-mode
  )
(defvar dns-mode-suspect-name-face 'dns-mode-suspect-name-face
  "Face used for suspect domains in DNS mode")

(defvar dns-mode-font-lock-keywords
  '(
    ; keywords
    ("\\<IN\\|A\\|SOA\\|NS\\|MX\\|TXT\\|CNAME\\|HINFO\\|NULL\\|PTR\\|WKS\\|MINFO\\|SIG\\|KEY\\|AAAA\\|LOC\\|NXT\\|SRV\\|A6\\|OPT\\|TKEY\\|TSIG\\|HS\\|CH\\|\\$TTL\\|\\$ORIGIN\\|@\\>" . font-lock-keyword-face)
    ; Possibly-bogus domains - if there is a dot in the name but no
    ; trailing dot then it could be a domain that is meant to be
    ; absolute but someone's forgotten the trailing dot.
    ;
    ; We assume TLDs are all-alphabetic (which might be a bad assumption)
    ("\\<\\([a-zA-Z0-9\\-\\.]+\\.[a-zA-Z]+\\)\\s-" 1 dns-mode-suspect-name-face)
    ("\\<\\([a-zA-Z0-9\\-\\.]+\\.[a-zA-Z]+\\)$" 1 dns-mode-suspect-name-face)
    )
  "Font lock keywords for DNS mode")
