;;; helm-safari.el --- Helm interface for Safari bookmarks  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Chunyang Xu

;; Author: Chunyang Xu <xuchunyang56@gmail.com>
;; Package-Requires: ((helm "1.9.1") (emacs "24"))
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'helm)
(require 'helm-utils)

(defgroup helm-safari nil
  "Helm interface for Safari Bookmarks."
  :group 'helm)

(defcustom helm-safari-bookmarks-file
  "~/Downloads/Safari Bookmarks.html"
  "The bookmark file for Safari."
  :group 'helm-safari
  :type 'file)

(defvar helm-safari-bookmarks-alist nil)
(defvar helm-source-safari-bookmarks
  (helm-build-sync-source "Safari Bookmarks"
    :init (lambda ()
            (setq helm-safari-bookmarks-alist
                  (helm-html-bookmarks-to-alist
                   helm-safari-bookmarks-file
                   "\\(https\\|http\\|ftp\\|about\\|file\\)://[^ \"]*"
                   ">\\([^><]+.\\)</[aA]>")))
    :candidates 'helm-safari-bookmarks-alist
    :action '(("Browse Url" . browse-url))))

;;;###autoload
(defun helm-safari-bookmarks ()
  "Search Safari Bookmark using `helm'."
  (interactive)
  (helm :sources 'helm-source-safari-bookmarks
        :prompt "Find Bookmark: "
        :buffer "*Helm Safari Bookmarks*"))

(provide 'helm-safari)
;;; helm-safari.el ends here
