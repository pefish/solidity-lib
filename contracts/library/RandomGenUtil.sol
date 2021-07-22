// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

library RandomGenUtil {
  function randomGen(uint256 seed, uint256 max) internal view returns (uint256 randomNumber) {
    return (
      uint256(
        keccak256(
          abi.encodePacked(
            blockhash(block.number - 1),
            block.timestamp,
            msg.sender,
            block.difficulty,
            seed
          )
        )
      ) % max
    );
  }
}