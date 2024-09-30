// SPDX-License-Identifier: MIT
pragma solidity >0.4.0;

contract GuessNumber {
    uint256 luckyNumber = 666;
    struct GuessPerson {
        address person;
        uint256 number;
    }
    GuessPerson[] public guessHistory;

    function guess(uint256 guessNum) public payable {
        GuessPerson memory newGuess = GuessPerson({
            person: msg.sender,
            number: guessNum
        });
        guessHistory.push(newGuess);
        if (guessNum == luckyNumber) payable(msg.sender).transfer(msg.value * 2);
        
    }
}
