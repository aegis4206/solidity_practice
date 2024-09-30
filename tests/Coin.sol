pragma solidity >=0.7.0;

contract Coin {
    mapping(address => uint256) balances;

    constructor(uint256 initalSupply) {
        balances[msg.sender] = initalSupply;
    }

    function transfer(address receiver, uint256 amount) public returns (bool) {
        require(balances[msg.sender] >= amount);
        require(balances[receiver] + amount >= balances[receiver]);

        balances[receiver] += amount;
        balances[msg.sender] -= amount;
        return true;
    }

    function send(address receiver, uint256 amount) public {}
}
