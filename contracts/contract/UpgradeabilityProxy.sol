// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import {AddressUtil} from "../library/AddressUtil.sol";

abstract contract UpgradeabilityProxy {
    event Upgraded(address indexed implementation);

    bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
    bytes32 internal constant _ADMIN_SLOT = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;


    function __UpgradeabilityProxy_init () internal {
        _setAdmin(msg.sender);
    }

    // ---------------------------- modifier ----------------------------

    modifier onlyAdmin() {
        if (msg.sender == admin()) {
            _;
        } else {
            _fallback();
        }
    }

    // ---------------------------- private view function ----------------------------

    // ---------------------------- view function ----------------------------

    function admin() public view returns (address adm) {
        bytes32 slot = _ADMIN_SLOT;
        assembly {
            adm := sload(slot)
        }
    }

    function implementation() public view returns (address impl) {
        bytes32 slot = _IMPLEMENTATION_SLOT;
        assembly {
            impl := sload(slot)
        }
    }

    // ---------------------------- private function ----------------------------

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

    function _fallback() private {
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

    function _setAdmin(address newAdmin) private {
        bytes32 slot = _ADMIN_SLOT;

        assembly {
            sstore(slot, newAdmin)
        }
    }

    // ---------------------------- internal function ----------------------------



    // ---------------------------- external function ----------------------------

    function changeAdmin(address newAdmin) external onlyAdmin {
        require(newAdmin != address(0), "UpgradeableProxy::changeAdmin:: Cannot change the admin of a proxy to the zero address");
        _setAdmin(newAdmin);
    }

    function upgradeTo(address newImplementation) external onlyAdmin {
        _setImplementation(newImplementation);
        emit Upgraded(newImplementation);
    }

    fallback () external payable virtual {
        _fallback();
    }

    receive () external payable virtual {
        _fallback();
    }

    // ---------------------------- public function ----------------------------


}
