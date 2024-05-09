<template>
  <div>
    <h2>Finalize Sale</h2>
    <button @click="finalizeSale">Finalize Sale</button>
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
    async finalizeSale() {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' })
        const owner = accounts[0] // Replace with the appropriate account address
        await landSaleContract.methods.finalizeSale().send({ from: owner })
        alert('Sale finalized successfully!')
        this.updateSaleStatus()
      } catch (error) {
        console.error('Error finalizing sale:', error)
        alert('Error finalizing sale. Please try again.')
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
