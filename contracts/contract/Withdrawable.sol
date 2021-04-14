// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { IErc20 } from "../interface/IErc20.sol";

abstract contract Withdrawable {

    function _withdraw(address tokenAddress, uint256 amount) internal {
        if (tokenAddress == address(0)) {
            if (amount == 0) {
                amount = address(this).balance;
            }
            payable(msg.sender).transfer(amount);
        } else {
            if (amount == 0) {
                amount = IErc20(tokenAddress).balanceOf(address(this));
            }
            IErc20(tokenAddress).transfer(msg.sender, amount);
        }
    }

    function _withdrawAll (address[] memory tokenAddresses, uint256[] memory amounts) internal {
        require(tokenAddresses.length == amounts.length, "Withdrawable::_withdrawAll:: length not equals");
        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            _withdraw(tokenAddresses[i], amounts[i]);
        }
    }
}
