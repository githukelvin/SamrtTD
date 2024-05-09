<template>
  <div>
    <h2 class="text-center font-bold text-3xl">Initiate Land Sale</h2>
    <form @submit.prevent="initiateSale" class="flex flex-col gap-4 w-[15em] mx-auto">
      <input  class="rounded-xl py-4 px-2 placeholder-color-gray-500 text-white bg-black" v-model="landId" placeholder="Land ID" required />
      <input  class="rounded-xl py-4 px-2 placeholder-color-gray-500 text-white bg-black" v-model="price" type="number" placeholder="Asking Price" required />
      <button class="bg-[#223eac] text-white w-fit mx-auto py-3 px-3 rounded-xl" type="submit">Initiate Sale</button>
    </form>
    <p>Current Sale Status: {{ saleStatus }}</p>
  </div>
</template>

<script>
import { landSaleContract } from '@/utils/web3.js'

export default {
  data() {
    return {
      landId: '',
      price: '',
      saleStatus: ''
    }
  },
  methods: {
    async initiateSale() {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' })
        const seller = accounts[0]
        await landSaleContract.methods.initiateSale(this.landId, this.price,seller).send({ from: seller })
        alert('Land sale initiated successfully!')
        this.updateSaleStatus()
      } catch (error) {
        console.error('Error initiating sale:', error)
        alert('Error initiating sale. Please try again.')
      }
    },
    async updateSaleStatus() {
      const status = await landSaleContract.methods.state().call()
      this.saleStatus = ['Listed', 'InProgress', 'Completed', 'Cancelled'][status]
    }
  },
  mounted() {
    this.updateSaleStatus()
  }
}
</script>
