// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { CallAnyContract } from "../contract/CallAnyContract.sol";
import "../contract/Ownable.sol";

contract CallAnyContractMock is CallAnyContract, Ownable {
    constructor() {
        Ownable.__Ownable_init();
        CallAnyContract.__CallAnyContract_init(Ownable.owner());
    }
}