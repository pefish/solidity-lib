
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "./Ownable.sol";
import "./erc721/Erc721.sol";

/**
 * @title MintableToken
 * @dev anyone can mint token.
 */
contract NFT is Ownable, Erc721 {


  constructor (
    string memory name,
    string memory symbol,
    string memory contractURI,
    string memory tokenURIPrefix
  ) Erc721(name, symbol, contractURI, tokenURIPrefix) {
    __Ownable_init();
    _registerInterface(bytes4(keccak256('MINT_WITH_ADDRESS')));
  }

  function mint(uint256 tokenId, Fee[] memory _fees, string memory tokenURI) public {
    _mint(msg.sender, tokenId, _fees);
    _setTokenURI(tokenId, tokenURI);
  }

  /**
 * @dev Burns a specific ERC721 token.
 * @param tokenId uint256 id of the ERC721 token to be burned.
 */
  function burn(uint256 tokenId) public {
    //solhint-disable-next-line max-line-length
    require(_isApprovedOrOwner(msg.sender, tokenId), "NFT: caller is not owner nor approved");
    _burn(tokenId);
  }

  function setTokenURIPrefix(string memory tokenURIPrefix) external onlyOwner {
    _setTokenURIPrefix(tokenURIPrefix);
  }

  function setContractURI(string memory contractURI) external onlyOwner {
    _setContractURI(contractURI);
  }
}


