// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { BigNumberUtil, BigNumber } from "../library/BigNumberUtil.sol";

contract BigNumberMock {
    using BigNumberUtil for BigNumber;

    function calc() public pure returns (uint256) {
        // 10 / (50 / 200 * 400) * 1230 = 123
        uint256 a = 10;
        uint256 b = 50;
        BigNumber memory a1 = BigNumberUtil.toBigNumber(b).div_(200).mul_(400);  // 100
        return BigNumberUtil.toBigNumber(a).div_(a1).mul_(1230).toUint();
    }
}
