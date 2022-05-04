const hre = require("hardhat");

async function main() {
  const Parks = await hre.ethers.getContractFactory("PARKS");
  const parks = await Parks.deploy();

  await parks.deployed();

  console.log("Loot deployed to:", parks.address);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
