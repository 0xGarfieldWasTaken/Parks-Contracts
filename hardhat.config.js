require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

require("dotenv").config()

const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  networks: {
    hardhat: {
      loggingEnabled: true,
      mining: {
        auto: false,
        interval: [3000, 6000]
      },
      forking : {
        url: "https://polygon-mainnet.g.alchemy.com/v2/ONPxonsXR24GXYh_AOokFnAWMJ_80cou",
      }
    },
    mumbai : {
      url: "https://polygon-mumbai.g.alchemy.com/v2/OnMC-7ETHNRwvaP9Dvr_0nt28FC91HfF",
      accounts: [`${PRIVATE_KEY}`]
    },
    mainnet : {
      url: "https://polygon-mainnet.g.alchemy.com/v2/ONPxonsXR24GXYh_AOokFnAWMJ_80cou",
      accounts: [`${PRIVATE_KEY}`]
    },
  },
  etherscan: {
    apiKey: "A92KT5NM638HPFWHISXSE1JK2R77QBYB2Q"
  },
  solidity: {
    compilers: [
      {
        version: "0.8.9"
      },
      {
        version: "0.8.7"
      }
    ]
  }
};
