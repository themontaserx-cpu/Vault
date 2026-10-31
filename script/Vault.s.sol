// SPDX-Licence-Idetifier: MIT
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.31;

import{Script, console} from "forge-std/Script.sol";
import{Vault} from "../src/Vault.sol";

contract VaultScript is Script {

    function run() external {

        vm.startBroadcast();

        // deploy contract
        Vault vault = new Vault();

        // deposit
        vault.deposit{value: 1 ether}();

        // get balance 
        uint256 balance = vault.getBalance();

        console.log("balance: ", balance);






        vm.stopBroadcast();
    }

}