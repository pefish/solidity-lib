// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

library Bytes32Util {
  function toHexString(bytes32 _value) internal pure returns (string memory) {
    bytes memory alphabet = "0123456789abcdef";
    bytes memory str = new bytes(64);
    for (uint256 i = 0; i < 32; i++) {
      str[i*2] = alphabet[uint8(_value[i] >> 4)];
      str[1+i*2] = alphabet[uint8(_value[i] & 0x0f)];
    }
    return string(str);
  }
}