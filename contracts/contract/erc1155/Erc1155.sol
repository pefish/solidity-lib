
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { Erc1155Base } from "./Erc1155Base.sol";

contract Erc1155 is Erc1155Base {
  constructor (string memory uri_) {
    Erc1155Base.__Erc1155Base_init(uri_);
  }
}
