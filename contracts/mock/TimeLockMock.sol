// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { TimeLock } from "../contract/TimeLock.sol";

contract TimeLockMock is TimeLock {
    constructor(
        address admin_, uint delay_
    ) TimeLock(admin_, delay_) {

    }
}