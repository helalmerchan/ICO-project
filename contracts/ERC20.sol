// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BDTakaToken is ERC20 {
    conctructor() ERC20("BDTaka", "@BDT") {
        _mint(msg.sender, 10000000000000000000000000);
    }
}