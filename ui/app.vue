<template>
  <div class="h-screen">
    <Head>
      <Title>Home</Title>
    </Head>
    <NuxtLayout>
      <NuxtPage/>
    </NuxtLayout>
  </div>
</template>

<script setup lang="ts">

import {useHead} from "#head";

useHead({
  titleTemplate: 'Scrum Pointing Poker - %s',
  charset: 'utf-8',
  meta: [
    {name: 'Scrum Pointing Poker', content: 'Agile planning poker for your team'},
    {name: 'theme-color', content: '#6666ff'}
  ],
  link: [
    { rel: 'icon', href: 'favicon.svg'},
    {rel: 'stylesheet', href:"https://fonts.googleapis.com/css?family=Montserrat"},
    { rel:"apple-touch-icon", sizes:"180x180", href:"/apple-touch-icon.png"},
  ],
})
</script>

<style scoped>

</style>
