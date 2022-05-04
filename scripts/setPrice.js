const { parseEther } = require("ethers/lib/utils");
const hre = require("hardhat");

async function main() {
  const parks = await (await hre.ethers.getContractFactory("PARKS")).attach("0x3f5BD6117A876dB4785Fa30770213535915bE027");

  console.log(await parks.setPrice(parseEther("1")))

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
