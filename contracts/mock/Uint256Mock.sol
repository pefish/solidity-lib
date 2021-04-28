// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "../library/Uint256Util.sol";

contract Uint256Mock {
    using Uint256Util for uint256;

    function testToString(uint256 value) public pure returns (string memory) {
        return value.toString();
    }
}