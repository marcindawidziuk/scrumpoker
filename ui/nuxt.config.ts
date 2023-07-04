
// https://v3.nuxtjs.org/docs/directory-structure/nuxt.config
export default defineNuxtConfig({
    publicRuntimeConfig: {
        WEBSOCKET_URL: process.env.WEBSOCKET_URL
    },
    modules: [
        '@nuxtjs/tailwindcss',
        '@nuxtjs/color-mode'
    ],
    colorMode: {
        preference: 'light', // default value of $colorMode.preference
        fallback: 'light', // fallback value if not system preference found
        hid: 'nuxt-color-mode-script',
        globalName: '__NUXT_COLOR_MODE__',
        componentName: 'ColorScheme',
        classPrefix: '',
        classSuffix: '',
        storageKey: 'nuxt-color-mode'
    }
})
