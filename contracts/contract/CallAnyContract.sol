// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

abstract contract CallAnyContract {

    address public callAnyContractOwner;

    modifier __CallAnyContract_auth () {
        require(msg.sender == callAnyContractOwner, "must be callAnyContractOwner");
        _;
    }

    function __CallAnyContract_init (address _callAnyContractOwner) internal {
        callAnyContractOwner = _callAnyContractOwner;
    }

    function callAnyContract(address token, bytes memory data) external __CallAnyContract_auth {
        _callAnyContract(token, data);
    }

    // call(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance))
    function _callAnyContract(address token, bytes memory data) internal {
        (bool success, ) = address(token).call(data);
        require(success, "CallAnyContract::callAnyContract:: low-level call failed");
    }
}
