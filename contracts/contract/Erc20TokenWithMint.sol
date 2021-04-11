// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import {Erc20Token} from "./Erc20Token.sol";

abstract contract Erc20TokenWithMint is Erc20Token {
    constructor(
        uint256 _initialSupply,
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) Erc20Token(_initialSupply, _name, _symbol, _decimals) {

    }

    function mint(address account, uint256 amount)
    external
    onlyOwner
    returns (bool)
    {
        _mint(account, amount);
        return true;
    }

    function burn(uint256 amount) external onlyOwner returns (bool) {
        _burn(msg.sender, amount);
        return true;
    }
}
