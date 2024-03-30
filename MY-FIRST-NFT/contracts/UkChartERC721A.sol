// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


import "erc721a/contracts/ERC721A.sol";


contract UkChartERC721A is ERC721A {
    constructor() ERC721A("UK CHART ANAL", "UK CHART") {
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmRroY8L59f5GASSWe7rwhV4R6UUNjsgETMqMzaKgovcZM/";
    }

    function mint(uint quantity) public {
        _mint(msg.sender, quantity);
    }

    function _startTokenId() internal pure override returns (uint256) {
        return 1;
    }
}
