// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { UpgradeabilityProxy } from "../contract/UpgradeabilityProxy.sol";

contract ProxyMock is UpgradeabilityProxy {
  constructor() {
    UpgradeabilityProxy.__UpgradeabilityProxy_init();
  }

}

