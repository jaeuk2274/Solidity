// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract UkChart is ERC721 {
    constructor() ERC721("UK CHART ANAL", "UK CHART") {
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmRroY8L59f5GASSWe7rwhV4R6UUNjsgETMqMzaKgovcZM/";
    }

    function mint(uint tokenId) public {
        _mint(msg.sender, tokenId);
    }
}
