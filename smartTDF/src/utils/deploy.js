import Web3 from 'web3'
import RegistryABI from '../../../hardhat/artifacts/contracts/LandRegistry.sol/LandRegistry.json' assert { type: 'json' }
import SaleABI from '../../../hardhat/artifacts/contracts/LandSale.sol/LandSale.json' assert { type: 'json' }
import { environment } from './config.js'
import * as path from 'node:path'
import * as fs from 'node:fs'
// Replace with your Ethereum node URL
const web3 =new Web3(new Web3.providers.HttpProvider('https://sepolia.base.org'))

const landRegistryABI = [...RegistryABI.abi]

const landSaleABI = [...SaleABI.abi]




const landRegistryContract = new web3.eth.Contract(landRegistryABI);
const landSaleContract = new web3.eth.Contract(landSaleABI);

const landRegistryDeployer = new web3.eth.Contract(RegistryABI.abi);
const landSaleDeployer = new web3.eth.Contract(SaleABI.abi);
landRegistryContract.handleRevert = true;
landSaleContract.handleRevert = true;

landRegistryDeployer.handleRevert = true;
landSaleDeployer.handleRevert = true;
async function deploy() {
  const privateKey = environment.apiKey;
  const account = web3.eth.accounts.privateKeyToAccount(privateKey);
  const defaultAccount = account.address;
  console.log('deployer account:', defaultAccount);



  const gas = await landRegistryDeployer.deploy({
    data: '0x' + RegistryABI.bytecode,
    arguments: [1]
  }).estimateGas({ from: defaultAccount });

  console.log('estimated gas:', gas);

  try {
    const txSale = await landSaleDeployer.deploy({
      data: '0x' + SaleABI.bytecode,
      arguments: [1]
    }).send({
      from: defaultAccount
    });
    console.log('Contract deployed at address: ' + txSale.options.address);

    const tx = await landRegistryDeployer.deploy({
      data: '0x' + RegistryABI.bytecode,
      arguments: [1]
    }).send({
      from: defaultAccount
    });
    console.log('Contract deployed at address: ' + tx.options.address);

    const RegistrydeployedAddressPath = path.join(__dirname, 'RegistryContractAddress.bin');
    fs.writeFileSync(RegistrydeployedAddressPath, tx.options.address);

    const saledeployedAddressPath = path.join(__dirname, 'SaleContractAddress.bin');
    fs.writeFileSync(saledeployedAddressPath, txSale.options.address);
  } catch (error) {
    console.error(error);
  }
}

deploy()