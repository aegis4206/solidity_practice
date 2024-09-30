// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

contract Faucet {
    string aa;

    constructor(string memory initAa)  {
        aa = initAa;
    }

    function withdraw(uint256 amount) public payable {
        require(amount >= 1, "Withdrawal limit exceeded");
        payable(msg.sender).transfer(amount * 1000000000000000000);
    }

    // 接收 Ether 的函數
    receive() external payable {}

    // 或者可以定義 fallback 函數來處理其他情況
    fallback() external payable {}
}
