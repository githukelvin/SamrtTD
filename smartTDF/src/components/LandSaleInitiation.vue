<template>
  <div>
    <h2>Initiate Land Sale</h2>
    <form @submit.prevent="initiateSale">
      <input v-model="landId" placeholder="Land ID" required />
      <input v-model="price" type="number" placeholder="Asking Price" required />
      <button type="submit">Initiate Sale</button>
    </form>
    <p>Current Sale Status: {{ saleStatus }}</p>
  </div>
</template>

<script>
import { landSaleContract } from '@/utils/web3';

export default {
  data() {
    return {
      landId: '',
      price: '',
      saleStatus: '',
    };
  },
  methods: {
    async initiateSale() {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        const seller = accounts[0];
        await landSaleContract.methods.initiateSale(this.landId, this.price).send({ from: seller });
        alert('Land sale initiated successfully!');
        this.updateSaleStatus();
      } catch (error) {
        console.error('Error initiating sale:', error);
        alert('Error initiating sale. Please try again.');
      }
    },
    async updateSaleStatus() {
      const status = await landSaleContract.methods.state().call();
      this.saleStatus = ['Listed', 'InProgress', 'Completed', 'Cancelled'][status];
    },
  },
  mounted() {
    this.updateSaleStatus();
  },
};
</script>