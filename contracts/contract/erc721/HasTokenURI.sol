
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import {StringUtil} from "../..//library/StringUtil.sol";

contract HasTokenURI {

  //Token URI prefix
  string public tokenURIPrefix;

  // Optional mapping for token URIs
  mapping(uint256 => string) private _tokenURIs;

  function __HasTokenURI_init(string memory _tokenURIPrefix) internal {
    tokenURIPrefix = _tokenURIPrefix;
  }

  /**
 * @dev Returns an URI for a given token ID.
 * Throws if the token ID does not exist. May return an empty string.
 * @param tokenId uint256 ID of the token to query
 */
  function tokenURI(uint256 tokenId) external view returns (string memory) {
    return _tokenURI(tokenId);
  }

  /**
   * @dev Returns an URI for a given token ID.
   * Throws if the token ID does not exist. May return an empty string.
   * @param tokenId uint256 ID of the token to query
   */
  function _tokenURI(uint256 tokenId) internal view returns (string memory) {
    return StringUtil.append(tokenURIPrefix, _tokenURIs[tokenId]);
  }

  /**
   * @dev Internal function to set the token URI for a given token.
   * Reverts if the token ID does not exist.
   * @param tokenId uint256 ID of the token to set its URI
   * @param uri string URI to assign
   */
  function _setTokenURI(uint256 tokenId, string memory uri) internal virtual {
    _tokenURIs[tokenId] = uri;
  }

  /**
   * @dev Internal function to set the token URI prefix.
   * @param _tokenURIPrefix string URI prefix to assign
   */
  function _setTokenURIPrefix(string memory _tokenURIPrefix) internal {
    tokenURIPrefix = _tokenURIPrefix;
  }

  function _clearTokenURI(uint256 tokenId) internal {
    if (bytes(_tokenURIs[tokenId]).length != 0) {
      delete _tokenURIs[tokenId];
    }
  }
}
