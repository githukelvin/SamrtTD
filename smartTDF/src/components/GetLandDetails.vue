<template>
  <div>
    <form @submit.prevent="getLandDetails" class="mx-auto flex flex-col w-[15em] gap-5">
      <input
        placeholder="Enter LandID "
        class="bg-black rounded-xl placeholder-color-gray-500 text-white py-4 px-2"
        v-model="landId"
        type="number"
        name=""
        id=""
      />
      <button class="py-4 px-2 text-white bg-[#232eac] rounded-xl" type="submit">
        Get Details
      </button>
    </form>
  </div>
</template>

<script setup>
import { landRegistryContract } from '@/utils/web3.js'
import { onMounted, ref } from 'vue'
const landId = ref()
const details = ref()
const Alldetails = ref()
const owner = ref('')

const getLandDetails = async () => {
  try {
    console.log(landRegistryContract.abi)
    // Prepare transaction data
    const transactionData = landRegistryContract.methods.getLandDetails(landId.value).call()

    console.log('Transaction signed:', transactionData)
  } catch (error) {
    console.error('Error fetching land details:', error);
    alert('Error retrieving land details. Please try again later.');
  }
}
//
onMounted(async () => {
  try {
    console.log(landRegistryContract.abi)

    const transactionData = await landRegistryContract.methods.getAllLands().call();
    Alldetails.value = transactionData;
    console.log(transactionData);
  } catch (error) {
    console.error('Error fetching land details:', error);
  }
});
</script>

<style scoped></style>
