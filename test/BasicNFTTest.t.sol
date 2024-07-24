//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {

    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;
    address public USER = makeAddr("user");

    string public constant LYM = "ipfs://QmYsgBrLAD9BdAm6vhYKB6uqpekCxPR6Yhy6ojC7L9zK61";
    

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "LoveYouMama";
        string memory actualName = basicNFT.name();


        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNFT.mintNFT(LYM);

        assert(basicNFT.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(LYM)) == keccak256(abi.encodePacked(basicNFT.tokenURI(0))));
    }



}