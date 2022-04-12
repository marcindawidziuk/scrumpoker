<template>
  <button v-if="disabled" @click="$emit('click')"
          class="bg-gray-300 text-gray-400 hover:bg-gray-300 dark:hover:bg-gray-300 dark:bg-gray-50 dark:text-gray-900 font-semibold px-2 py-1 rounded border border-gray-400 dark:border-0">
    <slot/>
  </button>
  <button v-else @click="$emit('click')"
          class="bg-gray-50 hover:bg-gray-400 hover:text-gray-50 dark:hover:bg-gray-300 dark:bg-gray-50 dark:text-gray-900 font-semibold px-2 py-1 rounded border border-gray-400 dark:border-0">
    <slot/>
  </button>
</template>

<script setup lang="ts">
defineEmits(['click'])
const props = defineProps({
  disabled: {
    type: Boolean,
    default: false
  }
})
</script>

<style scoped>

</style>
