﻿<template>
  <div class="h-full bg-gray-50 dark:bg-gray-900">
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
                        title="Change theme" value="Light Theme"></button>
                <span class="sr-only">Change theme</span>
                <ThemePicker/>
              </div>
            </div>
          </div>
        </section>
      </header>
      <main class="container mx-auto" role="main">
        <div v-if="alone" class="p-2 mb-5 dark:bg-gray-500 dark:text-gray-100 px-4 bg-indigo-500 text-gray-50 border dark:border-gray-400 rounded">
          <div class="grid md:grid-cols-2 xs:grid-cols-1">
            <span class="my-auto font-semibold">
              Seems like you are here all by yourself, send this link to your team-mates:
            </span>
            <input
                class="self-strech shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                onclick="this.setSelectionRange(0, this.value.length)"
                readonly="readonly"
                :value="'https://scrumpoker.uk/' + channelName">
          </div>
        </div>

        <div id="app" class="bg-indigo-50 dark:bg-gray-700">
          <div class="mx-auto max-w-8xl bg-secondary text-on-secondary border shadow rounded border-gray-300 dark:border-gray-500 p-5">
            <div class="grid grid-cols-2">
              <div>
                <div class="row lg:text-3xl dark:text-gray-50 text-indigo-500 font-semibold slide-in-bottom-h1 uppercase">
                  <h1>
                    #{{channelName}}
                  </h1>
                </div>

                <div v-if="!alone" class="mt-2 text-lg dark:text-gray-50">
                  <span>{{ users.length }} users joined poker session</span>
                </div>


                <div class="mt-2" style="min-height: 300px;">

                  <div class="text-on-secondary p-2">
                    <ul id="votes" class="list-disc text-xl pl-2">
                      <li v-for="user in users" :key="user.name" class="transition text-gray-700 dark:text-gray-50">
                        <span>
                          {{ user.name }}
                          <span v-if="!user.online"> (Offline)</span>
                        </span>
                        <div v-if="isShowingVotes" class="inline">
                          <span v-if="user.isObserving">is observing</span>
                          <span v-else-if="user.vote" >
                            voted {{ user.vote }}
                          </span>
                          <div v-else class="inline-block"><span class="text-gray-700 dark:text-gray-50">didn't vote</span></div>
                        </div>
                        <div v-else class="inline">
                          <span v-if="user.isObserving">is observing</span>
                          <svg v-else-if="user.vote" xmlns="http://www.w3.org/2000/svg" class="ml-1 inline h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                          </svg>
                          <div v-else class="inline-block -translate-x-1"><span class="te-spin dark:text-gray-200 text-gray-800 loading"></span></div>
                        </div>
                      </li>
                    </ul>
                  </div>
                  <span v-if="firstVote && alone" class="text-indigo-700 dark:text-indigo-300 ml-2 block">Please make sure everyone joined before you vote!</span>
                  <span v-if="!connected" class="text-red-600 dark:text-red-300 ml-2 block">Failed connecting to the server...</span>
                </div>
              </div>
              <div class="column p-2">
                <span class="hidden text-gray-50 float-right">
                  Vote history (1)
                </span>

                <label
                  class="text-accent-secondary font-semibold p-1 slide-in-bottom-subtitle font-bold dark:text-gray-50">
                  Story description
                </label>

                <textarea v-model="storyDescription"
                          @input="updateMessage()"
                          class="mt-2 transition dark:bg-gray-800 dark:text-gray-50 bg-background border appearance-none rounded w-full py-2 px-3 leading-tight focus:outline-none focus:shadow-outline slide-in-bottom border-1 border-gray-400 dark:border-gray-600 min-h-[100px]"></textarea>
              </div>
            </div>
            <div class="mt-3 grid grid-cols-1">
              <div class="ml-auto flex mr-2">
                <div class="inline my-auto">
                  <label class="inline font-semibold mr-4">
                    <input
                        v-model="isObserving"
                      class="mr-2 dark:text-gray-50 leading-tight form-checkbox font-semibold checked:bg-red-300 checked:text-indigo-500 scale-125" type="checkbox"> <span
                      class="text-md" title="Just observe, don't participate in voting">
                   <span class="text-gray-700 dark:text-gray-50">I'm an observer</span>
                   </span>
                  </label>
                </div>

                <div class="inline">

                <span class="text-gray-700 dark:text-gray-50 mr-2 font-semibold">Card deck: </span>
                <select class="p-1" v-model="activeDeck">
                  <option v-for="deck in decks" :value="deck" >
                    {{ deck.name }}
                  </option>
                </select>
                </div>
                <div class="inline-block">

                <button @click="isAddingCustomDeck = true" title="Customise deck" class="bg-gray-50 text-gray-700 rounded p-0.5 ml-2">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                  </svg>
                </button>
                </div>
              </div>
            </div>

            <div class="relative">
              <div class="grid grid-cols-4 md:grid-cols-6 lg:grid-cols-12 pt-3">
                <button v-for="card in activeDeck.cards.filter(x => x)"
                        @click="selectCard(card)"
                        :class="[activeCard === card
                        ? '-safe:animate-spin -translate-y-3 bg-indigo-100 dark:border-indigo-400 dark:bg-indigo-200 outline outline-indigo-500 dark:hover:bg-indigo-300'
                        : 'bg-gray-50 hover:bg-gray-400 hover:text-white dark:hover:bg-gray-400 active:dark:bg-gray-500 dark:hover:text-gray-50 dark:bg-gray-50 border border-gray-400 dark:border-0',
                        (isShowingVotes && activeCard !== card) ? 'bg-gray-300 text-gray-400' : '']"
                        class="transition p-2 m-2 h-20 font-semibold rounded text-xl md:h-32 lg:h-32">
                  {{ card }}
                </button>
              </div>
            </div>
            <div class="grid grid-cols-2">
              <PButton class="m-2" :disabled="isShowingVotes" @click="showVotes">
                Show votes
              </PButton>
              <PButton class="m-2" :disabled="!isShowingVotes" @click="nextStory">
                Next story
              </PButton>
            </div>

            <div class="block flex mt-5">
              <span class="text-align-top text-gray-700 dark:text-gray-50 text-xs mt-1">
                You can invite other users by sending them link:
                <span>https://scrumpoker.uk/{{ channelName }}</span>
              </span>

              <input
                  class="hidden text-sm shadow appearance-none border border-gray-600 rounded w-full py-1 px-2 dark:bg-gray-800 dark:text-gray-50 leading-tight focus:outline-none focus:shadow-outline"
                  onclick="this.setSelectionRange(0, this.value.length)"
                  readonly="readonly"
                  value="https://scrumpoker.uk/wingen">
            </div>

            <div class="hidden flex mb-4 mt-5">
              <div class="h-10 p-2"><span class="my-auto font-bold align-middle text-align-top text-gray-50">Invitation:</span></div>
              <input
                  class="self-strech shadow appearance-none border rounded w-full py-1 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                  onclick="this.setSelectionRange(0, this.value.length)"
                  readonly="readonly"
                  value="http://scrumpoker.uk/wingen">
            </div>
          </div>
        </div>

        <div v-if="isAddingCustomDeck" class="fixed bottom-0 inset-x-0 px-4 pb-4 sm:inset-0 sm:flex sm:items-center sm:justify-center">
          <div class="fixed inset-0 transition-opacity">
            <div class="absolute inset-0 bg-gray-800 opacity-75"></div>
          </div>
          <div aria-labelledby="modal-headline" aria-modal="true" class="bg-gray-200 rounded-lg overflow-hidden shadow-xl transform transition-all sm:max-w-lg sm:w-full"
               role="dialog"
               style="z-index: 1;">
            <div class="bg-gray-700 px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
              <div class="sm:flex sm:items-start">
                <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left"><h3 id="modal-headline"
                                                                               class="text-lg leading-6 font-semibold text-gray-50">
                  Setting Custom Deck
                </h3>
                  <div class="mt-2"><p class="text-sm leading-5 text-gray-50">
                    Add your own deck of cards (max 12 cards).
                  </p>
                  </div>
                  <div class="grid grid-cols-2 md:grid-cols-2 lg:grid-cols-1"><label
                      class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"> Custom Deck Name:
                  </label>
                    <input
                        :value="customName"
                      class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white">
                    <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"> Cards:
                    </label>
                    <div class="grid grid-cols-3">
                      <input v-for="(_, index) in customCards"
                             v-model="customCards[index]"
                        class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-500 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white mx-0.5">
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="bg-gray-800 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse"><span
                class="flex w-full rounded-md shadow-sm sm:ml-3 sm:w-auto">
              <button @click="addCustomDeck()" class="inline-flex justify-center w-full rounded-md border border-transparent px-4 py-2 bg-gray-600 text-base leading-6 font-medium text-white shadow-sm hover:bg-gray-400 focus:outline-none focus:border-red-700 focus:shadow-outline-red transition ease-in-out duration-150 sm:text-sm sm:leading-5"
                                                                                   type="button">
              Set Deck
            </button></span> <span class="mt-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:w-auto">
              <button @click="isAddingCustomDeck = false" class="inline-flex justify-center w-full rounded-md border border-gray-300 px-4 py-2 bg-white text-base leading-6 font-medium text-gray-700 shadow-sm hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue transition ease-in-out duration-150 sm:text-sm sm:leading-5"
                                                                                                           type="button">
              Cancel
            </button></span></div>
          </div>
        </div>


      </main>
      <Copyright/>
    </div>
  </div>
</template>

<script setup lang="ts">
import 'assets/app.css'
import {computed, ref} from "@vue/reactivity";
import {Channel, Presence, Socket} from "phoenix";
import {onMounted, watch} from "@vue/runtime-core";
import {useRoute} from "vue-router";
import {useRuntimeConfig} from "#app";
import PButton from "~/components/PButton.vue";
import ThemePicker from "~/components/ThemePicker.vue";
import Copyright from "~/components/Copyright.vue";
const toggleTheme = () => { }

const isObserving = ref(false)
const connected = ref(false)
const firstVote = ref(true)
const userName = ref("marcin")

const presences = ref([])
const storyDescription = ref("")

const route = useRoute()
const channelName = ref((route.params.room as string).toLowerCase())


let listBy = (id, {metas: [first, ...rest]}) => {
  first.name = id;
  first.count = rest.length + 1;
  return first;
};

function getCards(cardsString: string): string[]{
  return cardsString.split('|')
  .filter(x => x !== '')
}

function updateMessage(){
    channel.push('change_message', { // send the message to the server on "shout" channel
      name: this.userName,     // get value of "name" of person sending the message
      message: storyDescription.value
    });
}

let channel: Channel = null

const config = useRuntimeConfig()

onMounted(() => {
  try{

    if (route.params.user){
      userName.value = route.params.user as string
    }
    console.log('config', config)
    console.log('config socket', config.WEBSOCKET_URL)
    let socket = new Socket(config.WEBSOCKET_URL, {params: {user_id: userName.value}});

    channel = socket.channel('room:'+ channelName.value +':lobby', {}); // connect to chat "room"
    let presence = new Presence(channel);

    socket.onError((a) => console.log(a));
    presence.onSync(() => {
      connected.value = true;
      console.log("PRESENCE SYNC");
      presences.value = presence.list(listBy);
    });
    socket.connect();


  channel.on('change_message', function (payload) {
    connected.value = true;
    console.log('changed message by ' + payload.name + ' to ' + payload.message);
    storyDescription.value = payload.message;
  });

  channel.on('active_deck', function (payload) { // listen to the 'shout' event
    connected.value = true;
    console.log(payload.cards);

    decks.value = payload.decks.map(x => ({
      name: x.name,
      cards: x.cards.split('|')
    }))

    const chosenDeck = decks.value
        .filter(x => x.name == payload.currentDeck.name)
        .find(x => x.cards == getCards(payload.currentDeck.cards))

    if (chosenDeck){
      activeDeck.value = chosenDeck
    }else{
      activeDeck.value = {
        cards: getCards(payload.currentDeck.cards),
        name: payload.currentDeck.name
      }
    }
  });

  channel.on('joined', function (payload) {
    if (userName.value !== payload.name){
      channel.push('change_message', { // send the message to the server on "shout" channel
        name: this.userName,     // get value of "name" of person sending the message
        message: storyDescription.value
      });
    }

    if (activeCard.value){
      channel.push('voted', {
        name: userName.value,
        message: activeCard.value
      });
    }
  });

  channel.join()
    .receive("ok", ({messages}) => console.log("catching up", messages) )
    .receive("error", ({reason}) => console.log("failed join", reason) )
    .receive("timeout", () => {
      console.log("Networking issue. Still waiting...")
    });

  channel.onError(x => connected.value = false)

    channel.on('voted', function (payload) { // listen to the 'shout' event
      connected.value = true;
      console.log(payload.name + " voted", payload);
      userVoted(payload.name, payload.message)
    });

  channel.on('show_votes', function (payload) { // listen to the 'shout' event
    console.log('show_votes');
    isShowingVotes.value = true
  });


  channel.on('clear_votes', function (payload) { // listen to the 'shout' event
    console.log('clear_votes');
    activeCard.value = null
    isShowingVotes.value = false;
    for (let user of users.value){
      user.vote = null
    }
  });

  channel.push('joined', { // send the message to the server on "shout" channel
    name: userName.value     // get value of "name" of person sending the message
  });


  }catch (e) {
    console.log('catch',e)
  }
})


function addDeck(name: string, cards: string[]){
  channel.push('add_deck', {
    deck: {
      cards: cards.join('|'),
      name: name
    }
  });
}

function addCustomDeck(){
  addDeck(customName.value, customCards.value)
  isAddingCustomDeck.value = false;
}

function userVoted(userName: string, vote: string){
  firstVote.value = false
  const user = users.value.find(x => x.name == userName)
  user.vote = vote
}

interface IVoteHistory
{
  date: number;
  story: string | null;
  votes: Array<{name: string, vote: string | null}>
}

const history = ref<Array<IVoteHistory>>([])
history.value.push({date: Date.now(), story: 'CBAC-123', votes: [{name: 'Martin', vote: '1'}, {name: 'ABC', vote: '2'}]})

const defaultDecks = [
  {
    name: 'Standard',
    cards: ['0', '0.5', '1', '2', '3', '5', '8', '13', '20', '40', '∞', '☕']
  },
  {
    name: 'Time estimate',
    cards: ['30m', '1h', '2h', '4h', '1d', '2d', '5d', '8d', '13d', '20d', '∞', '☕']
  },
  {
    name: 'Shirts',
    cards: ['XSS', 'XS', 'S', 'M', 'L', 'XL', 'XXL', '∞', '☕']
  },
]

const decks = ref(defaultDecks)

const isAddingCustomDeck = ref(false)
const activeDeck = ref(decks.value[0])
const deckCards = ['0', '0.5', '1', '2', '3', '5', '8', '13', '20', '40', '∞', '☕']
const customName = ref('Custom deck')
const customCards = ref(deckCards)
const activeCard = ref()
const alone = computed(() => users.value.length < 2)

const selectCard = function (card: string){
  if (isShowingVotes.value)
    return;

  activeCard.value = card

  channel.push('voted', {
    name: userName.value,
    message: card
  });

  // If we are the last to vote then trigger showing votes
  let hasEveryoneVoted = users.value
      .filter(x => x.name !== userName.value)
      .filter(x => !x.isObserving)
      .filter(x => x.online)
      .every(x => x.vote != null)
  console.log('hasEveryoneVoted', hasEveryoneVoted)

  if (hasEveryoneVoted){
    showVotes();
  }
}

function showVotes(){
  if (confirm("Are you sure you want to complete voting?") != true) {
    return;
  }
  channel.push('show_votes', {
    name: userName.value,
  });
}

function nextStory(){
  if (!isShowingVotes.value){
    return;
  }

  channel.push('change_message', { // send the message to the server on "shout" channel
    name: userName.value,     // get value of "name" of person sending the message
    message: ""
  });
  channel.push('clear_votes', { // send the message to the server on "shout" channel
    name: userName.value,     // get value of "name" of person sending the message
  });
}

const isShowingVotes = ref(false)

interface User {
  name: string;
  vote: string | null;
  online: boolean;
  isObserving: boolean;
}

const users = ref<User[]>([])

watch(presences, (newPresence) => {
  console.log('watch', newPresence)
  for (let p of presences.value){
    console.log('p', p)
    const user = users.value.find(x => x.name == p.name)
    if (!user){
      users.value.push({name: p.name, vote: null, isObserving: p.observer, online: true})
    }else{
      user.isObserving = p.observer
    }
  }
  for (let user of users.value){
    user.online = newPresence.some(x => x.name == user.name)
  }
  users.value.sort( (a, b) => a.name.localeCompare(b.name))
})

watch(isObserving, () => {
  channel.push("user_set_observer", {
    name: userName.value,
    observer: isObserving.value
  })
})

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
.loading:after {
  overflow: hidden;
  display: inline-block;
  vertical-align: bottom;
  -webkit-animation: ellipsis steps(4,end) 1500ms infinite;
  animation: ellipsis steps(4,end) 1500ms infinite;
  content: "\2026"; /* ascii code for the ellipsis character */
  width: 0px;
}

@keyframes ellipsis {
  to {
    width: 20px;
  }
}

@-webkit-keyframes ellipsis {
  to {
    width: 20px;
  }
}
</style>
