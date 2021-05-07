
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;
import "../erc165/Erc165Base.sol";

contract HasContractURI is Erc165Base {

  string public contractURI;

  /*
   * bytes4(keccak256('contractURI()')) == 0xe8a3d485
   */
  bytes4 private constant _INTERFACE_ID_CONTRACT_URI = 0xe8a3d485;

  function __HasContractURI_init(string memory _contractURI) internal {
    Erc165Base.__Erc165Base_init();
    contractURI = _contractURI;
    _registerInterface(_INTERFACE_ID_CONTRACT_URI);
  }

  /**
   * @dev Internal function to set the contract URI
   * @param _contractURI string URI prefix to assign
   */
  function _setContractURI(string memory _contractURI) internal {
    contractURI = _contractURI;
  }
}

