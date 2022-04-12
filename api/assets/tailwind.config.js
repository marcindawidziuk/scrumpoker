const tailwind = require('tailwindcss/defaultTheme');

module.exports = {
    purge: [
        '../**/*.html.eex'
    ],
    theme: {},
    variants: {},
    plugins: [
        require('./theme.config.js')
    ],
};