// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { BigNumberUtil, BigNumber } from "../library/BigNumberUtil.sol";

contract BigNumberMock {
    using BigNumberUtil for uint256;
    using BigNumberUtil for BigNumber;

    function div() public pure returns (uint256) {
        uint256 a = 10;
        BigNumber memory a1 = a.toBigNumber().div_(3);  // 尽可能保留住了精度
        return a1.mantissa;
    }
}
