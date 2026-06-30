import { Controller } from "@hotwired/stimulus"

// Drives the shared video modal. Triggers open it via Bootstrap (data-bs-toggle="modal")
// and carry the source in data-video-url; Bootstrap hands the trigger over as
// event.relatedTarget on show.bs.modal. When the trigger has no video yet, a "coming
// soon" placeholder is shown instead of an empty player. Playback resets on close.
export default class extends Controller {
  static targets = ["player", "empty"]

  load(event) {
    const url = event.relatedTarget?.dataset.videoUrl
    this.playerTarget.hidden = !url
    this.emptyTarget.hidden = Boolean(url)
    if (url) {
      this.playerTarget.src = url
      this.playerTarget.play().catch(() => {})
    } else {
      this.playerTarget.removeAttribute("src")
    }
  }

  stop() {
    this.playerTarget.pause()
    this.playerTarget.removeAttribute("src")
    this.playerTarget.load()
  }
}
