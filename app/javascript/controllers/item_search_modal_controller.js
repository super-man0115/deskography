import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['modal']

  open(event) {
    event.preventDefault()
    console.log("Opening modal")
    console.log(this.modalTarget) 
    this.modalTarget.classList.remove("hidden")
  }

  close(event) {
    event.preventDefault()
    console.log("Closing modal")
    this.modalTarget.classList.add("hidden")
  }
}