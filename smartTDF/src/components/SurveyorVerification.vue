<template>
  <div>
    <h2>Surveyor Verification</h2>
    <form @submit.prevent="verifyLand">
      <label> <input v-model="verified" type="checkbox" /> Verified </label>
      <button type="submit">Submit Verification</button>
    </form>
    <p>Land Verification Status: {{ landVerified }}</p>
    <p>Current Sale Status: {{ saleStatus }}</p>
  </div>
</template>

<script>
import { landSaleContract } from '@/utils/web3.js'

export default {
  data() {
    return {
      verified: false,
      landVerified: false,
      saleStatus: ''
    }
  },
  methods: {
    async verifyLand() {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' })
        const surveyor = accounts[0]
        await landSaleContract.methods.verifyLand(this.verified).send({ from: surveyor })
        alert('Land verification submitted successfully!')
        this.updateLandVerificationStatus()
        this.updateSaleStatus()
      } catch (error) {
        console.error('Error verifying land:', error)
        alert('Error verifying land. Please try again.')
      }
    },
    async updateLandVerificationStatus() {
      this.landVerified = await landSaleContract.methods.landVerified().call()
    },
    async updateSaleStatus() {
      const status = await landSaleContract.methods.state().call()
      this.saleStatus = ['Listed', 'InProgress', 'Completed', 'Cancelled'][status]
    }
  },
  mounted() {
    this.updateLandVerificationStatus()
    this.updateSaleStatus()
  }
}
</script>
