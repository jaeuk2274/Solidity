const hre = require("hardhat");


async function main() {
    console.log(`
============================================================
               *** Deploying $UKCHART ***
               _   _ _  __   ____ _   _    _    ____ _____
               | | | | |/ /  / ___| | | |  / \  |  _ \_   _|
               | | | | ' /  | |   | |_| | / _ \ | |_) || |
               | |_| | . \  | |___|  _  |/ ___ \|  _ < | |
                \___/|_|\_\  \____|_| |_/_/   \_\_| \_\|_|
============================================================
    `)

    const UkChart = await hre.ethers.getContractFactory("UkChart");
    const uk_chart = await UkChart.deploy();

    await uk_chart.deployed();

    console.log(
        `UkChart Contract deployed to ${uk_chart.address}`
    );

    for (let i = 1; i <= 5; i++) {
        const tx = await uk_chart.mint(i);
        const receipt = await tx.wait();
        console.log(
            `UkChart #${i} minted via Tx ${receipt.transactionHash}(gas: ${receipt.gasUsed})`
        );
    }
}


main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
