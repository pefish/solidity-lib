// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { Ownable } from "./Ownable.sol";

contract UpgradeabilityProxy is Ownable {

  event Upgraded(address indexed implementation);

  bytes32 internal constant IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

  constructor(address _implementation) Ownable() {
    bytes32 slot = IMPLEMENTATION_SLOT;
    assembly {
      sstore(slot, _implementation)
    }
    emit Upgraded(_implementation);
  }

  function implementation() public view returns (address impl) {
    bytes32 slot = IMPLEMENTATION_SLOT;
    assembly {
      impl := sload(slot)
    }
  }

  function upgradeTo(address newImplementation) public onlyOwner {
    bytes32 slot = IMPLEMENTATION_SLOT;
    assembly {
      sstore(slot, newImplementation)
    }
    emit Upgraded(newImplementation);
  }


  // 不支持 string 等类型
  fallback () external payable {
    address implementationAddress = implementation();
    require(implementationAddress != address(0), "implementationAddress is address 0");
    assembly {
      calldatacopy(0, 0, calldatasize())
      let result := delegatecall(gas(), implementationAddress, 0, calldatasize(), 0, 0)

      returndatacopy(0, 0, returndatasize())

      switch result
      case 0 { revert(0, returndatasize()) }
      default { return(0, returndatasize()) }
    }
  }
}

