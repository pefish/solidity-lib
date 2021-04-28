// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { BytesUtil } from "./BytesUtil.sol";

/** @title string util */
library StringUtil {

    function isEqual(string memory _v1, string memory _v2) internal pure returns (bool) {
        return uint(keccak256(abi.encodePacked(_v1))) == uint(keccak256(abi.encodePacked(_v2)));
    }

    function append(string memory _a, string memory _b) internal pure returns (string memory) {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory bab = new bytes(_ba.length + _bb.length);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) bab[k++] = _ba[i];
        for (uint i = 0; i < _bb.length; i++) bab[k++] = _bb[i];
        return string(bab);
    }

    function append(string memory _a, string memory _b, string memory _c) internal pure returns (string memory) {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        bytes memory bbb = new bytes(_ba.length + _bb.length + _bc.length);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) bbb[k++] = _ba[i];
        for (uint i = 0; i < _bb.length; i++) bbb[k++] = _bb[i];
        for (uint i = 0; i < _bc.length; i++) bbb[k++] = _bc[i];
        return string(bbb);
    }

    function recover(string memory _msg, uint8 _v, bytes32 _r, bytes32 _s) internal pure returns (address) {
        return BytesUtil.recover(bytes(_msg), _v, _r, _s);
    }
}