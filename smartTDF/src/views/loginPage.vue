<template>
  <div>
    <form @submit.prevent="onSubmit" class="flex flex-col gap-5 w-[25em] mx-auto">
      <input
        v-model="username"
        class="py-4 px-2 rounded-2xl text-white bg-lack placeholder-color-gray-500"
        type="text"
        name="Username"
        id=""
        placeholder="Enter Username"
      />
      <input
        v-model="password"
        class="py-4 px-2 rounded-2xl text-white bg-lack placeholder-color-gray-500"
        type="password"
        name="pass"
        id=""
        placeholder="Enter Password"
      />
      <button
        type="submit"
        class="bg-[#4433ed] py-4 w-fit mx-auto px-6 text-white text-2xl rounded-3xl font-sans"
      >
        Login
      </button>
    </form>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const username = ref('')
const password = ref('')

const onSubmit = async () => {
  if (
    username.value === null ||
    username.value === '' ||
    password.value === null ||
    password.value === ''
  ) {
    alert('Fill All fields')
  }
  console.log(username.value, password.value)
}
</script>

<style scoped></style>
