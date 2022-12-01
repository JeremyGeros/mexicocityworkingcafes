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
			'map',
			'googleMapsLink',
			'seating',
			'outdoorSeating',
			'address',
			'notes',
			'calls',
			'food',
			'otherPeopleWorking',
			'image',
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

		this.seatingTarget.innerText = cafeInformation.seating;
		this.outdoorSeatingTarget.innerText = cafeInformation.outdoor;

		this.addressTarget.innerText = cafeInformation.address;
		this.notesTarget.innerText = cafeInformation.notes;
		this.callsTarget.innerText = cafeInformation.calls;
		this.foodTarget.innerText = cafeInformation.food;
		this.otherPeopleWorkingTarget.innerText =
			cafeInformation.other_people_working;

		this.imageTarget.src = cafeInformation.image_link;

		this.googleMapsLinkTarget.href = cafeInformation.google_link;

		this.initMap();
	}

	copy() {
		copyToClipboard(this.cafeInformationValue.wifi_password);
		this.wifiPasswordTarget.innerHTML = 'Copied!';
		setTimeout(() => {
			this.wifiPasswordTarget.innerHTML =
				this.cafeInformationValue.wifi_password;
		}, 5000);
	}

	initMap() {
		const cafe = {
			lat: this.cafeInformationValue.latitude,
			lng: this.cafeInformationValue.longitude,
		};

		const map = new google.maps.Map(this.mapTarget, {
			zoom: 15,
			center: cafe,
			disableDefaultUI: true,
			disableDoubleClickZoom: true,
			draggable: false,
			keyboardShortcuts: false,
			panControl: false,
			zoomControl: false,
		});

		const marker = new google.maps.Marker({
			position: cafe,
			map: map,
		});
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
