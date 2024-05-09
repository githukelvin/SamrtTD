import Web3 from 'web3'
import RegistryABI from '../../../hardhat/artifacts/contracts/LandRegistry.sol/LandRegistry.json' assert { type: 'json' }
import SaleABI from '../../../hardhat/artifacts/contracts/LandSale.sol/LandSale.json' assert { type: 'json' }
import { environment } from './config.js'
// Replace with your Ethereum node URL
const web3 = new Web3('https://sepolia.base.org')

// const privateKey = process.env.PRIVATE_KEY;
// const privateKey = process.env.PRIVATE_KEY;
const privateKey = environment.apiKey
//
// console.log(environment.apiKey)
const account = web3.eth.accounts.privateKeyToAccount(privateKey)



// NFT Contract Deployed at 0x1F0Bb9057fcaf9431f5Eb67A2894Cc55C795E541
// LandSale Contract Deployed at 0xEE4424bbD7dB16e06950920ef10deb5f96361337
// LandRegistry Contract Deployed at 0x79cF4c128Db3cbA449B36db991E4d59b79509B9c

// console.log('Account address:', account.address);
//
// console.log(account)
// Address 0x8D8b54f7C6064F25558D84ddf6546210aD3a7241
// Replace with the deployed contract addresses and ABIs
const landRegistryAddress = '0x79cF4c128Db3cbA449B36db991E4d59b79509B9c'
const landRegistryABI = [...RegistryABI.abi]
const landSaleAddress = '0xEE4424bbD7dB16e06950920ef10deb5f96361337'
const landSaleABI = [...SaleABI.abi]
export const landRegistryContract = new web3.eth.Contract(landRegistryABI, landRegistryAddress)
export const landSaleContract = new web3.eth.Contract(landSaleABI, landSaleAddress)

export default web3
