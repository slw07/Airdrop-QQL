//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
contract ERC721Token is ERC721, Ownable{

    uint256 private counter;
    string private baseURI;
    uint256 private constant MAXSUPPLY = 300;
    mapping(address account => bool) private records;

    constructor(string memory name, string memory symbol, address initialOwner) 
        ERC721(name, symbol)
        Ownable(initialOwner)
    {
        counter = 0;
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        return _baseURI();
    }

    function mint(address account) external {
        require(!records[account], "limited 1");
        uint256 tokenId = next();
        require(tokenId < MAXSUPPLY, "limited 300");
        _mint(account, tokenId);
        records[account] = true;
    }

    function _baseURI() internal override view returns (string memory){
        return baseURI;
    }

    function next() internal returns (uint256) {
        return counter ++;
    }

    function setBaseURI(string memory uri) external onlyOwner{
        baseURI = uri;
    }

}