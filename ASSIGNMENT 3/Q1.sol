 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Banking{

    mapping (address => uint256 ) public bank;

    address public Sender;
    address payable public receiver;
    constructor()  {
    Sender = payable(msg.sender);
    }

    function send(uint256 cash , address payable add) public {

        require( cash >0, "ADD MORE FUNDS");
        require(cash <= bank[msg.sender], "ADD MORE FUNDS");
        bank[msg.sender] -= cash;
        bank[add] += cash;
    }

    function deposit() public payable{
        require(msg.value>0,"ADD MORE VALUE");
        bank[msg.sender] += msg.value;

    }

    function withddraw(uint256 amt) public payable{
        require( amt >0, "ADD MORE FUNDS");
        require(amt <= bank[msg.sender], "ADD MORE FUNDS");
        require(msg.sender == Sender, "YOU ARE NOT OWNER");
        payable(msg.sender).transfer(amt);
        bank[msg.sender] -= amt;
    }
}