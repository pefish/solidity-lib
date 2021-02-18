// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProxyTestMock {

    event StoreWords(uint256 addr);
    event StoreA(uint256 a);

    uint256 private words;

    function storeWords(uint256 words_) external payable {
        words = words_;
        emit StoreWords(words);
    }

    function getWords() external view returns (uint256) {
        return words;
    }

    receive () external payable {

    }
}

