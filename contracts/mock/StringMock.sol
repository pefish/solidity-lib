// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { StringUtil } from "../library/StringUtil.sol";

contract StringMock {
    using StringUtil for uint256;
    using StringUtil for string;

    function uint256ToString(uint256 value) public pure returns (string memory) {
        return value.uint256ToString();
    }

    function isEqual(string memory v1, string memory v2) public pure returns (bool) {
        return v1.isEqual(v2);
    }

    function testAppend(string memory a, string memory b) public pure returns (string memory) {
        return StringUtil.append(a, b);
    }
}