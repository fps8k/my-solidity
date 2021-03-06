// SPDX-License-Identifier: MIT
pragma solidity >0.6.0;

import "./Store.sol";


/*
 * @title: Delegatecall Main.
 * @author: Anthony (fps) https://github.com/0xfps.
 * @dev: 
*/
contract Main is Store {
    function add(uint _a, uint _b) public {
        total = _a + _b;
    }
}
