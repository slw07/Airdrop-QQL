//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import { Test } from "forge-std/Test.sol";
import { ERC721Token } from "../src/ERC721Token.sol";

contract TestERC721Token is Test {
    ERC721Token token;
    string constant NAME = "qql token";
    string constant SYMBOL = "QQL";
    address constant OWNER = 0xC7072e96e93f1B499514595E8fE6B61030fc9fe9;

    function setUp() public {
        token = new ERC721Token(NAME, SYMBOL, OWNER);
    }

    function testMint() public {
        vm.prank(OWNER);
        token.setBaseURI("http://baidu.com");
        token.mint(OWNER);
        uint256 tokenId = token.balanceOf(OWNER);
        vm.assertEq(tokenId, 1);
    }

    function testMintMul() public {
        vm.prank(OWNER);
        token.setBaseURI("http://baidu.com");
        token.mint(OWNER);
        vm.expectRevert("limited 1");
        token.mint(OWNER);
        
    }
}