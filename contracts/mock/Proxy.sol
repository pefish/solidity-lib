// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { UpgradeabilityProxy } from "../contract/UpgradeabilityProxy.sol";

contract Proxy is UpgradeabilityProxy {
    constructor (address _implementation) UpgradeabilityProxy(_implementation) {

    }

}

