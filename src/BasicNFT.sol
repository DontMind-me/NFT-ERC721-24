//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIDtoURI;

    constructor() ERC721("LoveYouMama", "LYM") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenURI) public {
        s_tokenIDtoURI[s_tokenCounter] = tokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory) {
        return s_tokenIDtoURI[tokenId];
    }

}