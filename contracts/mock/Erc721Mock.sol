
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "../contract/erc721/Erc721.sol";
import "../contract/erc721/Erc721Enumerable.sol";
import "../contract/Ownable.sol";

/**
 * @title Full ERC721 Token with support for tokenURIPrefix
 * This implementation includes all the required and some optional functionality of the ERC721 standard
 * Moreover, it includes approve all functionality using operator terminology
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract Erc721Mock is Erc721Enumerable, Ownable {
  string public baseURI;
  uint256 public cost = 0.06 ether;
  uint256 public whitelistCost = 0 ether;
  uint256 public maxSupply;
  uint256 public maxMintNum = 20;
  bool public paused = true;
  address[] public whitelistedAddresses;

  constructor(
    string memory _name,
    string memory _symbol,
    string memory _baseURI,
    uint256 _maxSupply
  ) Erc721(_name, _symbol) {
    Ownable.__Ownable_init();

    baseURI = _baseURI;
    maxSupply = _maxSupply;
  }

  // public
  function mint(uint256 _mintAmount) public payable {
    require(!paused, "the contract is paused");
    uint256 supply = totalSupply();
    require(_mintAmount > 0, "need to mint at least 1 NFT");
    require(_mintAmount <= maxMintNum, "max mint amount per session exceeded");
    require(supply + _mintAmount <= maxSupply, "max NFT limit exceeded");

    if (msg.sender != owner()) {
      if(isWhitelisted(msg.sender)) {
        require(msg.value >= whitelistCost * _mintAmount, "insufficient funds");
      } else {
        require(msg.value >= cost * _mintAmount, "insufficient funds");
      }
    }

    for (uint256 i = 1; i <= _mintAmount; i++) {
      _safeMint(msg.sender, supply + i);
    }
  }

  function isWhitelisted(address _user) public view returns (bool) {
    for (uint i = 0; i < whitelistedAddresses.length; i++) {
      if (whitelistedAddresses[i] == _user) {
        return true;
      }
    }
    return false;
  }

  function walletOfOwner(address _owner) public view returns (uint256[] memory) {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

    string memory currentBaseURI = baseURI;
    return bytes(currentBaseURI).length > 0
    ? string(abi.encodePacked(currentBaseURI, StringUtil.toString(tokenId), ".json"))
    : "";
  }

  function setCost(uint256 _newCost, uint256 _newWhitelistCost) public onlyOwner {
    cost = _newCost;
    whitelistCost = _newWhitelistCost;
  }

  function setMaxMintNum(uint256 _newMaxMintNum) public onlyOwner {
    maxMintNum = _newMaxMintNum;
  }

  function pause(bool _state) public onlyOwner {
    paused = _state;
  }

  function whitelistUsers(address[] calldata _users) public onlyOwner {
    delete whitelistedAddresses;
    whitelistedAddresses = _users;
  }

  function withdraw() public payable onlyOwner {
    (bool maco, ) = payable(owner()).call{value: address(this).balance}("");
    require(maco);
  }
}

