// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import {Ownable} from "./Ownable.sol";
import { IErc20 } from "../interface/IErc20.sol";

contract Withdrawable is Ownable {
    function withdraw(address tokenAddress, uint256 amount) public onlyOwner {
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

    function withdrawAll (address[] memory tokenAddresses, uint256[] memory amounts) public onlyOwner {
        require(tokenAddresses.length == amounts.length, "length not equals");
        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            withdraw(tokenAddresses[i], amounts[i]);
        }
    }
}
