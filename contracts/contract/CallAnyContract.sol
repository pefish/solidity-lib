// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import {Ownable} from "./Ownable.sol";

contract CallAnyContract is Ownable {
    // 用于使用本合约调用其他合约
    // call(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance))
    function call(address token, bytes memory data) public payable onlyOwner {
        (bool success, ) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");
    }
}
