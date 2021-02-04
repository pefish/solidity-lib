// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import { IterableMapping } from "../library/IterableMapping.sol";

contract IterableMappingMock {    
    IterableMapping.Itmap private data;

    function get (uint256 key) public view returns (uint256) {
        return data.data[key].value;
    }

    function insert(uint256 k, uint256 v) public returns (uint256 size) {
        IterableMapping.insert(data, k, v);
        return data.size;
    }

    function sum() public view returns (uint256 s) {
        for (
            uint256 i = IterableMapping.iterate_start(data);
            IterableMapping.iterate_valid(data, i);
            i = IterableMapping.iterate_next(data, i)
        ) {
            (, uint256 value) = IterableMapping.iterate_get(data, i);
            s += value;
        }
    }
}