// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

library IterableMapping {
    struct itmap {
        mapping(uint256 => IndexValue) data;
        KeyFlag[] keys;
        uint256 size;
    }
    struct IndexValue {
        uint256 keyIndex;
        uint256 value;
    }
    struct KeyFlag {
        uint256 key;
        bool deleted;
    }

    function insert(
        itmap storage self,
        uint256 key,
        uint256 value
    ) returns (bool replaced) {
        uint256 keyIndex = self.data[key].keyIndex;
        self.data[key].value = value;
        if (keyIndex > 0) return true;
        else {
            keyIndex = self.keys.length++;
            self.data[key].keyIndex = keyIndex + 1;
            self.keys[keyIndex].key = key;
            self.size++;
            return false;
        }
    }

    function remove(itmap storage self, uint256 key) returns (bool success) {
        uint256 keyIndex = self.data[key].keyIndex;
        if (keyIndex == 0) return false;
        delete self.data[key];
        self.keys[keyIndex - 1].deleted = true;
        self.size--;
    }

    function contains(itmap storage self, uint256 key) returns (bool) {
        return self.data[key].keyIndex > 0;
    }

    function iterate_start(itmap storage self) returns (uint256 keyIndex) {
        return iterate_next(self, uint256(-1));
    }

    function iterate_valid(itmap storage self, uint256 keyIndex)
        returns (bool)
    {
        return keyIndex < self.keys.length;
    }

    function iterate_next(itmap storage self, uint256 keyIndex)
        returns (uint256 r_keyIndex)
    {
        keyIndex++;
        while (keyIndex < self.keys.length && self.keys[keyIndex].deleted)
            keyIndex++;
        return keyIndex;
    }

    function iterate_get(itmap storage self, uint256 keyIndex)
        returns (uint256 key, uint256 value)
    {
        key = self.keys[keyIndex].key;
        value = self.data[key].value;
    }
}


// How to use it:
contract User
{
  // Just a struct holding our data.
  IterableMapping.itmap data;
  // Insert something
  function insert(uint k, uint v) returns (uint size)
  {
    // Actually calls itmap_impl.insert, auto-supplying the first parameter for us.
    IterableMapping.insert(data, k, v);
    // We can still access members of the struct - but we should take care not to mess with them.
    return data.size;
  }
  // Computes the sum of all stored data.
  function sum() returns (uint s)
  {
    for (var i = IterableMapping.iterate_start(data); IterableMapping.iterate_valid(data, i); i = IterableMapping.iterate_next(data, i))
    {
        var (key, value) = IterableMapping.iterate_get(data, i);
        s += value;
    }
  }
}
