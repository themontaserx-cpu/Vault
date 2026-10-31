// SPDX-Licence-Identifier: MIT
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.31;

contract Vault {
    // balances mapping
    mapping(address => uint256) public balances;



    // Function deposit
    function deposit() external payable {
        // check value > 0
        require(msg.value > 0, "Insufficient amount");

        // increment user balances in mapping
        balances[msg.sender] += msg.value;

    }

    // Function withdraw
    function withdraw(uint256 amount) external {
        // check balance > amount
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // decrement amount from balance
        balances[msg.sender] -= amount;

        // send money to user
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdraw failed");

    }


    // Function get balance
    function getBalance() external view returns(uint256) {
        return balances[msg.sender];

    }

}

