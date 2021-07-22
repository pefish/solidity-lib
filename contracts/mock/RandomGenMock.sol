// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { RandomGenUtil } from "../library/RandomGenUtil.sol";

contract RandomGenMock {
    function randomGen(uint256 seed, uint256 max) public view returns (uint256) {
        return RandomGenUtil.randomGen(seed, max);
    }
}
