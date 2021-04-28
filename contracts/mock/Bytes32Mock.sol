// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "../library/Bytes32Util.sol";

contract Bytes32Mock {
    using Bytes32Util for bytes32;

    function testToHexString(bytes32 _msg) public pure returns (string memory) {
        return _msg.toHexString();
    }

}