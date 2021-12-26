;;; clj-deps-new.el --- Create clojure projects from templates  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  jpe90

;; Author: jpe90 <eskinjp@gmail.com>
;; URL: https://github.com/jpe90/emacs-deps-new
;; Version: 1.0
;; Package-Requires: ((emacs "25.1" ) (transient "0.3.7"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This is a small wrapper around the deps.new tool for creating deps.edn
;; Clojure projects from templates.
;; 
;; It requires external utilities 'tools.build' and 'deps.new' to be installed.
;; See https://github.com/seancorfield/deps-new for installation instructions.
;; 
;; Requires transient.el to be loaded.

;;; Code:

(require 'transient)


(defun clj-deps-new--assemble-command (command name opts)
  "Helper function for building the deps.new command string.
COMMAND: name of the deps.new command
NAME: name provided by user for the project being generated
OPTS: opts provided by user"
  (concat "clojure -Tnew " command " " name " " (mapconcat #'append opts " ")))

;; Don't use this macro to extend additional templates
;; It only exists because the built-in commands use identical opts
(defmacro clj-deps-new-def--transients (arglist)
  "Create the prefix and suffix transients for the built-in deps.new commands.
ARGLIST: a plist of values that are substituted into the macro."
  `(progn
     (transient-define-suffix ,(intern (format "execute-%s"  (plist-get arglist :name))) (&optional opts)
       ,(format "Create the %s" (plist-get arglist :name))
       :key "c"
       :description ,(plist-get arglist :description)
       (interactive (list (transient-args transient-current-command)))
       (let* ((name (read-string ,(plist-get arglist :prompt)))
              (display-name (concat ":name " name)))
         (shell-command (clj-deps-new--assemble-command ,(plist-get arglist :name) display-name opts))))
     (transient-define-prefix ,(intern (format "new-%s"  (plist-get arglist :name))) ()
       ,(format "Create a new %s" (plist-get arglist :name))
       ["Opts"
        ("-d" "Alternate project folder name (relative path, no trailing slash)" ":target-dir " :class transient-option)
        ("-o" "Don't overwrite existing projects" ":overwrite false" :class transient-switch)]
       ["Actions"
        (,(intern (format "execute-%s"  (plist-get arglist :name))))])))


(clj-deps-new-def--transients (:name "app" :description "Create an Application" :prompt "Application name: "))
(clj-deps-new-def--transients (:name "lib" :description "Create a Library" :prompt "Library name: "))
(clj-deps-new-def--transients (:name "template" :description "Create a Template" :prompt "Template name: "))
(clj-deps-new-def--transients (:name "scratch" :description "Create a Minimal \"scratch\" Project" :prompt "Scratch name: "))
(clj-deps-new-def--transients (:name "pom" :description "Create a pom.xml file" :prompt "Project name: "))

(transient-define-prefix clj-deps-new ()
  "Generate a project using deps.new."
  ["Select a generation template"
   ("a" "Application" new-app)
   ("l" "Library" new-lib)
   ("t" "Template" new-template)
   ("s" "Scratch" new-scratch)
   ("p" "pom.xml" new-pom)])

(provide 'clj-deps-new)
;;; clj-deps-new.el ends here
