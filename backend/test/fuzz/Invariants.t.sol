// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

import {MoodNft} from "src/MoodNft.sol";
import {MoodNftHandler} from "./MoodNftHandler.t.sol";

contract MoodNftInvariants is StdInvariant, Test {
    MoodNft mood;
    MoodNftHandler handler;

    string SAD = "data:image/svg+xml;base64,PHNhZD48L3NhZD4=";
    string HAPPY = "data:image/svg+xml;base64,PGhhcHB5PjwvaGFwcHk+";

    function setUp() external {
        mood = new MoodNft(SAD, HAPPY);
        handler = new MoodNftHandler(mood);

        targetContract(address(handler));
        excludeContract(address(mood));
    }

    ////////////////////////////////////////////////////////////
    // INVARIANTS
    ////////////////////////////////////////////////////////////

    function invariant_counterMatchesMintCalls() public view {
        console.log("counter:", mood.getTokenCounter());
        console.log("mint calls:", handler.timesMintCalled());

        assertEq(mood.getTokenCounter(), handler.timesMintCalled());
    }

    function invariant_allMintedTokensHaveOwner() public view {
        uint256 counter = mood.getTokenCounter();

        for (uint256 i = 0; i < counter; i++) {
            address owner = mood.ownerOf(i);
            assertTrue(owner != address(0));
        }
    }

    function invariant_moodAlwaysValidRange() public view {
        uint256 counter = mood.getTokenCounter();

        for (uint256 i = 0; i < counter; i++) {
            uint256 m = uint256(mood.getMood(i));
            assertTrue(m == 0 || m == 1);
        }
    }

    function invariant_tokenUriWorksForAllMinted() public view {
        uint256 counter = mood.getTokenCounter();

        for (uint256 i = 0; i < counter; i++) {
            string memory uri = mood.tokenURI(i);
            assertGt(bytes(uri).length, 0);
        }
    }

    function invariant_baseUriConstant() public view {
        assertEq(mood.exposed_baseURI(), "data:application/json;base64,");
    }
}
