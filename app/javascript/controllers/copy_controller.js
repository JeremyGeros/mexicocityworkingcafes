import { Controller } from '@hotwired/stimulus';

function copyToClipboard(text) {
	const elem = document.createElement('textarea');
	elem.value = text;
	document.body.appendChild(elem);
	elem.select();
	document.execCommand('copy');
	document.body.removeChild(elem);
}

export default class extends Controller {
	static get values() {
		return {
			copyText: String,
		};
	}

	copy(event) {
		const target = event.currentTarget;

		copyToClipboard(this.copyTextValue);
		target.innerHTML = 'Copied!';
		setTimeout(() => {
			target.innerHTML = this.copyTextValue;
		}, 5000);
	}
}
