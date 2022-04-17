<template>
  <div class="bg-gray-200 dark:bg-gray-900 h-full">
    <Head>
      <Title>{{ channelName }}</Title>
    </Head>
    <div>
      <header>
        <section class="mx-auto">
          <div class="w-full container mx-auto p-6">
            <div class="w-full flex items-center justify-between">
              <a class="flex items-center text-indigo-400 no-underline hover:no-underline font-bold text-lg lg:text-2xl"
                 href="/">
                <img alt="logo" class="h-8 mr-2"
                     src="~/assets/poker_logo.svg">
                SCRUM POKER.UK
              </a>
              <div class="flex justify-end content-center">
                <a class="mr-5" href="https://github.com/marcindawidziuk/scrumpoker" target="_blank"><i
                    aria-hidden="true" class="fab fa-github fa-2x text-accent"></i></a>
                <button id="theme-button"
                        aria-hidden="true"
                        class="fas fa-2x flex w-10 bg-transparent font-semibold text-accent fa-lightbulb"
                        onclick="toggleTheme()" title="Change theme" value="Light Theme"></button>
                <span class="sr-only">Change theme</span>

                <ThemePicker/>
              </div>
            </div>
          </div>
        </section>
      </header>
      <main class="container mx-auto h-screen flex-row" role="main">

        <div class="grid lg:grid-cols-3 grid-cols-1 gap-5">

          <div>

            <div class="pl-2">

              <h1 class="mt-4 mb-1 text-2xl text-gray-700 dark:text-gray-50 font-bold">
                Scrum Pointing Poker
              </h1>
              <h2 class="text-gray-700 text-xl dark:text-gray-200 pb-2">
                You've been invited to
                <span class="text-indigo-500 dark:text-indigo-300">#{{roomName}}</span>
              </h2>
            </div>

            <div class="rounded p-5 mt-3 mx-auto max-w-8xl bg-secondary border shadow rounded bg-gray-100 border-gray-400 dark:bg-gray-600 dark:border-gray-500 p-5">
              <div class="mb-4">
                <label class="block text-gray-700 dark:text-gray-100 font-bold mb-2" for="username">
                  Your Name
                </label>
                <input id="username" class="shadow appearance-none border rounded w-full py-2 px-3 focus:outline-none focus:shadow-outline
              text-gray-700
              dark:bg-gray-800 dark:text-gray-50
" placeholder="Username"
                       @keyup.enter="join()"
                       v-model="userName"
                       type="text">
              </div>
              <div class="w-full">
                <button class="w-full bg-indigo-500 text-gray-50 dark:hover:bg-gray-300 dark:bg-gray-50 dark:text-gray-900 font-semibold p-2 rounded" @click="join()">Join</button>
              </div>
            </div>

          </div>

          <div class="col-span-2 lg:my-auto">


            <div class="lg:col-span-2 px-5">
              <div class="max-w-4xl p-4 bg-gray-50 dark:text-gray-500 dark:bg-gray-600 rounded-lg shadow">
                <div class="mb-2 pb-2">
                  <div class="h-3 text-3xl text-left text-gray-400 dark:text-gray-200">“</div>
                  <p class="px-4 text-sm text-gray-600 dark:text-gray-100">
                  <span>

                  <span class="font-semibold">Planning poker</span>, also called <span class="font-semibold">Scrum poker</span>, is a consensus-based, gamified technique for estimating, mostly used for timeboxing in <span class="font-semibold">Agile</span> principles.
                  </span>
                    <span>
                    In planning poker, members of the group make estimates by playing numbered cards face-down to the table, instead of speaking them aloud.
                  </span>
                    The cards are revealed, and the estimates are then discussed.
                    By hiding the figures in this way, the group can avoid the cognitive bias of anchoring, where the first number spoken aloud sets a precedent for subsequent estimates.
                  </p>
                  <div class="h-3 text-3xl text-right">
                    <a href="https://en.wikipedia.org/wiki/Planning_poker" target="_blank" class="text-xs text-gray-400 dark:text-gray-200 underline">Wikipedia</a>
                    <span class="text-gray-400">”</span>
                  </div>
                </div>
              </div>
            </div>


          </div>
        </div>

        <Copyright/>
      </main>

    </div>
  </div>
</template>

<script setup lang="ts">
import '~/assets/app.css'
import {ref} from "@vue/reactivity";
import {useRoute, useRouter} from "vue-router";
import ThemePicker from "~/components/ThemePicker.vue";
import Copyright from "~/components/Copyright.vue";

const userName = ref("")
const roomName = ref("")
const route = useRoute()
roomName.value = route.params.room as string

const router = useRouter()

async function join(){
  if (userName.value.length < 3){
    alert('Enter a username')
    return
  }
  if (roomName.value.length < 3){
    alert('Enter a room name')
    return
  }

  await router.push({path: `/${roomName.value}/${userName.value}`})
}

</script>

<style scoped>

</style>
