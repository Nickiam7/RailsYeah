import { Controller } from "@hotwired/stimulus"
import { Editor } from "@tiptap/core"
import StarterKit from "@tiptap/starter-kit"
import Link from "@tiptap/extension-link"

// Enhances a plain <textarea> into a Tiptap rich-text editor on admin content forms.
// The textarea holds the canonical HTML and is what the form submits; the editor
// syncs into it on every change. Without JS (or if esm.sh is unreachable) the
// textarea stays visible and usable — graceful degradation. (#2947)
export default class extends Controller {
  static targets = ["input", "editor", "toolbar"]

  connect() {
    this.inputTarget.classList.add("d-none")

    this.editor = new Editor({
      element: this.editorTarget,
      extensions: [StarterKit, Link.configure({ openOnClick: false })],
      content: this.inputTarget.value,
      onUpdate: ({ editor }) => { this.inputTarget.value = editor.getHTML() },
      onSelectionUpdate: () => this.refreshToolbar(),
      onTransaction: () => this.refreshToolbar()
    })

    this.refreshToolbar()
  }

  disconnect() {
    this.editor?.destroy()
    this.editor = null
  }

  // Toolbar button handler — reads the command (and optional heading level) off the
  // button's data attributes and runs the matching Tiptap command.
  command(event) {
    event.preventDefault()
    const { command, level } = event.currentTarget.dataset
    const chain = this.editor.chain().focus()

    switch (command) {
      case "bold": chain.toggleBold().run(); break
      case "italic": chain.toggleItalic().run(); break
      case "heading": chain.toggleHeading({ level: Number(level) }).run(); break
      case "bulletList": chain.toggleBulletList().run(); break
      case "orderedList": chain.toggleOrderedList().run(); break
      case "blockquote": chain.toggleBlockquote().run(); break
      case "link": this.toggleLink(); break
    }
  }

  toggleLink() {
    if (this.editor.isActive("link")) {
      this.editor.chain().focus().unsetLink().run()
      return
    }

    const url = window.prompt("Link URL")
    if (url) this.editor.chain().focus().setLink({ href: url }).run()
  }

  // Reflect the active marks/nodes on the toolbar buttons (Bootstrap .active).
  refreshToolbar() {
    if (!this.hasToolbarTarget) return

    this.toolbarTarget.querySelectorAll("[data-command]").forEach((button) => {
      const { command, level } = button.dataset
      const args = level ? { level: Number(level) } : undefined
      button.classList.toggle("active", this.editor.isActive(command, args))
    })
  }
}
