// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ERC20{
    function transfer() external returns(bool);
    function balanceOf() external view returns(uint256);
    function allowance() external view returns(uint256);
}