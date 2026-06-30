import { Controller } from "@hotwired/stimulus"

// Drives the shared video modal. Triggers open it via Bootstrap
// (data-bs-toggle="modal") and carry the source in data-video-url; Bootstrap hands
// the trigger over as event.relatedTarget on show.bs.modal. Playback is reset when
// the modal closes so the next open starts fresh.
export default class extends Controller {
  static targets = ["player"]

  load(event) {
    const url = event.relatedTarget?.dataset.videoUrl
    if (!url) return
    this.playerTarget.src = url
    this.playerTarget.play().catch(() => {})
  }

  stop() {
    this.playerTarget.pause()
    this.playerTarget.removeAttribute("src")
    this.playerTarget.load()
  }
}
