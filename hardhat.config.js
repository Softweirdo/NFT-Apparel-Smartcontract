require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");


// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: 'rinkeby',
  networks: {
    'rinkeby': {
      url: 'https://eth-rinkeby.alchemyapi.io/v2/TUS8IAxsvB8JQWiEWO9MaXc7fGJsUjwf',
      accounts: ['30e05974d10d6b1c6fef67fe7aaf45986963a51ae5c28c231c2fada91de7b3d4']
    }
  },
  solidity: {
    version: "0.8.11",
    settings: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
},
etherscan: {
  // Your API key for Etherscan
  // Obtain one at https://etherscan.io/
  apiKey: "XDV82PA6A8GJW9DBFEVIVCC6NGQRCXTQQ5"
}
};
