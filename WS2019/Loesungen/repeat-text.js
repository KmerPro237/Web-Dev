/* global HTMLElement, customElements */
class RepeatText extends HTMLElement {
  constructor() {
    super()
    const count = this.getAttribute('count')
    const text = this.getAttribute('text')
    for (let i = 0; i < count; i++) {
      const p = document.createElement('p')
      p.textContent = text
      this.appendChild(p)
      // oder kurz
      // this.innerHTML += `<p>${text}</p>`
    }
  }
}

customElements.define('repeat-text', RepeatText)
