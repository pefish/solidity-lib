
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IErc721 } from "./IErc721.sol";

interface IErc721Extend is IErc721 {
  function getFeeRecipients(uint256 id) external view returns (address payable[] memory);
  function getFeeBps(uint256 id) external view returns (uint[] memory);

}
