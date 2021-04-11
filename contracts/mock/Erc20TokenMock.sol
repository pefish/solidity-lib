// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { Erc20Token } from "../contract/Erc20Token.sol";

contract Erc20TokenMock is Erc20Token {
    constructor(
        uint256 _initialSupply,
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) Erc20Token(_initialSupply, _name, _symbol, _decimals) {

    }
}