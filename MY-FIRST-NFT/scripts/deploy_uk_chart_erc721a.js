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

    const UkChartERC721A = await hre.ethers.getContractFactory("UkChartERC721A");
    const uk_chart_erc721a = await UkChartERC721A.deploy();

    await uk_chart_erc721a.deployed();

    console.log(
        `UkChartERC721A Contract deployed to ${uk_chart_erc721a.address}`
    );

    const tx = await uk_chart_erc721a.mint(5);
    const receipt = await tx.wait();
    console.log(
        `Multiple UkChartERC721A minted via Tx ${receipt.transactionHash}(gas: ${receipt.gasUsed})`
    );
}


main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
