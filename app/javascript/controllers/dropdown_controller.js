import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"];

  toggleMenu() {
    this.menuTarget.classList.toggle("hidden");
  }

  closeMenu(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden");
    }
  }

  connect() {
    window.addEventListener("click", this.closeMenu.bind(this));
  }

  disconnect() {
    window.removeEventListener("click", this.closeMenu.bind(this));
  }
}
