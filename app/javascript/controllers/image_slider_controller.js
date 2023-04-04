import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "arrow"]

  connect() {
    this.index = 0
    this.updateArrows()
  }

  nextSlide() {
    this.index = (this.index + 1) % this.slideTargets.length
    this.showSlide()
  }

  previousSlide() {
    this.index = (this.index - 1 + this.slideTargets.length) % this.slideTargets.length
    this.showSlide()
  }

  showSlide() {
    this.slideTargets.forEach((slide, i) => {
      slide.style.display = i === this.index ? "block" : "none"
    })
    this.updateArrows()
  }

  updateArrows() {
    this.arrowTargets.forEach((arrow) => {
      arrow.href = `#slide${(this.index + (arrow.classList.contains("left-arrow") ? -1 : 1) + this.slideTargets.length) % this.slideTargets.length + 1}`
    })
  }
}
