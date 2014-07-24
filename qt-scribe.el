;;; qt-scribe.el --- AppleScript based transcription for Quicktime  -*- lexical-binding: t; -*-

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

;; All symbols use prefix qt-scribe.

;;; Code:

(require 'cl-lib)

(defun qt-scribe-format-timecode (sec)
  (format "%02d:%02d:%02d.%02d" 
          (/ (floor sec) 3600)
          (/ (% (floor sec) 3600) 60)
          (% (% (floor sec) 3600) 60)
          (floor (* (- sec (floor sec)) 100))
          (- (* sec 100) (* (floor sec) 100))))

(defun qt-scribe-pause ()
  (interactive)
  (do-applescript
   (format "tell application \"QuickTime Player\"
	        tell the front document to pause
            end tell")))

(defun qt-scribe-play ()
  (interactive)
  (do-applescript
   (format "tell application \"QuickTime Player\"
	        tell the front document to play
            end tell")))

(defun qt-scribe-step-backward ()
  (interactive)
  (do-applescript
   (format "tell application "QuickTime Player"
	      front document step backward by 30	
            end tell")))

(defun qt-scribe-step-forward ()
  (interactive)
  (do-applescript
   (format "tell application "QuickTime Player"
	      front document step forward by 30	
            end tell")))

(defun qt-scribe-toggle-playback ()
  (interactive)
  (do-applescript
   (format "tell application \"QuickTime Player\"
              if the front document is playing then
                tell the front document to pause
              else
                tell the front document to play
              end if
            end tell")))

(defun qt-scribe-get-filename ()
  (interactive)
  (insert
   (format 
    "[file: \"%s\"]\n"
    (do-applescript
     (format "tell application \"QuickTime Player\"
                the name of the front window
              end tell")))))

(defun qt-scribe-get-time ()
  (interactive)
  (insert
   (format 
    "[%s] "
    (qt-scribe-format-timecode
     (string-to-number 
      (do-applescript
       (format "tell application \"QuickTime Player\"
  	          the current time of the front document as string
                end tell")))))))

;; command to comment/uncomment text
(defun qt-scribe--comment-dwim (arg)
  "Comment or uncomment current line or region in a smart way.
For detail, see `comment-dwim'."
  (interactive "*P")
  (require 'newcomment)
  (let (
        (comment-start "#") (comment-end "")
        )
    (comment-dwim arg)))


(defconst qt-scribe-types '("file:" "time:"))

(defconst qt-scribe-type-regexp (regexp-opt qt-scribe-types 'words))

(setq qt-scribe-font-lock-keywords
      `(
        (,qt-scribe-type-regexp . font-lock-type-face)
        ;;(,qt-scribe-constant-regexp . font-lock-constant-face)
        ;;(,qt-scribe-event-regexp . font-lock-builtin-face)
        ;;(,qt-scribe-functions-regexp . font-lock-function-name-face)
        ;;(,qt-scribe-keywords-regexp . font-lock-keyword-face)
        ))

(defvar qt-scribe-mode-hook nil)

(defvar qt-scribe-mode-map
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap (kbd "C-c RET") 'qt-scribe-get-time)
    (define-key keymap (kbd "C-c SPC") 'qt-scribe-toggle-playback)
    (define-key keymap (kbd "C-c j") 'qt-scribe-step-backward)
    (define-key keymap (kbd "C-c k") 'qt-scribe-step-forward)
    keymap)
  "Keymap for qt-scribe major mode")

(define-derived-mode qt-scribe-mode fundamental-mode
  "qt-scribe mode"
  "Major mode for transcribing using the Quicktime Player on Mac OS."
  (setq mode-name "qt-scribe")
  (setq font-lock-defaults '((qt-scribe-font-lock-keywords)))
  (define-key qt-scribe-mode-map [remap comment-dwim] 'qt-scribe-comment-dwim))

(provide 'qt-scribe-mode)

;;; qt-scribe.el ends here

