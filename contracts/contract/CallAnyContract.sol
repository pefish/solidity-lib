// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

abstract contract CallAnyContract {

    // call(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance))
    function _call(address token, bytes memory data) internal {
        (bool success, ) = address(token).call(data);
        require(success, "CallAnyContract::_call:: low-level call failed");
    }
}
