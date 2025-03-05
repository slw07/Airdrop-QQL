//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { QqlToken } from "../src/QqlToken.sol";
contract TestQqlToken is Test {
    QqlToken qql;
    address constant owner = 0xC7072e96e93f1B499514595E8fE6B61030fc9fe9;

    function setUp() external {
        qql = new QqlToken(0xC7072e96e93f1B499514595E8fE6B61030fc9fe9);
    }

    function testTotalSupply() public{
        vm.prank(0xC7072e96e93f1B499514595E8fE6B61030fc9fe9);
        qql.mint(msg.sender, 10000 * 10e18);
        uint256 totalSupply = qql.totalSupply();
        vm.assertEq(totalSupply, 10000 * 10e18);
    }

}