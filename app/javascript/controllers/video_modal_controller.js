import { Controller } from "@hotwired/stimulus"

// "Course Preview" modal: a featured player + a playlist. Opening the modal (via a
// Bootstrap trigger carrying data-video-url) deep-links to the matching row; clicking
// a row swaps the featured player. When there's nothing to play, a placeholder shows.
// Playback resets on close.
export default class extends Controller {
  static targets = ["player", "empty", "item"]
  static classes = ["active"]

  open(event) {
    const url = event.relatedTarget?.dataset.videoUrl
    const item = this.itemTargets.find((el) => el.dataset.videoUrl === url) || this.itemTargets[0]
    item ? this.activate(item) : this.showEmpty()
  }

  select(event) {
    this.activate(event.currentTarget)
  }

  activate(item) {
    this.itemTargets.forEach((el) => el.classList.toggle(this.activeClass, el === item))
    this.emptyTarget.hidden = true
    this.playerTarget.hidden = false
    this.playerTarget.src = item.dataset.videoUrl
    this.playerTarget.play().catch(() => {})
  }

  showEmpty() {
    this.playerTarget.hidden = true
    this.playerTarget.removeAttribute("src")
    this.emptyTarget.hidden = false
  }

  stop() {
    this.playerTarget.pause()
    this.playerTarget.removeAttribute("src")
    this.playerTarget.load()
  }
}
