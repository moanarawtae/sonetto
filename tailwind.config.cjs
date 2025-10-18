module.exports = {
  darkMode: 'class',
  content: ['./index.html', './src/renderer/**/*.{ts,tsx,html}'],
  theme: {
    extend: {
      colors: {
        brand: {
          DEFAULT: '#5B7FFF',
          50: '#F2F5FF',
          100: '#E0E6FF',
          200: '#B8C4FF',
          300: '#8FA1FF',
          400: '#6780FF',
          500: '#5B7FFF',
          600: '#4A63CC',
          700: '#394999',
          800: '#273066',
          900: '#151733'
        }
      }
    }
  },
  plugins: []
};
