//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    address public ATTACKER = makeAddr("attacker");
    string public constant TOKEN_URI =
        "ipfs://QmP2AWoyQFuXnf4kzC2aqQQdzU3TjWjZZP33ep2o9QZXL7";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Poldie";
        string memory actualName = basicNft.name();

        assertEq(
            keccak256(abi.encodePacked(expectedName)),
            keccak256(abi.encodePacked(actualName))
        );
    }

    function test_CanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNft.mintNft(TOKEN_URI);

        assert(basicNft.balanceOf(USER) == 1);
        assertEq(
            keccak256(abi.encodePacked(TOKEN_URI)),
            keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }

    function test_onlyOwnerCanTransfer() public {
        vm.prank(USER);
        basicNft.mintNft(TOKEN_URI);

        uint256 tokenId = 0;
        address initialOwner = basicNft.ownerOf(tokenId);
        vm.prank(USER);
        basicNft.transferFrom(USER, address(3), tokenId);

        vm.prank(ATTACKER);
        vm.expectRevert();
        basicNft.transferFrom(address(3), ATTACKER, tokenId);

        address finalOwner = basicNft.ownerOf(tokenId);
        assert(finalOwner == address(3));
        assert(initialOwner != finalOwner);
        assert(basicNft.ownerOf(tokenId) == address(3));
    }

    function test_ownerSetCorrectlyOnMint() public {
        vm.prank(USER);
        basicNft.mintNft(TOKEN_URI);

        uint256 tokenId = 0;
        address owner = basicNft.ownerOf(tokenId);

        assert(owner == USER);
    }

    function test_counterIncrementsAfterMint() public {
        vm.prank(USER);
        uint256 initialCounter = basicNft.getTokenCounter();

        vm.startPrank(USER);
        basicNft.mintNft(TOKEN_URI);
        vm.stopPrank();

        uint256 finalCounter = basicNft.getTokenCounter();
        assert(finalCounter == initialCounter + 1);
    }

    function test_initialTokenCounterIsZero() public view {
        uint256 initialCounter = basicNft.getTokenCounter();
        assert(initialCounter == 0);
    }

    function test_tokenIdMatchesCounterBeforeIncrement() public {
        vm.prank(USER);

        uint256 initialCounter = basicNft.getTokenCounter();
        uint256 tokenId = 0;

        vm.startPrank(USER);
        basicNft.mintNft(TOKEN_URI);
        vm.stopPrank();

        assert(tokenId == initialCounter);
    }

    function test_tokenURIStoredCorrectly() public {
        vm.startPrank(USER);
        basicNft.mintNft(TOKEN_URI);
        vm.stopPrank();

        string memory actualURI = basicNft.tokenURI(0);

        assertEq(
            keccak256(abi.encodePacked(actualURI)),
            keccak256(abi.encodePacked(TOKEN_URI))
        );
    }

    function test_approvedAddressCanTransfer() public {
        address minter = USER;
        address approved = address(4);
        address receiver = address(5);

        vm.startPrank(minter);
        basicNft.mintNft(TOKEN_URI);
        basicNft.approve(approved, 0);
        vm.stopPrank();

        vm.startPrank(approved);
        basicNft.transferFrom(minter, receiver, 0);
        vm.stopPrank();

        assertEq(basicNft.ownerOf(0), receiver);
    }

    function test_transferToZeroAddressReverts() public {
        vm.prank(USER);
        basicNft.mintNft(TOKEN_URI);

        vm.expectRevert();
        basicNft.transferFrom(USER, address(0), 0);
    }

    //function test_token
}
