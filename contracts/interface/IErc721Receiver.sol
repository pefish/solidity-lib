
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IErc721Receiver {
  function onErc721Received(address operator, address from, uint256 tokenId, bytes memory data) external returns (bytes4);
}
