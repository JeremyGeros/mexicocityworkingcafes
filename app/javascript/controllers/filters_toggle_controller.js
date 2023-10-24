import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
	static targets = ['filters'];

	toggle(event) {
		event.preventDefault();
		this.filtersTarget.classList.toggle('hidden');
		event.currentTarget.classList.toggle('btn-primary');
	}
}
