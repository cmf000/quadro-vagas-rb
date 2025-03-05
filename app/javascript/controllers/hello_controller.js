import { Controller } from "@hotwired/stimulus"

	export default class extends Controller {
  		connect() {
    			setTimeout(() => {
      				this.element.textContent = "Hello World!"
    			}, 1000)
  		}
	}
