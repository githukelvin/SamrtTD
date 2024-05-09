<template>
  <div>
    <h2>Accept Offer</h2>
    <form @submit.prevent="acceptOffer">
      <input v-model="paymentMethod" placeholder="Payment Method (ETH or Token Address)" required />
      <input v-model="paymentAmount" type="number" placeholder="Payment Amount" required />
      <button type="submit">Accept Offer</button>
    </form>
    <p>Current Sale Status: {{ saleStatus }}</p>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { landSaleContract } from '@/utils/web3';
import Web3 from 'web3';
const paymentMethod = ref('');
const paymentAmount = ref('');
const saleStatus = ref('');

const updateSaleStatus = async () => {
  const status = await landSaleContract.methods.state().call();
  saleStatus.value = ['Listed', 'InProgress', 'Completed', 'Cancelled'][status];
};

const acceptOffer = async () => {
  try {
    const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
    const buyer = accounts[0];
    const paymentValue = Web3.utils.toWei(paymentAmount.value, 'ether');

    if (paymentMethod.value.toLowerCase() === 'eth') {
      await landSaleContract.methods.acceptOffer().send({ from: buyer, value: paymentValue });
    } else {
      const tokenContract = new Web3.eth.Contract(Token_ABI, paymentMethod.value);
      await tokenContract.methods
        .approve(landSaleContract.options.address, paymentValue)
        .send({ from: buyer });
      await landSaleContract.methods.acceptOffer().send({ from: buyer });
    }

    alert('Offer accepted successfully!');
    await updateSaleStatus();
  } catch (error) {
    console.error('Error accepting offer:', error);
    alert('Error accepting offer. Please try again.');
  }
};

updateSaleStatus();
</script>