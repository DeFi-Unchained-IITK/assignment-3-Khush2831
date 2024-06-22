 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";  
import "../src/Banking.sol";  

contract BankingTest is Test {
    Banking public banking;  

    function setUp() public {
        banking = new Banking(); 
    }

    function testDeposit() public {
        uint256 depositAmount = 1 ether;
        banking.deposit{value: depositAmount}();
        assertEq(banking.bank[address(this)], depositAmount);
    }

    function testSend() public {
        uint256 depositAmount = 1 ether;
        address payable receiver = payable(address(0x123));
        banking.deposit{value: depositAmount}();
        banking.send(depositAmount / 2, receiver);
        assertEq(banking.bank[address(this)], depositAmount / 2);
        assertEq(banking.bank[receiver], depositAmount / 2);
    }

    function testWithdraw() public {
        uint256 depositAmount = 1 ether;
        banking.deposit{value: depositAmount}();
        banking.withddraw(depositAmount / 2);
        assertEq(banking.bank[address(this)], depositAmount / 2);
    }

    
    
}
