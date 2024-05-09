<template>
  <div>
    <h2 class="text-center text-3xl mb-[2em]">Land Registration</h2>
    <form @submit.prevent="registerLand" class="w-[25em] mx-auto flex flex-col gap-5">
      <input
        class="py-4 px-2 rounded-xl text-white placeholder-color-gray-500 bg-black"
        v-model="landId"
        placeholder="Land ID"
        required
      />
      <input
        class="py-4 px-2 rounded-xl text-white placeholder-color-gray-500 bg-black"
        v-model="owner"
        placeholder="Owner Address"
        required
      />
      <input
        class="py-4 px-2 rounded-xl text-white placeholder-color-gray-500 bg-black"
        v-model="acreage"
        type="number"
        placeholder="Acreage"
        required
      />
      <input
        class="py-4 px-2 rounded-xl text-white placeholder-color-gray-500 bg-black"
        v-model="location"
        placeholder="Location"
        required
      />
      <input
        class="py-4 px-2 rounded-xl text-white placeholder-color-gray-500 bg-black"
        v-model="zoning"
        placeholder="Zoning"
        required
      />
      <div class="flex flex-row">
        <input class="" v-model="existingContract" type="checkbox" /> Existing Contract
      </div>
      <button
        class="text-white text-2xl rounded-xl bg-[#23edac] py-5 w-fit mx-auto px-4"
        type="submit"
      >
        Register Land
      </button>
    </form>
  </div>
</template>

<script setup>
import { landRegistryContract } from '@/utils/web3.js'
import { onMounted, ref } from 'vue'
import web3 from '@/utils/web3.js'

const landId = ref('')
const owner = ref('')
const acreage = ref('')
const location = ref('')
const zoning = ref('')
const existingContract = ref(false)

const registerLand = async () => {
  try {
    const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' })
    owner.value = accounts[0] // Update reactive state

    // Prepare transaction data
    const transactionData = landRegistryContract.methods
      .registerLand(
        landId.value,
        owner.value,
        acreage.value,
        location.value,
        zoning.value,
        existingContract.value
      )
      .encodeABI()

    // Sign the transaction using MetaMask (or other wallet)
    const signedTransaction = await window.ethereum.request({
      method: 'eth_sendTransaction',
      params: [
        {
          from: owner.value,
          to: landRegistryContract.options.address, // Contract address
          data: transactionData
        }
      ]
    })
  alert("Land  Succesfully added")
    console.log('Transaction signed:', signedTransaction)
    landId.value=''
      owner.value=''
      acreage.value=''
      location.value=''
      zoning.value=''

  } catch (error) {
    console.error('Error signing and registering land:', error)
    alert('Error registering land. Please check your details and try again.')
  }
}
onMounted(async () => {
  const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' })
  owner.value = accounts[0] // Update reactive state
})
</script>
