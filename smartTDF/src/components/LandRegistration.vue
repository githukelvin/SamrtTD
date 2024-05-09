<template>
  <div>
    <h2>Land Registration</h2>
    <form @submit.prevent="registerLand">
      <input v-model="landId" placeholder="Land ID" required />
      <input v-model="owner" placeholder="Owner Address" required />
      <input v-model="acreage" type="number" placeholder="Acreage" required />
      <input v-model="location" placeholder="Location" required />
      <input v-model="zoning" placeholder="Zoning" required />
      <input v-model="existingContract" type="checkbox" /> Existing Contract
      <button type="submit">Register Land</button>
    </form>
  </div>
</template>

<script>
import { landRegistryContract } from '@/utils/web3.js'

export default {
  data() {
    return {
      landId: '',
      owner: '',
      acreage: '',
      location: '',
      zoning: '',
      existingContract: false
    }
  },
  methods: {
    async registerLand() {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' })
        const owner = accounts[0]
        await landRegistryContract.methods
          .registerLand(
            this.landId,
            owner,
            this.acreage,
            this.location,
            this.zoning,
            this.existingContract
          )
          .send({ from: owner })
        alert('Land registered successfully!')
      } catch (error) {
        console.error('Error registering land:', error)
        alert('Error registering land. Please try again.')
      }
    }
  }
}
</script>
