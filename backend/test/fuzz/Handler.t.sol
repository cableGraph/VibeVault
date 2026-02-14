// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "src/MoodNft.sol";

contract MoodNftHandler is Test {
    MoodNft public mood;

    ////////////////////////////////////////////////////////////
    // METRICS
    ////////////////////////////////////////////////////////////

    uint256 public timesMintIsCalled;
    uint256 public timesFlipIsCalled;

    ////////////////////////////////////////////////////////////
    // STATE TRACKING (like your DSC handler pattern)
    ////////////////////////////////////////////////////////////

    address[] public usersWhoMinted;
    uint256[] public mintedTokenIds;

    constructor(MoodNft _mood) {
        mood = _mood;
    }

    ////////////////////////////////////////////////////////////
    // ACTIONS
    ////////////////////////////////////////////////////////////

    function mintNft(uint256 userSeed) public {
        address user = _addressFromSeed(userSeed);

        console.log("mintNft called — user:", user);

        vm.startPrank(user);
        mood.mintNft();
        vm.stopPrank();

        uint256 newTokenId = mood.getTokenCounter() - 1;

        usersWhoMinted.push(user);
        mintedTokenIds.push(newTokenId);

        timesMintIsCalled++;
    }

    function flipMood(uint256 tokenSeed, uint256 callerSeed) public {
        if (mintedTokenIds.length == 0) {
            return;
        }

        uint256 tokenId = mintedTokenIds[
            tokenSeed % mintedTokenIds.length
        ];

        address caller = _addressFromSeed(callerSeed);

        console.log("flipMood called — caller:", caller, "token:", tokenId);

        vm.startPrank(caller);
        try mood.flipMood(tokenId) {
            timesFlipIsCalled++;
        } catch {
            // expected often — not owner/approved
        }
        vm.stopPrank();
    }

    ////////////////////////////////////////////////////////////
    // HELPERS
    ////////////////////////////////////////////////////////////

    function _addressFromSeed(uint256 seed) internal pure returns (address) {
        return address(uint160(seed + 1));
    }

    ////////////////////////////////////////////////////////////
    // GETTERS FOR INVARIANTS
    ////////////////////////////////////////////////////////////

    function getMintCalls() external view returns (uint256) {
        return timesMintIsCalled;
    }

    function getFlipCalls() external view returns (uint256) {
        return timesFlipIsCalled;
    }

    function getMintedCount() external view returns (uint256) {
        return mintedTokenIds.length;
    }
}
