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