<template>
  <header class="bg-[#232edf]">
    <div class="lg:container mx-auto py-[1em] flex flex-row justify-between">
      <div class="logo">
        <router-link class="text-white capitalize text-3xl" to="/">SmartTD</router-link>
      </div>
      <nav>
        <ul class="flex flex-row gap-6">
          <li><router-link class="text-white text-2xl" to="/">Home</router-link></li>
          <li><router-link class="text-white text-2xl" to="buy">Buy</router-link></li>
          <li><router-link class="text-white text-2xl" to="/sell">Sell</router-link></li>
          <li><router-link class="text-white text-2xl" to="list">Listing</router-link></li>
          <li><router-link class="text-white text-2xl" to="gov">Government</router-link></li>
          <li><router-link class="text-white text-2xl" to="survey">Surveyor</router-link></li>
        </ul>
      </nav>
    </div>
  </header>
</template>

<script setup></script>

<style scoped></style>
