
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "./Erc721Enumerable.sol";

contract AutoTokenId is Erc721Enumerable {

  uint256 public latestTokenId;

  function _mint(address to) internal {
    latestTokenId++;
    super._mint(to, latestTokenId);
  }
}

