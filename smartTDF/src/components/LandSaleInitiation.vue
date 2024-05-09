<template>
  <div>
    <h2 class="text-center font-bold text-3xl">Initiate Land Sale</h2>
    <form @submit.prevent="initiateSale" class="flex flex-col gap-4 w-[15em] mx-auto">
      <input  class="rounded-xl py-4 px-2 placeholder-color-gray-500 text-white bg-black" v-model="landId" placeholder="Land ID" required />
      <input  class="rounded-xl py-4 px-2 placeholder-color-gray-500 text-white bg-black" v-model="price" type="number" placeholder="Asking Price" required />
      <button class="bg-[#223eac] text-white w-fit mx-auto py-3 px-3 rounded-xl" type="submit">Initiate Sale</button>
    </form>
    <p class="text-center text-2xl  font-sans">Current Sale Status: {{ saleStatus }}</p>
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
        const tx =await landSaleContract.methods.initiateSale(this.landId, this.price).encodeABI()
        console.log('Transaction hash:', tx.transactionHash);
      // Sign the transaction using MetaMask (or other wallet)
        const signedTransaction = await window.ethereum.request({
          method: 'eth_sendTransaction',
          params: [
          {
            from: seller,
            to: "0xEE4424bbD7dB16e06950920ef10deb5f96361337", // Contract address
            data: tx
          }
        ]
      })

        alert('Land sale initiated successfully!',signedTransaction)
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
