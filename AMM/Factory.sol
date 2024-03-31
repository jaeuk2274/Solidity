// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract Exchange {
    uint public number;
    constructor(uint _number){
        number = _number;
    }
}

contract Factory {
    mapping(uint => address) public numberToExchange;
    mapping(address => uint) public exchangeToNumber;

    function createExchange(uint number) public returns (address) {
        Exchange created = new Exchange(number);
        numberToExchange[number] = address(created);
        exchangeToNumber[address(created)] = number;
        // numberToExchange[123] = 0x...
        // exchangeToNumber[0x...] = 123
        return address(created);
    }
}
