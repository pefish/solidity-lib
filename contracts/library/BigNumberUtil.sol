// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

struct BigNumber {
    uint mantissa;  // 存储放大了的值
}

library BigNumberUtil {
    uint constant scale = 1e36;

    function add_(BigNumber memory a, BigNumber memory b) pure internal returns (BigNumber memory) {
        return BigNumber({mantissa: add_(a.mantissa, b.mantissa)});
    }

    function add_(BigNumber memory a, uint b) pure internal returns (BigNumber memory) {
        return BigNumber({mantissa: add_(a.mantissa, mul_(b, scale))});
    }

    function add_(uint a, uint b) pure private returns (uint) {
        uint c = a + b;
        require(c >= a, "addition overflow");
        return c;
    }

    function sub_(BigNumber memory a, BigNumber memory b) pure internal returns (BigNumber memory) {
        return BigNumber({mantissa: sub_(a.mantissa, b.mantissa)});
    }

    function sub_(BigNumber memory a, uint b) pure internal returns (BigNumber memory) {
        return BigNumber({mantissa: sub_(a.mantissa, mul_(b, scale))});
    }

    function sub_(uint a, uint b) pure private returns (uint) {
        require(b <= a, "subtraction underflow");
        return a - b;
    }

    function mul_(BigNumber memory a, BigNumber memory b) pure internal returns (BigNumber memory) {
        return BigNumber({mantissa: mul_(a.mantissa, b.mantissa) / scale});
    }

    function mul_(BigNumber memory a, uint b) pure internal returns (BigNumber memory) {
        return BigNumber({mantissa: mul_(a.mantissa, b)});
    }

    function mul_(uint a, uint b) pure private returns (uint) {
        if (a == 0 || b == 0) {
            return 0;
        }
        uint c = a * b;
        require(c / a == b, "multiplication overflow");
        return c;
    }

    function div_(BigNumber memory a, BigNumber memory b) pure internal returns (BigNumber memory) {
        return BigNumber({mantissa: div_(mul_(a.mantissa, scale), b.mantissa)});
    }

    function div_(BigNumber memory a, uint b) pure internal returns (BigNumber memory) {
        return BigNumber({mantissa: div_(a.mantissa, b)});
    }

    function div_(uint a, uint b) pure private returns (uint) {
        require(b > 0, "divide by zero");
        return a / b;
    }

    function toUint(BigNumber memory a) pure internal returns (uint) {
        return a.mantissa / scale;
    }

    function toBigNumber(uint a) pure internal returns (BigNumber memory) {
        return BigNumber({mantissa: mul_(a, scale)});
    }
}
