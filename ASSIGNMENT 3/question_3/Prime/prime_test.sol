// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Q1.sol";

contract TestPrimeOwner {
    PrimeOwner primeOwner;

    function beforeEach() public {
        primeOwner = new PrimeOwner();
    }

    function testInitialOwner() public {
        address expected = address(this);
        address actual = primeOwner.owner();
        
        Assert.equal(actual, expected, "Owner should be the deploying address");
    }

    function testChangeOwnerIfPrime() public {
        primeOwner.changeOwnerIfPrime(7);
        
        address expected = address(this);
        address actual = primeOwner.owner();

        Assert.equal(actual, expected, "Owner should be updated to the caller's address");
    }

    function testChangeOwnerIfNotPrime() public {
        address initialOwner = primeOwner.owner();
        
        primeOwner.changeOwnerIfPrime(4);
        
        address actualOwner = primeOwner.owner();
        
        Assert.equal(actualOwner, initialOwner, "Owner should not change if input is not prime");
    }

}
