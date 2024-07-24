//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

contract MintBasicNFT is Script {
    string public constant LYM = "ipfs://QmYsgBrLAD9BdAm6vhYKB6uqpekCxPR6Yhy6ojC7L9zK61";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address ContractAddress) public {
        vm.startBroadcast();
        BasicNFT(ContractAddress).mintNFT(LYM);
        vm.stopBroadcast();
    } 

}

contract MintMoodNFT is Script {
    string public constant LYM = "ipfs://QmYsgBrLAD9BdAm6vhYKB6uqpekCxPR6Yhy6ojC7L9zK61";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("MoodNFT", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address ContractAddress) public {
        vm.startBroadcast();
        MoodNFT(ContractAddress).mintNft();
        vm.stopBroadcast();
    } 

}