import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["checkbox", "input"]

  toggle() {
    this.inputTarget.classList.toggle('d-none', !this.checkboxTarget.checked)
  }
}
