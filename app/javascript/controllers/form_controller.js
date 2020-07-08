import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["checkbox", "field", "textCount"]

  connect() {
    this.setTextCountValues();
  }

  toggle() {
    this.fieldTarget.classList.toggle('d-none', !this.checkboxTarget.checked);
  }

  updateTextCount(event) {
    const textCount = event.target.nextElementSibling;
    const initialCount = textCount.dataset.max;

    textCount.textContent = initialCount - event.target.value.length;

    textCount.classList.toggle('form--right__error', textCount.textContent < 0);
  }

  setTextCountValues() {
    this.textCountTargets.forEach(textCount => {
      const inputLength = textCount.previousElementSibling.value.length;

      if (inputLength === 0) {
        textCount.textContent = textCount.dataset.max;
      } else {
        textCount.textContent = textCount.dataset.max - inputLength;
      }
    })
  }
}
