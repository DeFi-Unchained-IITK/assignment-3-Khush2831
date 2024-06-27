// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrimeOwner {
    address public owner;

    event OwnerChanged(address indexed newOwner);

    constructor() {
        owner = msg.sender;
    }

    function changeOwnerIfPrime(uint _input) public {
        require(_input > 1, "Input must be greater than 1");

        if (isPrime(_input)) {
            owner = msg.sender;
            emit OwnerChanged(owner);
        }
    }

    function isPrime(uint _number) private  pure  returns (bool) {
        if (_number == 1) return false;

        uint factors = 0;
        for (uint i = 1; i <= _number; i++) {
            if (_number % i == 0) {
                factors++;
            }
        }

        return factors == 2;
    }
}
