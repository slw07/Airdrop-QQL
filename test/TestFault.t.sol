//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import { Test } from "forge-std/Test.sol";
import { console } from "forge-std/console.sol";
import { Fault } from "../src/Fault.sol";
import { QqlToken } from "../src/QqlToken.sol";

contract TestFault is Test{
    Fault fault;
    QqlToken qql;
    address constant ACCOUNT = 0xD610B45B9C14B0CC6534a434A02A0B77C4f13eB1;
    uint256 constant TOTALSUPPLY = 10000e18;
    address constant MOCKOWNER = 0xC7072e96e93f1B499514595E8fE6B61030fc9fe9;
    function setUp() public{
        qql = new QqlToken(MOCKOWNER);
        fault = new Fault(address(qql));
    }

    function testDropWallet() public {
        vm.prank(MOCKOWNER);
        qql.mint(address(fault), TOTALSUPPLY);
        vm.startPrank(ACCOUNT);
        fault.dropWallet();
        vm.stopPrank();
        uint256 balance = qql.balanceOf(ACCOUNT);
        vm.assertEq(balance, 1e17);
    }

    function testDropAccount() public {
        vm.prank(MOCKOWNER);
        qql.mint(address(fault), TOTALSUPPLY);
        fault.dropAccount(ACCOUNT);
        uint256 accountBalance = qql.balanceOf(ACCOUNT);
        vm.assertEq(accountBalance, 1e17);
        uint256 faultBalance = qql.balanceOf(address(fault));
        vm.assertEq(faultBalance, TOTALSUPPLY - 1e17);
    }
}