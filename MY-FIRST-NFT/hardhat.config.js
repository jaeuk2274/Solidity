require("@nomicfoundation/hardhat-toolbox");

require('dotenv').config()

const namehash = require('eth-ens-namehash');
const readline = require('readline');


// Custom Task(Plugin)
task("namehash", "@ansuchan.eth: Get the namehash and its decimal form of an ethereum name")
    .addParam("ens", "ENS(Ethereum Name Service) Text")
    .setAction(async (taskArgs, hre, runSuper) => {
        var hash = namehash.hash(taskArgs.ens);
        var decimalHash = BigInt('0x' + hash.slice(2)).toString();
        console.log(`[${taskArgs.ens}]\n* Hex => ${hash}\n* Decimal => ${decimalHash}`);
    }
);


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: "0.8.20",
    networks: {
        sepolia: {
            url: `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`,
            accounts: [
                `${process.env.PRIVATE_KEY}`,
            ],
        },
    },
};
