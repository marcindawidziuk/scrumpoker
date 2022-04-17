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
    {name: 'Scrum Pointing Poker', content: 'Agile planning poker for your team'}
  ],
  link: [
    { rel: 'icon', href: 'favicon.svg'}
  ]
})
</script>

<style scoped>

</style>
