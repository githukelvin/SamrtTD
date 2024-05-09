// import { ethers } from 'hardhat';

// async function main() {
//   const nft = await ethers.deployContract('LandSale');

//   await nft.waitForDeployment();

//   console.log('LandSale Contract Deployed at ' + LandSale.target);

// //   const LandRegistry = await ethers.deployContract('LandRegistry');

// //   await LandRegistry.waitForDeployment();

// //   console.log('LandRegistry Contract Deployed at ' + LandRegistry.target);
// }

// // We recommend this pattern to be able to use async/await everywhere
// // and properly handle errors.
// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });

import { ethers } from 'hardhat';

async function main() {
  const nft = await ethers.deployContract('NFT');

  await nft.waitForDeployment();

  console.log('NFT Contract Deployed at ' + nft.target);

  const LandSale = await ethers.deployContract('LandSale');

  await LandSale.waitForDeployment();

  console.log('LandSale Contract Deployed at ' + LandSale.target);

  const LandRegistry = await ethers.deployContract('LandRegistry');

  await LandRegistry.waitForDeployment();

  console.log('LandRegistry Contract Deployed at ' + LandRegistry.target);
}


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
// npx hardhat verify --network base-sepolia  0x79cF4c128Db3cbA449B36db991E4d59b79509B9c
// npx hardhat verify --network base-sepolia 0xEE4424bbD7dB16e06950920ef10deb5f96361337

// NFT Contract Deployed at 0x1F0Bb9057fcaf9431f5Eb67A2894Cc55C795E541
// LandSale Contract Deployed at 0xEE4424bbD7dB16e06950920ef10deb5f96361337
// LandRegistry Contract Deployed at 0x79cF4c128Db3cbA449B36db991E4d59b79509B9c