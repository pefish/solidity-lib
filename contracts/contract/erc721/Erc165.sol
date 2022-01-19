// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "../../interface/IErc165.sol";

abstract contract Erc165 is IErc165 {
  /**
   * @dev See {IERC165-supportsInterface}.
   */
  function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
    return interfaceId == type(IErc165).interfaceId;
  }
}
