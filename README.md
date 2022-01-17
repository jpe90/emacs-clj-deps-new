# emacs-deps-new

[![MELPA](https://melpa.org/packages/clj-deps-new-badge.svg)](https://melpa.org/#/clj-deps-new)

Elisp wrapper around [deps.new](https://github.com/seancorfield/deps-new). Create Clojure projects from templates within Emacs.

# Installation

Ensure [tools.deps](https://github.com/clojure/tools.deps.alpha) and [deps-new](https://github.com/seancorfield/deps-new) are installed on your system.

## MELPA 

- Run `M-x package-install clj-deps-new`
- If the package wasn't found, run `M-x package-refresh-contents`
- Place `(require 'clj-deps-new)` in your init file

## Manual

- Run `git clone https://github.com/jpe90/emacs-deps-new.git`
- In emacs, run `package-install-file` and navigate to `clj-deps-new.el`
- Place `(require 'clj-deps-new)` in your init file


# Usage

Run `M-x clj-deps-new` and follow the on-screen prompts to create a project. 
When opts are enabled, the text in parenthesis display a preview of the argument that will be passed to the final command.


# Preview

![emacs-deps-new](screenshot.png)


# Adding Additional Templates

You'll want to familiarize yourself with the basics of Transient. The [Developer Quick Start Manual](https://github.com/magit/transient/wiki/Developer-Quick-Start-Guide) and [Transient Manual](https://magit.vc/manual/transient.html#Defining-New-Commands) are good places to get started. In particular, note the section on [modifying existing transients](https://magit.vc/manual/transient.html#Modifying-Existing-Transients). 

When adding new transient prefixes, you'll want to modify symbol `'clj-deps-new`, which refers to the prefix containing built-in deps.new commands. As a quick example, you can add a silly entry to the Prefix list by evaluating the following expression: 
```
(transient-append-suffix 'clj-deps-new "p"
  '("h" "hello" (lambda () (interactive) (message "hello"))))
```

*A full walkthrough of adding a template to the command-line program and to the lisp wrapper is forthcoming.*
