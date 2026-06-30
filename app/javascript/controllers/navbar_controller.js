import { Controller } from "@hotwired/stimulus"

// Toggles a "scrolled" class on the public navbar once the page is scrolled past a
// threshold, so CSS can transition it from the warm default to a white + shadow
// state. Defaults to 50px; configurable via data-navbar-threshold-value.
export default class extends Controller {
  static classes = ["scrolled"]
  static values = { threshold: { type: Number, default: 50 } }

  connect() {
    this.update = this.update.bind(this)
    window.addEventListener("scroll", this.update, { passive: true })
    this.update()
  }

  disconnect() {
    window.removeEventListener("scroll", this.update)
  }

  update() {
    this.element.classList.toggle(this.scrolledClass, window.scrollY > this.thresholdValue)
  }
}
