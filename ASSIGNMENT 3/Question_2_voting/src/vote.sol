// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address public controller;
    
    struct Option {
        string title;
        uint count;
    }
    
    struct Voter {
        bool isRegistered;
        bool hasVoted;
    }
    
    Option[] public choices;
    mapping(address => Voter) public people;
    mapping(uint => bool) public optionExists;
    
    uint public totalVotes;
    
    constructor() {
        controller = msg.sender;
    }
    
    modifier onlyController() {
        require(msg.sender == controller, "YOU CAN'T");
        _;
    }
    
    function addOption(string memory title) public onlyController {
        require(!optionExists[choices.length], "THS IS INVLID");
        
        choices.push(Option(title, 0));
        optionExists[choices.length - 1] = true;
    }
    
    function registerPerson(address person) public onlyController {
        require(!people[person].isRegistered, "REGISTERED");
        
        people[person].isRegistered = true;
    }
    
    function vote(uint optionId) public {
        require(people[msg.sender].isRegistered, "ISNT REGSTERED");
        require(!people[msg.sender].hasVoted, "VOTED");
        require(optionId < choices.length, "INVALID ID");
        
        choices[optionId].count++;
        people[msg.sender].hasVoted = true;
        totalVotes++;
    }
    
    function getCount(uint optionId) public view returns (uint) {
        require(optionId < choices.length, "INVALID ID");
        
        return choices[optionId].count;
    }
    
    function getChampion() public view returns (string memory winnerTitle) {
        uint maxVotes = 0;
        uint winningOptionId = 0;
        
        for (uint i = 0; i < choices.length; i++) {
            if (choices[i].count > maxVotes) {
                maxVotes = choices[i].count;
                winningOptionId = i;
            }
        }
        
        winnerTitle = choices[winningOptionId].title;
    }
}
