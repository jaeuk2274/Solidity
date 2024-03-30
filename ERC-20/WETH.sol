// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract JaeukWrappedEther {
    string public name = "Jaeuk Wrapped Ether";
    string public symbol = "juWETH";
    uint public decimals = 18;
    uint public totalSupply = 0;

    mapping (address owner => uint amout) public balances;
    mapping (address owner => mapping(address spender => uint)) public allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function balanceOf(address owner) public view returns (uint amount) {
        return balances[owner];
    }

    function transfer(address to, uint amount) public returns (bool success) {
        address owner = msg.sender;
        require(balances[owner] >= amount);
        balances[owner] -= amount;
        balances[to] += amount;
        emit Transfer(owner, to, amount);
        return true;
    }

    function transferFrom(address owner, address to, uint256 amount) public returns (bool success) {
        address spender = msg.sender;
        require(balances[owner] >= amount);
        require(allowances[owner][spender] >= amount);
        balances[owner] -= amount;
        balances[to] += amount;
        allowances[owner][spender] -= amount;
        emit Transfer(owner, to, amount); 
        return true;
    }

    function approve(address spender, uint amount) public returns (bool success) {
        address owner = msg.sender;
        allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint amount) {
        return allowances[owner][spender];
    }

    function deposit() public payable returns (bool success) {
        address owner = msg.sender;
        uint amount = msg.value;
       
        balances[owner] += amount;
        totalSupply += amount;
        emit Transfer(address(0), owner, amount);

        return true;
    }

    function withdraw(uint amount) public returns (bool success) {
        address owner = msg.sender;

        // Token(juWETH) Data
        balances[owner] -= amount;
        totalSupply -= amount;
        emit Transfer(owner, address(0), amount);

        // CA(Contract Account) -> owner
        payable(owner).transfer(amount);

        return true;
    }
}
