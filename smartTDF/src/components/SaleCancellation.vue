<template>
  <div>
    <h2>Cancel Sale</h2>
    <button @click="cancelSale">Cancel Sale</button>
    <p>Current Sale Status: {{ saleStatus }}</p>
  </div>
</template>

<script>
import { landSaleContract } from '@/utils/web3.js'

export default {
  data() {
    return {
      saleStatus: ''
    }
  },
  methods: {
    async cancelSale() {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' })
        const owner = accounts[0] // Replace with the appropriate account address
        await landSaleContract.methods.cancelSale().send({ from: owner })
        alert('Sale cancelled successfully!')
        this.updateSaleStatus()
      } catch (error) {
        console.error('Error cancelling sale:', error)
        alert('Error cancelling sale. Please try again.')
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
