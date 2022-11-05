const defaultTheme = require('tailwindcss/defaultTheme');
const plugin = require('tailwindcss/plugin');

module.exports = {
	content: [
		'./public/*.html',
		'./app/helpers/**/*.rb',
		'./app/javascript/**/*.js',
		'./app/views/**/*.{erb,haml,html,slim}',
	],
	safelist: [
		{
			pattern: /w-\d+/,
		},
		{
			pattern: /h-\d+/,
		},
	],
	theme: {
		extend: {
			fontFamily: {
				sans: ['Whitney A', 'Whitney B', ...defaultTheme.fontFamily.sans],
				serif: ['Sentinel A', 'Sentinel B', ...defaultTheme.fontFamily.serif],
			},
			colors: {
				'main-black': '#191a22',
				'main-gray': '#21232d',
				'main-border': '#2C2D3C',
				'dark-border': '#212234',
				'main-hover': '#1c1d29',

				'purple-dark': '#663399',

				'btn-blue': '#316CC6',
				'btn-gray': '#343647',
				'btn-red': '#BB0F0F',
				'btn-green': '#367642',

				blue: '#1a465a',
				'blue-light': '#2e7797',
			},
			textShadow: {
				sm: '0 1px 2px var(--tw-shadow-color)',
				DEFAULT: '0 2px 4px var(--tw-shadow-color)',
				lg: '0 8px 16px var(--tw-shadow-color)',
			},

			btnShadow: {
				primaryLight:
					'inset 0 1px 0 0 rgba(255, 255, 255, 0.1), inset 0 0 0 0 rgba(0,0,0,0), inset 0 0 0 0 rgba(0,0,0,0), 0 0 0 1px rgba(43, 48, 91, 0.85), 0 2px 1px 0 rgba(9, 11, 20, 0.12), 0 2px 3px 0 rgba(9, 11, 20, 0.18), 0 0 0 0 rgba(0,0,0,0), 0 0 0 0 rgba(0,0,0,0)',
			},
		},
	},
	plugins: [
		require('@tailwindcss/forms'),
		require('@tailwindcss/aspect-ratio'),
		require('@tailwindcss/typography'),
		plugin(function ({ matchUtilities, theme }) {
			matchUtilities(
				{
					'text-shadow': (value) => ({
						textShadow: value,
					}),
				},
				{ values: theme('textShadow') }
			);
		}),
	],
};
