<template>
  <div>
    <h2>Government Approval</h2>
    <form @submit.prevent="approveTransfer">
      <label>
        <input v-model="approved" type="checkbox" /> Approved
      </label>
      <button type="submit">Submit Approval</button>
    </form>
    <p>Government Approval Status: {{ governmentApproved }}</p>
    <p>Current Sale Status: {{ saleStatus }}</p>
  </div>
</template>

<script>
import { landSaleContract } from '@/utils/web3';

export default {
  data() {
    return {
      approved: false,
      governmentApproved: false,
      saleStatus: '',
    };
  },
  methods: {
    async approveTransfer() {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        const governmentOfficial = accounts[0];
        await landSaleContract.methods.approveTransfer(this.approved).send({ from: governmentOfficial });
        alert('Transfer approval submitted successfully!');
        this.updateGovernmentApprovalStatus();
        this.updateSaleStatus();
      } catch (error) {
        console.error('Error approving transfer:', error);
        alert('Error approving transfer. Please try again.');
      }
    },
    async updateGovernmentApprovalStatus() {
      this.governmentApproved = await landSaleContract.methods.governmentApproved().call();
    },
    async updateSaleStatus() {
      const status = await landSaleContract.methods.state().call();
      this.saleStatus = ['Listed', 'InProgress', 'Completed', 'Cancelled'][status];
    },
  },
  mounted() {
    this.updateGovernmentApprovalStatus();
    this.updateSaleStatus();
  },
};
</script>