<template>
  <div class="dark h-full">
    <div class="bg-gray-50 dark:bg-gray-900" data-theme="dark">
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
              </div>
            </div>
          </div>
        </section>
      </header>
      <main class="container mx-auto h-screen flex-row" role="main">

        <div class="grid lg:grid-cols-3 md:grid-cols-1 gap-5">

        <div>

          <div class="pl-2">

            <h1 class="mt-4 mb-1 text-2xl text-gray-100 font-bold">
              Scrum Pointing Poker
            </h1>
            <h2 class="text-gray-200 pb-2">
              No sign up required, 100% free
            </h2>
            <p class="hidden leading-normal mx-auto text-md text-gray-50 text-base md:text-xl mb-8 mb-5">
              Get your scrum session started! <br> No sign up required, 100% free.
            </p>
          </div>

          <div class="rounded p-5 mt-3 mx-auto max-w-8xl bg-secondary border shadow rounded bg-gray-600 dark:border-gray-500 p-5">
            <div class="mb-4 fade-in">
              <label class="block text-gray-100 font-bold mb-2" for="username">
              Your Name
            </label>
              <input id="username" class="shadow appearance-none border rounded w-full py-2 px-3 focus:outline-none focus:shadow-outline
              dark:bg-gray-800 dark:text-gray-50
" placeholder="Username"
                     v-model="userName"
                            type="text">
            </div>
            <div class="mb-2 fade-in">
              <label class="block text-gray-100 font-bold mb-2" for="password">
              Room Name
            </label>
              <input id="password" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline dark:bg-gray-800 dark:text-gray-50
" placeholder="Room Name"
                     @keyup.enter="join()"
                     v-model="roomName"
                            type="text">
            </div>
            <div class="w-full">
              <button class="w-full dark:hover:bg-gray-300 dark:bg-gray-50 dark:text-gray-900 font-semibold p-2 rounded" @click="join()">Start a Session</button>
            </div>
          </div>

          </div>

          <div class="col-span-2 lg:my-auto">


          <div class="lg:col-span-2 px-5">
            <div class="max-w-4xl p-4 text-gray-500 bg-gray-600 rounded-lg shadow">
              <div class="mb-2 pb-2">
                <div class="h-3 text-3xl text-left text-gray-200">“</div>
                <p class="px-4 text-sm text-gray-100">
                  <span>

                  <span class="font-semibold">Planning poker</span>, also called <span class="font-semibold">Scrum poker</span>, is a consensus-based, gamified technique for estimating, mostly used for timeboxing in <span class="font-semibold">Agile</span> principles.
                  </span>
                  <span>
                    In planning poker, members of the group make estimates by playing numbered cards face-down to the table, instead of speaking them aloud.
                  </span>
                  The cards are revealed, and the estimates are then discussed.
                  By hiding the figures in this way, the group can avoid the cognitive bias of anchoring, where the first number spoken aloud sets a precedent for subsequent estimates.
                </p>
                <div class="h-3 text-3xl text-right text-gray-200">
                  <a href="https://en.wikipedia.org/wiki/Planning_poker" target="_blank" class="text-xs underline">Wikipedia</a>
                  ”
                </div>
              </div>
            </div>
          </div>


          </div>
        </div>

        <div class="w-full pt-16 pb-6 text-sm text-center md:text-left fade-in">
          <a class="text-gray-500 no-underline hover:no-underline" href="https://github.com/marcindawidziuk">
            © Marcin Dawidziuk 2022
          </a>
        </div>
      </main>

    </div>
  </div>
</template>

<script setup lang="ts">
import '~/assets/app.css'
import {ref} from "@vue/reactivity";
import {useRouter} from "vue-router";

const userName = ref("")
const roomName = ref("")

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
.form-checkbox{
  background-image: url("data:image/svg+xml,%3csvg viewBox='0 0 16 16' fill='white' xmlns='http://www.w3.org/2000/svg'%3e%3cpath d='M5.707 7.293a1 1 0 0 0-1.414 1.414l2 2a1 1 0 0 0 1.414 0l4-4a1 1 0 0 0-1.414-1.414L7 8.586 5.707 7.293z'/%3e%3c/svg%3e");
  border-color: transparent;
  background-color: currentColor;
  background-size: 100% 100%;
  background-position: center;
  background-repeat: no-repeat;
}
</style>
