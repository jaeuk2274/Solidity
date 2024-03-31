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
        // 1. (지분율) = (lpTokenAmount) / (전체 발행된 lpTokenAmount)
        //uint lpShares = lpTokenAmount / balanceOf(address(this));
        _burn(msg.sender, lpTokenAmount);

        // 2. 총 Ether 개수 * 지분율
        uint etherAmount = address(this).balance * lpTokenAmount / balanceOf(address(this));

        // 3. 총 Token 개수 * 지분율
        ERC20 token = ERC20(tokenAddress);
        uint tokenAmount = token.balanceOf(address(this)) * lpTokenAmount / balanceOf(address(this));

        payable(msg.sender).transfer(etherAmount);
        token.transfer(msg.sender, tokenAmount);
    }

    // Price Discovery Function
    // (X, Y), (x, y)
    // (1000, 1500), (100, y) ?
    // (1000, 1500), (x, 100) ?
    function getInputPrice (
        uint inputAmount,
        uint, //inputReserve,
        uint //outputReserve
    ) public pure returns (uint outputAmount) {
        return inputAmount * 997/1000;
    }

    function getOutputPrice (
        uint outputAmount,
        uint, //inputReserve,
        uint //outputReserve
    ) public pure returns (uint inputAmount) {
        return outputAmount / 997/1000;
    }

    function etherToTokenInput(uint minTokens) public payable {
        uint etherAmount = msg.value;
        ERC20 token = ERC20(tokenAddress);

        uint tokenAmount = getInputPrice(
            etherAmount,
            address(this).balance - msg.value,
            token.balanceOf(address(this))
        );

        require(tokenAmount >= minTokens); // dapp 에서의 mev 방지      
        token.transfer(msg.sender, tokenAmount);
    }

    function etherToTokenoutput(uint tokenAmount, uint maxEtherAmount) public payable {
        uint etherAmount = tokenAmount / 997 * 1000;
        // uint etherAmount = getInputAmount();

        require(maxEtherAmount >= etherAmount); // dapp 에서의 mev 방지
        require(msg.value >= etherAmount);
        uint etherRefundAmount = msg.value - etherAmount;
        if(etherRefundAmount > 0) {
            payable(msg.sender).transfer(etherRefundAmount);
        }
        ERC20 token = ERC20(tokenAddress);
        token.transfer(msg.sender, tokenAmount);
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

AMM
DEX : AMM(LP, SWAP), OrderBook(Taker/Maker)

Fee, Ratio -> Input/Output
Fee : Swap/Taker Fee <> Protocol Fee
https://gov.uniswap.org/

*/
