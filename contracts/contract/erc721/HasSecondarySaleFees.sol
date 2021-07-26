
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "../erc165/Erc165Base.sol";

abstract contract HasSecondarySaleFees is Erc165Base {

  event SecondarySaleFees(uint256 tokenId, address[] recipients, uint[] bps);


  struct Fee {
    address payable recipient;
    uint256 value;
  }

  // id => fees
  mapping (uint256 => Fee[]) public fees;

  /*
   * bytes4(keccak256('getFeeBps(uint256)')) == 0x0ebd4c7f
   * bytes4(keccak256('getFeeRecipients(uint256)')) == 0xb9c4d9fb
   *
   * => 0x0ebd4c7f ^ 0xb9c4d9fb == 0xb7799584
   */
  bytes4 private constant _INTERFACE_ID_FEES = 0xb7799584;

  function __HasSecondarySaleFees_init() internal {
    Erc165Base.__Erc165Base_init();
    _registerInterface(_INTERFACE_ID_FEES);
  }

  function getFeeRecipients(uint256 id) public view returns (address payable[] memory) {
    Fee[] memory _fees = fees[id];
    address payable[] memory result = new address payable[](_fees.length);
    for (uint i = 0; i < _fees.length; i++) {
      result[i] = _fees[i].recipient;
    }
    return result;
  }

  function getFeeBps(uint256 id) public view returns (uint[] memory) {
    Fee[] memory _fees = fees[id];
    uint[] memory result = new uint[](_fees.length);
    for (uint i = 0; i < _fees.length; i++) {
      result[i] = _fees[i].value;
    }
    return result;
  }
}
