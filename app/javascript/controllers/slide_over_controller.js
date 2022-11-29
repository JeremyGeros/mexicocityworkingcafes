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
	static get targets() {
		return [
			'overlay',
			'secondaryOverlay',
			'slideOver',
			'name',
			'rating',
			'coffee',
			'plugs',
			'wifi',
			'wifiName',
			'wifiPassword',
			'downloadSpeed',
			'uploadSpeed',
		];
	}

	static get values() {
		return {
			cafeInformation: Object,
		};
	}

	connect() {
		document.querySelectorAll('.cafe-row').forEach((row) => {
			row.addEventListener('click', () => {
				const cafeInformation = row.dataset.cafeInformation;
				const cafeInformationParsed = JSON.parse(cafeInformation);

				console.log('cafeInformationParsed', cafeInformationParsed);
				this.openSlideOver();
				this.setSlideOverInformation(cafeInformationParsed);
			});
		});

		this.overlayTarget.addEventListener('click', () => {
			this.closeSlideOver();
		});

		this.secondaryOverlayTarget.addEventListener('click', (e) => {
			if (e.currentTarget === e.target) {
				this.closeSlideOver();
			}
		});
	}

	openSlideOver() {
		this.element.classList.remove('hidden');
		this.overlayTarget.classList.add(
			'ease-in-out',
			'duration-100',
			'opacity-0'
		);
		setTimeout(() => {
			this.overlayTarget.classList.add('opacity-100');
		}, 10);

		this.slideOverTarget.classList.add(
			'transform',
			'transition',
			'ease-in-out',
			'duration-100',
			'sm:duration-700',
			'translate-x-full'
		);
		setTimeout(() => {
			this.slideOverTarget.classList.add('translate-x-0');
		}, 10);
	}

	closeSlideOver() {
		console.log('closeSlideOver');
		this.overlayTarget.classList.remove('opacity-100');
		this.overlayTarget.classList.add('opacity-0');

		this.slideOverTarget.classList.remove('translate-x-0');
		this.slideOverTarget.classList.add('translate-x-full');

		setTimeout(() => {
			this.element.classList.add('hidden');
		}, 100);
	}

	setSlideOverInformation(cafeInformation) {
		this.cafeInformationValue = cafeInformation;
		this.nameTarget.innerText = cafeInformation.name;
		this.ratingTarget.innerHTML = cafeInformation.rating_html;
		this.coffeeTarget.style.fill = this.getColorForRating(
			cafeInformation.coffee
		);
		this.plugsTarget.style.fill = this.getColorForBool(cafeInformation.plugs);

		this.wifiTarget.style.fill = this.getColorForBool(cafeInformation.wifi);
		this.wifiNameTarget.innerText = cafeInformation.wifi_name;
		this.wifiPasswordTarget.innerText = cafeInformation.wifi_password;

		this.downloadSpeedTarget.innerText = cafeInformation.download_speed;
		this.uploadSpeedTarget.innerText = cafeInformation.upload_speed;
	}

	copy() {
		copyToClipboard(this.cafeInformationValue.wifi_password);
		this.wifiPasswordTarget.innerHTML = 'Copied!';
		setTimeout(() => {
			this.wifiPasswordTarget.innerHTML =
				this.cafeInformationValue.wifi_password;
		}, 5000);
	}

	getColorForRating(rating) {
		switch (rating) {
			case 0:
				return '#BB0F0F';
			case 1:
				return '#cd7335';
			case 2:
				return '#367642';
		}
	}

	getColorForBool(bool) {
		return bool ? '#367642' : '#BB0F0F';
	}
}
