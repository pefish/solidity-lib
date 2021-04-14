// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { Erc20Token } from "../contract/Erc20Token.sol";
import "../contract/Ownable.sol";

contract Erc20TokenMock is Erc20Token, Ownable {
    constructor(
        uint256 _initialSupply,
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) {
        Erc20Token.__Erc20Token_init(_initialSupply, _name, _symbol, _decimals);
        Ownable.__Ownable_init();
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