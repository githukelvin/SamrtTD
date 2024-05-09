import Web3 from 'web3';

// Replace with your Ethereum node URL
const web3 = new Web3('http://localhost:8545');

// Replace with the deployed contract addresses and ABIs
const landRegistryAddress = '0x1891F4EC23a2f78c1295f6EE77BBAE347D29f337';
const landRegistryABI = [];
const landSaleAddress = '0x1891F4EC23a2f78c1295f6EE77BBAE347D29f337';
const landSaleABI = [];

export const landRegistryContract = new web3.eth.Contract(landRegistryABI, landRegistryAddress);
export const landSaleContract = new web3.eth.Contract(landSaleABI, landSaleAddress);

export default web3;