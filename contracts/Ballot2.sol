// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

contract Ballot {
    struct Voter {
        uint8 weight;
        bool voted;
        uint8 vote;
        address delegate;
    }
    struct Proposal {
        bytes32 name;
        uint8 voteCount;
    }
    address public chairperson;
    Proposal[] proposals;
    mapping(address => Voter) voters;

    // constructor(bytes32[] memory _numberProposals) {
    //     chairperson = msg.sender;
    //     voters[chairperson].weight = 1;
    //     for (uint256 i = 0; i < _numberProposals.length; i++) {
    //         proposals.push(Proposal({name: _numberProposals[i], voteCount: 0}));
    //     }
    // }
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    function giveRightToVote(address voter) public {
        require(msg.sender == chairperson);
        require(voters[voter].voted == false);
        require(voters[voter].weight == 0);

        voters[voter].weight = 1;
    }

    function delegate(address to) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted);
        while (
            voters[to].delegate != address(0) &&
            voters[to].delegate != msg.sender
        ) {
            to = voters[to].delegate;
        }
        require(to != msg.sender);
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegateTo = voters[to];
        if (delegateTo.voted) {
            proposals[delegateTo.vote].voteCount += sender.weight;
        } else {
            delegateTo.weight += sender.weight;
        }
    }

    function vote(uint8 proposal) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted);
        sender.vote = proposal;
        sender.voted = true;

        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint8 winner) {
        uint8 winningCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++) {
            if (proposals[prop].voteCount > winningCount) {
                winningCount = proposals[prop].voteCount;
                winner = prop;
            }
        }
        return winningCount;
    }
}
