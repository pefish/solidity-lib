// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "../library/BytesUtil.sol";

contract BytesMock {
    using BytesUtil for bytes;

    function testRecover(string memory _msg, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
        return bytes(_msg).recover(v, r, s);
    }

    function testToHexString(bytes32 _msg) public pure returns (string memory) {
        bytes memory result = new bytes(32);
        result.writeBytes32(0, _msg);
        return result.toHexString();
    }

}