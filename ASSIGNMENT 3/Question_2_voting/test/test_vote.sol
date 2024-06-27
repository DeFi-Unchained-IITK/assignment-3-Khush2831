// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "E-Voting/Assert.sol";
import "E-Voting/DeployedAddresses.sol";
import "../contracts/Voting.sol";

contract TestVoting {
    Voting voting = Voting(DeployedAddresses.Voting());

    function testAddOption() public {
        voting.addOption("Option 1");
        assert.Eq(voting.choices(0).title, "Option 1");
    }

    function testRegisterPerson() public {
        address personAddress = address(this);
        voting.registerPerson(personAddress);
        assert.isTrue(voting.people(personAddress).isRegistered);
    }

    function testVote() public {
        address personAddress = address(this);
        voting.registerPerson(personAddress);
        voting.addOption("Option 1");
        voting.vote(0);
        assert.Eq(voting.getCount(0), 1);
    }

    function testGetChampion() public {
        voting.addOption("Option 1");
        voting.addOption("Option 2");
        voting.vote(0);
        voting.vote(0);
        voting.vote(1);
        assert.Eq(voting.getChampion(), "Option 1", "Option 1 should have the most votes.");
    }
}
