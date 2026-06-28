# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "bootstrap" # @5.3.8

# Tiptap (rich-text editor on ProseMirror, MIT-licensed) — loaded only on admin
# content forms. Served from esm.sh, which bundles the ProseMirror dependency tree
# so we don't have to vendor ~40 transitive packages. The public site never loads
# this; it renders the saved HTML (sanitized) server-side.
pin "@tiptap/core", to: "https://esm.sh/@tiptap/core@2.11.3"
pin "@tiptap/starter-kit", to: "https://esm.sh/@tiptap/starter-kit@2.11.3"
pin "@tiptap/extension-link", to: "https://esm.sh/@tiptap/extension-link@2.11.3"
