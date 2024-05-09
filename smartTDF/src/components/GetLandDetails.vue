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
    <div v-if="details">

      <div v-if="details.location!=='' && details.zoning!== null ">
        <p>Owner Details:{{details.owner}}</p>
        <p>Acreage of the Land:{{details.acreage}}</p>
        <p>Location of The Farm: {{details.location}}</p>
        <p>Zoning of the Plot: {{details.zoning}}</p>
      </div>
      <div v-else>
        <p>NO Record Found</p>
      </div>
    </div>

    <div v-else>
      <p>Search Data by Id</p>
    </div>
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
    transactionData.then((data)=>{
      details.value =data
    })
      .catch((error)=>{
        console.error('Error fetching land details:', error);
      })
    console.log('Transaction signed:',transactionData )

  } catch (error) {
    console.error('Error fetching land details:', error);
    alert('Error retrieving land details. Please try again later.');
  }
}
//
onMounted(async () => {
  try {
    const transactionData =  landRegistryContract.methods.getAllLands().call();
    Alldetails.value = transactionData;
    console.log(transactionData);
  } catch (error) {
    console.error('Error fetching land details:', error);
  }
});
</script>

<style scoped></style>
