
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "../Erc165.sol";

abstract contract HasSecondarySaleFees is Erc165 {

  event SecondarySaleFees(uint256 tokenId, address[] recipients, uint[] bps);

  /*
   * bytes4(keccak256('getFeeBps(uint256)')) == 0x0ebd4c7f
   * bytes4(keccak256('getFeeRecipients(uint256)')) == 0xb9c4d9fb
   *
   * => 0x0ebd4c7f ^ 0xb9c4d9fb == 0xb7799584
   */
  bytes4 private constant _INTERFACE_ID_FEES = 0xb7799584;

  constructor() {
    _registerInterface(_INTERFACE_ID_FEES);
  }

  function getFeeRecipients(uint256 id) public virtual view returns (address payable[] memory);
  function getFeeBps(uint256 id) public virtual view returns (uint[] memory);
}
