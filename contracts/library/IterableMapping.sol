// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

library IterableMapping {
    struct Itmap {
        mapping(uint256 => IndexValue) data;
        KeyFlag[] keys;
        uint256 size;
    }
    struct IndexValue {
        uint256 keyIndex;  // 指向 keys 数组的第几个位置
        uint256 value;
    }
    struct KeyFlag {
        uint256 key;
        bool deleted;  // 标记这个元素是否已删除
    }

    function insert(
        Itmap storage self,
        uint256 key,
        uint256 value
    ) internal returns (bool replaced) {
        uint256 keyIndex = self.data[key].keyIndex;
        self.data[key].value = value;
        if (keyIndex > 0) return true;
        else {
            keyIndex = self.keys.length;
            self.data[key].keyIndex = keyIndex + 1;
            self.keys.push();
            self.keys[keyIndex].key = key;
            self.size++;
            return false;
        }
    }

    function remove(Itmap storage self, uint256 key) internal returns (bool success) {
        uint256 keyIndex = self.data[key].keyIndex;
        if (keyIndex == 0) return false;
        delete self.data[key];
        self.keys[keyIndex - 1].deleted = true;
        self.size--;
    }

    function contains(Itmap storage self, uint256 key) internal view returns (bool) {
        return self.data[key].keyIndex > 0;
    }

    function iterate_start(Itmap storage self) internal view returns (uint256 keyIndex) {
        return iterate_next(self, type(uint256).max);
    }

    function iterate_valid(Itmap storage self, uint256 keyIndex) internal view
        returns (bool)
    {
        return keyIndex < self.keys.length;
    }

    // 找出下一个可用元素的索引
    function iterate_next(Itmap storage self, uint256 keyIndex) internal view
        returns (uint256 r_keyIndex)
    {
        unchecked { keyIndex++ ; }
        while (keyIndex < self.keys.length && self.keys[keyIndex].deleted)
            keyIndex++;
        return keyIndex;
    }

    function iterate_get(Itmap storage self, uint256 keyIndex) internal view
        returns (uint256 key, uint256 value)
    {
        key = self.keys[keyIndex].key;
        value = self.data[key].value;
    }
}
