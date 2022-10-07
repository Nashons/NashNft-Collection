const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });

async function main() {
  //URL from where we can extract the metadata for our NFTs
  const metadataURL = "ipfs://QmQwTprZhvg6YUUhCdcabwcdmSJyjLZWrQgNJig9d4wdYD";

  /**
   * A contract factory in ethers.js is an abstraction used to deploy new smart contracts,
   * so nashNFTcontract here is a factory for instances of our NashNFT contract
   */
  const nashNFTContract = await ethers.getContractFactory("NashNFT");

  //deploy the contract 
  const deployedNashNFTContract = await nashNFTContract.deploy(metadataURL);
  await deployedNashNFTContract.deployed();

  //print the address of the deployed contract
  console.log("NashNFT Contract Address", deployedNashNFTContract.address);
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });