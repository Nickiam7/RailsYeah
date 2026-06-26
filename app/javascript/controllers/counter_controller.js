import { Controller } from "@hotwired/stimulus"

// Sample Stimulus controller — proof that Hotwire/Stimulus is wired up (Story #2932).
// connect() runs on page load to confirm the controller is live; increment() handles
// the button click action. Auto-registered as "counter" via eagerLoadControllersFrom.
export default class extends Controller {
  static targets = ["output"]
  static values = { count: { type: Number, default: 0 } }

  connect() {
    this.outputTarget.textContent = "Stimulus connected"
  }

  increment() {
    this.countValue++
    const noun = this.countValue === 1 ? "time" : "times"
    this.outputTarget.textContent = `Clicked ${this.countValue} ${noun}`
  }
}
