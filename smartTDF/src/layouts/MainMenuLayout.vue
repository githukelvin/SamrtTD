<template>
  <div class="flex flex-col gap-[2em]">
    <NavBar />
    <div class="lg:container mx-auto">
      <RouterView />
    </div>
  </div>
</template>

<script setup>
import NavBar from '@/components/NavBar.vue'
</script>

<style scoped></style>
