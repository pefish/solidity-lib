// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import {Ownable} from "./Ownable.sol";
import {AddressUtil} from "../library/AddressUtil.sol";

abstract contract UpgradeabilityProxy is Ownable {
    event Upgraded(address indexed implementation);

    bytes32 internal constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;


    function __UpgradeabilityProxy_init () internal {
        Ownable.__Ownable_init();
    }

    function implementation() public view returns (address impl) {
        bytes32 slot = _IMPLEMENTATION_SLOT;
        assembly {
            impl := sload(slot)
        }
    }

    function upgradeTo(address newImplementation) public onlyOwner {
        _setImplementation(newImplementation);
        emit Upgraded(newImplementation);
    }

    function _setImplementation(address newImplementation) private {
        require(
            AddressUtil.isContract(newImplementation),
            "UpgradeableProxy::_setImplementation:: new implementation is not a contract"
        );

        bytes32 slot = _IMPLEMENTATION_SLOT;

        // solhint-disable-next-line no-inline-assembly
        assembly {
            sstore(slot, newImplementation)
        }
    }

    function _fallback() internal virtual {
        address implementationAddress = implementation();
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(
                gas(),
                implementationAddress,
                0,
                calldatasize(),
                0,
                0
            )

            returndatacopy(0, 0, returndatasize())

            switch result
                case 0 {
                    revert(0, returndatasize())
                }
                default {
                    return(0, returndatasize())
                }
        }
    }

    fallback () external payable virtual {
        _fallback();
    }

    receive () external payable virtual {
        _fallback();
    }
}
