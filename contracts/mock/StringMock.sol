// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import * as StringUtil from "../util/String.sol";

contract StringMock {
    function uint256ToString(uint256 value) public pure returns (string memory) {
        return StringUtil.String.uint256ToString(value);
    }

    function isEqual(string memory v1, string memory v2) public pure returns (bool) {
        return StringUtil.String.isEqual(v1, v2);
    }
}