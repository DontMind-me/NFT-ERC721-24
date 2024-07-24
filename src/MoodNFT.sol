//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    //error
    error MoodNFT__CantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSVGimageUri;
    string private s_happySVGimageUri;

    enum Mood {
        Happy,
        Sad
    }

    mapping (uint256 => Mood) private s_tokenIDtoMood; 

    constructor(string memory sadSVGimageUri, string memory happySVGimageUri) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySVGimageUri = happySVGimageUri;
        s_sadSVGimageUri = sadSVGimageUri;
    }

    function _baseURI() internal pure override returns(string memory) {
        return "data:application/json;base64,";
    }

    function flipMood(uint256 tokenId) public {
        if(getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNFT__CantFlipMoodIfNotOwner();
        }

        if (s_tokenIDtoMood[tokenId] == Mood.Happy) {
            s_tokenIDtoMood[tokenId] = Mood.Sad;
        } else {
            s_tokenIDtoMood[tokenId] = Mood.Happy;
        }
    } 

    function getImageURI(uint256 tokenId) public returns(string memory) {
        string memory imageURI;
        if (s_tokenIDtoMood[tokenId] == Mood.Happy) {
            return imageURI = s_happySVGimageUri;
        } else {
            return imageURI = s_sadSVGimageUri;
        }
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIDtoMood[s_tokenCounter] = Mood.Happy;
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory) {
        string memory imageURI;
        if (s_tokenIDtoMood[tokenId] == Mood.Happy) {
            imageURI = s_happySVGimageUri;
        } else {
            imageURI = s_sadSVGimageUri;
        }
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                        abi.encodePacked(
                            '{"name":"',
                            name(), // You can add whatever name here
                            '", "description":"An NFT that reflects the owners mood. 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

}