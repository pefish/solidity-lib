
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "../contract/erc721/HasTokenURI.sol";
import "../contract/erc721/HasSecondarySaleFees.sol";
import "../contract/erc721/Erc721.sol";
import "../contract/erc721/Erc721Enumerable.sol";

/**
 * @title Full ERC721 Token with support for tokenURIPrefix
 * This implementation includes all the required and some optional functionality of the ERC721 standard
 * Moreover, it includes approve all functionality using operator terminology
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract Erc721Mock is HasSecondarySaleFees, HasTokenURI, Erc721Enumerable {


  /**
   * @dev Constructor function
   */
  constructor (string memory _name, string memory _symbol, string memory _tokenURIPrefix) {
    Erc721.__Erc721_init(_name, _symbol);
    HasSecondarySaleFees.__HasSecondarySaleFees_init();
    HasTokenURI.__HasTokenURI_init(_tokenURIPrefix);
  }

  function setTokenURI(uint256 tokenId, string memory uri) external {
    require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
    _setTokenURI(tokenId, uri);
  }

  function burn(address owner, uint256 tokenId) external {
    super._burn(owner, tokenId);
    _clearTokenURI(tokenId);
  }

  function mintWithFees(address to, uint256 tokenId, Fee[] memory _fees) external {
    super._mint(to, tokenId);
    address[] memory recipients = new address[](_fees.length);
    uint[] memory bps = new uint[](_fees.length);
    for (uint i = 0; i < _fees.length; i++) {
      require(_fees[i].recipient != address(0x0), "Recipient should be present");
      require(_fees[i].value != 0, "Fee value should be positive");
      fees[tokenId].push(_fees[i]);
      recipients[i] = _fees[i].recipient;
      bps[i] = _fees[i].value;
    }
    if (_fees.length > 0) {
      emit SecondarySaleFees(tokenId, recipients, bps);
    }
  }
}

