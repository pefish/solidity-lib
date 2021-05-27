// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { StringUtil } from "../library/StringUtil.sol";
import { Uint256Util } from "../library/Uint256Util.sol";

contract StringMock {
    using StringUtil for string;

    function isEqual(string memory v1, string memory v2) public pure returns (bool) {
        return v1.isEqual(v2);
    }

    function testAppend(string memory a, string memory b) public pure returns (string memory) {
        return StringUtil.append(a, b);
    }

    function testAppend1(uint256 errorCode) public pure returns (string memory) {
        require(false, StringUtil.append("error: ", Uint256Util.toString(errorCode)));
        return "";
    }

    function testRecover(string memory _msg, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
        return _msg.recover(v, r, s);
    }
}