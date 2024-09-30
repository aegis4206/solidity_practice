pragma solidity >0.4.0;

contract Purchase {
    address public seller;
    modifier onlySeller() {
        require(msg.sender == seller, "Only seller");
        _;
    }

    function f() public view onlySeller returns (uint256) {
        return 200;
    }
}
