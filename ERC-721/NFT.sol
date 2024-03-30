// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol
contract NFT is ERC721 {
    constructor() ERC721("My NFT", "MY NFT") {
        _mint(msg.sender, 1);
        _mint(msg.sender, 9999);
    }

    // BaseURI + TokenID = TokenURI
    // images.jaeuk.com/nft/1

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
     * by default, can be overridden in child contracts.
     */
    function _baseURI() internal pure override returns (string memory) {
        return "https://images.jaeuk.com/nft/";
    }
}
