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

// console.log('Account address:', account.address);
//
// console.log(account)
// Address 0x8D8b54f7C6064F25558D84ddf6546210aD3a7241
// Replace with the deployed contract addresses and ABIs
const landRegistryAddress = '0x8D8b54f7C6064F25558D84ddf6546210aD3a7241'
const landRegistryABI = [...RegistryABI.abi]
const landSaleAddress = '0x1891F4EC23a2f78c1295f6EE77BBAE347D29f337'
const landSaleABI = [...SaleABI.abi]
export const landRegistryContract = new web3.eth.Contract(landRegistryABI, landRegistryAddress)
export const landSaleContract = new web3.eth.Contract(landSaleABI, landSaleAddress)

export default web3
