// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

interface IErc20 {
    function totalSupply() external view returns (uint256);
    function decimals() external view returns (uint8);
    function balanceOf(address guy) external view returns (uint256);
    function allowance(address src, address guy) external view returns (uint256);

    function approve(address guy, uint256 wad) external returns (bool);
    function transfer(address dst, uint256 wad) external returns (bool);
    function transferFrom(
        address src, address dst, uint256 wad
    ) external returns (bool);

//    function mint(address account, uint256 amount) external returns (bool);
//    function burn(uint256 amount) external returns (bool);

    event Approval(address indexed src, address indexed guy, uint256 wad);
    event Transfer(address indexed src, address indexed dst, uint256 wad);
}


