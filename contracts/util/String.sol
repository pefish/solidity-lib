// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

/** @title string 类型相关工具 */
library String {
    /**
     * @dev 整型数字转化为字符串
     */
    function uint256ToString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        uint256 index = digits - 1;
        temp = value;
        while (true) {
            buffer[index] = bytes1(uint8(48 + temp % 10));
            if (index > 0) {
                index = index - 1;
                temp /= 10;
            } else {
                break;
            }
        }
        return string(buffer);
    }

    function isEqual(string memory v1, string memory v2) internal pure returns (bool) {
        return uint(keccak256(abi.encodePacked(v1))) == uint(keccak256(abi.encodePacked(v2)));
    }

}