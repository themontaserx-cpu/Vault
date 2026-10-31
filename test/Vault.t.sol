// SPDX-Licence-Idetifier: MIT
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.31;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../src/Vault.sol";

contract VaultTest is Test {
    Vault public vault;

    address user = makeAddr("user");

    // excute before every test function
    function setUp() public {
        
        vault = new Vault();
        vm.deal(user, 10 ether);

    }



    function test_Deposit() public {

        // Arrange

        // Act
        // prank > specific user sender
        vm.prank(user);
        // call deposite function from user
        vault.deposit{value: 1 ether}();

        // Assert
        vm.prank(user);
        assertEq(vault.getBalance(), 1 ether);

    }


        function test_Deposit_Revert_If_Zero_Amount() public {
            vm.expectRevert("Insufficient amount");

            vault.deposit();


        }



    function test_Withdraw() public {
        // deposit 2 ether
        uint256 depositAmount = 2 ether;
        uint256 withdrawAmount = 1 ether;

        vm.startPrank(user);
        vault.deposit{value: depositAmount}();


        // withdraw 1 ether
        uint256 balanceBefore = user.balance;
        vault.withdraw( withdrawAmount );
        uint256 balanceAfter = user.balance;

        vm.stopPrank();



        // check balance
        assertEq(vault.balances(user), depositAmount - withdrawAmount);

        // check user balance
        assertEq(balanceAfter, balanceBefore + withdrawAmount);


    }

    function test_Withdraw_Revert_If_Insufficient_Balance() public {
        // deposit 1 ether
        vm.startPrank(user);
        vault.deposit{value: 1 ether}();

        vm.expectRevert("Insufficient balance");



        // withdraw 2 ether
        vault.withdraw(2 ether);
        vm.stopPrank();
    }
}
