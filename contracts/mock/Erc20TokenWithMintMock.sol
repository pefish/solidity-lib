// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { Erc20TokenWithMint } from "../contract/Erc20TokenWithMint.sol";

contract Erc20TokenWithMintMock is Erc20TokenWithMint {
    constructor(
        uint256 _initialSupply,
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) Erc20TokenWithMint(_initialSupply, _name, _symbol, _decimals) {

    }
}