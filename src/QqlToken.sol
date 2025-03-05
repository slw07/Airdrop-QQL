//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract QqlToken is ERC20, Ownable{
    string public constant NAME = "Qql Token";
    string public constant SYMBOL = "QQL";

    constructor(address initialOwner) 
        ERC20(NAME, SYMBOL)
        Ownable(initialOwner){}

    function mint(address to,uint256 amount) external onlyOwner{
        require(to != address(0), "Zero address");
        _mint(to, amount);
    }

}