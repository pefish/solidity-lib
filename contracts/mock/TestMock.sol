// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;


contract TestMock {

    function testDiv() public pure returns (uint256) {
        uint256 a = uint256(10) / uint256(3);
        return a;
    }
}