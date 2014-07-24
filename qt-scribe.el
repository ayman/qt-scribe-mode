;;; qt-scribe.el --- AppleScripts for Quicktime  -*- lexical-binding: t; -*-

;; Copyright (C) 2014  David A. Shamma

;; Author: David A. Shamma <>
;; Version: 0.1
;; Keywords: tools, extensions, languages
;; Created: 2014-07-20

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

;; All symbols use prefix qt-.

;; todo: make the timecode clickable to seek the video

;;; Code:

(require 'cl-lib)

(defun qt-pause ()
  (interactive)
  (do-applescript
   (format "tell application \"QuickTime Player\"
	        tell the front document to pause
            end tell")))

(defun qt-play ()
  (interactive)
  (do-applescript
   (format "tell application \"QuickTime Player\"
	        tell the front document to play
            end tell")))

(defun qt-get-filename ()
  (interactive)
  (insert
   (format "[file: '%s']"
           (do-applescript
            (format "tell application \"QuickTime Player\"
	               the name of the front window
                     end tell"))))

(defun qt-get-time ()
  (interactive)
  (insert
   (format "[%s]"
           (do-applescript
            (format 
             "tell application \"QuickTime Player\"
 	          the current time of the front document as string
              end tell")))))

(provide 'qt-scribe)

;;; qt-scribe.el ends here
