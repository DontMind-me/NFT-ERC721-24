//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNFT} from "../script/DeployMoodNFT.s.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

contract DeployMoodNFTTest is Test {
    DeployMoodNFT public deployer;

    function setUp() public {
        deployer = new DeployMoodNFT();


    }

    function testsvgConvertedToURI() public view  {
        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="0" y="15" fill="black">HI YOUR BROWSER DECODED THIS</text></svg>';
        string memory expectedURI = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSIwIiB5PSIxNSIgZmlsbD0iYmxhY2siPkhJIFlPVVIgQlJPV1NFUiBERUNPREVEIFRISVM8L3RleHQ+PC9zdmc+";
        string memory convertedSVG = deployer.svgToImageURI(svg);

        console.log(expectedURI);
        console.log(convertedSVG);

        assert(keccak256(abi.encodePacked(expectedURI)) == keccak256(abi.encodePacked(convertedSVG)));
    }
}


