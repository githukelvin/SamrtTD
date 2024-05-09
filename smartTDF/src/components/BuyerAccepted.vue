<template>
  <div>
    <h2 class="text-2xl text-center">Accept Offer</h2>
    <form @submit.prevent="acceptOffer" class="w-[20em] mx-auto flex flex-col gap-5">
      <input
        class="py-3 rounded-xl placeholder-color-gray-500 text-white bg-black px-3"
        v-model="paymentMethod"
        placeholder="Payment Method (ETH or Token Address)"
        required
      />
      <input
        class="py-3 rounded-xl placeholder-color-gray-500 text-white bg-black px-3"
        v-model="paymentAmount"
        type="number"
        placeholder="Payment Amount"
        required
      />
      <button class="bg-[#24eafa] py-3 px-4 w-fit mx-auto rounded" type="submit">
        Accept Offer
      </button>
    </form>
    <p class="text-center">Current Sale Status: {{ saleStatus }}</p>
  </div>
</template>
<script>
import { landSaleContract } from '@/utils/web3'
import web3 from 'web3'

export default {
  data() {
    return { paymentMethod: '', paymentAmount: '', saleStatus: '' }
  },
  methods: {
    async acceptOffer() {
      const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' })
      const buyer = accounts[0]
      console.log(buyer)
      try {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' })
        const buyer = accounts[0]
        const paymentValue = web3.utils.toWei(this.paymentAmount, 'ether')
        if (this.paymentMethod.toLowerCase() === 'eth') {
          await landSaleContract.methods.acceptOffer().send({ from: buyer, value: paymentValue })
        } else {
          const tokenContract = new web3.eth.Contract(Token_ABI, this.paymentMethod)
          await tokenContract.methods
            .approve(landSaleContract.options.address, paymentValue)
            .send({ from: buyer })
          await landSaleContract.methods.acceptOffer().send({ from: buyer })
        }
        alert('Offer accepted successfully!')
        this.updateSaleStatus()
      } catch (error) {
        console.error('Error accepting offer:', error)
        alert('Error accepting offer. Please try again.')
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
