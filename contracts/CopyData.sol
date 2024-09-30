// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

contract Copy {
    uint256[] data1;
    uint256[] data2;

    function append1() public {
        // data1.
        append(data1);
    }
     function append2() public {
        append(data2);
    }

    function append(uint[] storage d) internal {
        d.push();
    }
}
