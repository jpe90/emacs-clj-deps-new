# emacs-deps-new

Elisp wrapper around [deps.new](https://github.com/seancorfield/deps-new). Create Clojure projects from templates within Emacs.

# Installation

Ensure [tools.deps](https://github.com/clojure/tools.deps.alpha) and [deps-new](https://github.com/seancorfield/deps-new) are installed on your system.

## Manual

- Run `git clone https://github.com/jpe90/emacs-deps-new.git`
- In emacs, run `package-load-file` and navigate to `clj-deps-new.el`
- Place `(require 'clj-deps-new)` in your init file

# Usage

Run `M-x clj-deps-new` and follow the on-screen prompts to create a project. 
When opts are enabled, the text in parenthesis display a preview of the argument that will be passed to the final command.

# Preview

![emacs-deps-new](screenshot.png)
