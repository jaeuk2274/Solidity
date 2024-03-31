// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    constructor() ERC20("TokenA", "A") {
        _mint(msg.sender, 50 * 10);
    }
}

contract Excange is ERC20 {
    address public tokenAddress; // TokenA("TokenA", "A") contract address
    
    // CSMM / value = (Ether, Token) = (x, y) 
    constructor(address _tokenAddress) ERC20("Uniswap V1", "UNI-V1"){
        tokenAddress = _tokenAddress;
    }

    function addLiquidity() public payable {
        uint etherAmount = msg.value;
        uint tokenAmount = etherAmount;
        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transferFrom(msg.sender, address(this), tokenAmount);
        _mint(msg.sender, etherAmount);
    }
    
    function removeLiquidity(uint lpTokenAmount) public {
        // LP token burn
        _burn(msg.sender, lpTokenAmount);
        uint etherAmount = lpTokenAmount;
        uint tokenAmount = lpTokenAmount;
        // LP 지분만큼 ether, token 반환
        payable(msg.sender).transfer(etherAmount);
        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transfer(msg.sender, tokenAmount);
    }

    function etherToTokenSwap() public payable {
        // 1:1 으로 가정 ex.Token A = WETH
        uint etherAmount = msg.value;
        uint tokenAmount = etherAmount;
        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transfer(msg.sender, tokenAmount);
    }

    function tokenToEtherSwap(uint tokenAmount) public {
        // Approve() 는 별도 tx 이미 진행 가정
        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transferFrom(msg.sender, address(this), tokenAmount);
        uint etherAmount = tokenAmount;
        payable(msg.sender).transfer(etherAmount);
    }
}


/* 
Uniswap V2
    0.3% 고정
    FeeOn : 0.25% + 0.05%(Protocol)
    if(address != 0) / address set

Uniswap V3 
    Swap Fee : 4 Types
    Protocol Fee : 1/x(4<=x<=10)
    slot0-feeProtocol

 */
