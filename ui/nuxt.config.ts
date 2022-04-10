import { defineNuxtConfig } from 'nuxt3'

// https://v3.nuxtjs.org/docs/directory-structure/nuxt.config
export default defineNuxtConfig({
    publicRuntimeConfig: {
        WEBSOCKET_URL: process.env.WEBSOCKET_URL
    },
    modules: [
        '@nuxtjs/tailwindcss'
    ]
})
