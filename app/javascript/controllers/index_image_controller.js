import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="index-image"
export default class extends Controller {
  static targets = ["slide"]

  initialize() {
    this.index = 0
    this.interval = setInterval(() => {
      this.nextSlide()
    }, 7000)// 7000ミリ秒ごとに画像が切り替わる
  }

  nextSlide() {
    this.slideTargets[this.index].style.display = "none"
    this.index = (this.index + 1) % this.slideTargets.length
    this.slideTargets[this.index].style.display = "block"
  }
}
