
## 🪙 VibeVault — Dynamic On-Chain Mood NFT (Solidity, Foundry, zkSync Ready)

### 🔗 Live Contract

**Deployed on Sepolia Testnet:** [0x645B18451D1f4C419688AF2522FE1411261CF114](https://sepolia.etherscan.io/address/0x645B18451D1f4C419688AF2522FE1411261CF114)

Let the demo speak.

https://github.com/user-attachments/assets/34427fb1-d466-4d76-b8b6-c0a25b98baf2

---

###  Overview

This project demonstrates advanced **NFT design**, **contract architecture**, and **stateful metadata encoding** using **Base64**, ensuring that all image data lives 100% on-chain — without relying on IPFS or external storage.
**MoodNft** is a fully on-chain, dynamic NFT that visually reflects the holder’s emotional state.
Each minted NFT starts with a **default “HAPPY” mood** and can be flipped to “SAD” (and vice versa) directly on-chain using Solidity’s efficient state management.

---

###  Key Features

**Fully On-Chain Metadata** – SVGs encoded directly into the contract using Base64.

**Dynamic NFT Logic** – Each token’s mood can toggle between “HAPPY” and “SAD.”

**ERC721 Standard** – Built on top of OpenZeppelin’s proven ERC721 implementation.

**Custom Errors for Gas Optimization** – Replaces `require()` messages for lower gas costs.

**Test Coverage with Foundry** – Includes structured unit tests following the Arrange-Act-Assert pattern.

**zkSync Compatible** – Easily deployable to Layer-2 zkSync Era networks for scalability and low fees.

**Readable & Modular Architecture** – Written with best practices in Solidity 0.8.x for maintainability and clarity.

---

## Tech Stack

| Layer             | Technology                           |
| :---------------- | :----------------------------------- |
| Smart Contracts   | Solidity ^0.8.18                     |
| Framework         | Foundry (Forge, Cast, Anvil)         |
| Standards         | ERC721, OpenZeppelin                 |
| Encoding          | Base64 On-Chain SVGs                 |
| L2 Compatibility  | zkSync Era Testnet                   |
| Verification      | Etherscan (Sepolia)                  |
| Deployment Script | Forge Script (`DeployMoodNft.s.sol`) |

---

###  Testing

Unit tests are written using **Foundry**, following the **Arrange → Act → Assert** pattern to ensure clarity and reliability.

Example:

```solidity
  function test_tokenURIReflectsMoodChange() public {
        uint256 tokenId = 0;
        vm.prank(USER);
        moodNft.mintNft();

        string memory happyTokenUri = moodNft.tokenURI(tokenId);

        vm.prank(USER);
        moodNft.flipMood(tokenId);

        string memory sadTokenUri = moodNft.tokenURI(tokenId);

        assertEq(
            keccak256(abi.encodePacked(happyTokenUri)) ==
                keccak256(abi.encodePacked(sadTokenUri)),
            false,
            "TokenURI should update to reflect mood change"
        );
    }
```

Run tests:

```bash
forge test -vvv
```

---

###  Deployment

####  Deploy to Sepolia

```bash
forge script script/DeployMoodNft.s.sol:DeployMoodNft \
--rpc-url $SEPOLIA_RPC_URL \
--private-key $PRIVATE_KEY \
--broadcast \
--verify \
--etherscan-api-key $ETHERSCAN_API_KEY
```

#### ⚡ Deploy to zkSync Era Testnet

```bash
forge script script/DeployMoodNft.s.sol:DeployMoodNft \
--rpc-url https://sepolia.era.zksync.dev \
--private-key $PRIVATE_KEY \
--broadcast
```

---

###  Contract Functions

| Function                    | Description                                 |
| :-------------------------- | :------------------------------------------ |
| `mintNft()`                 | Mints a new NFT with mood set to `HAPPY`.   |
| `flipMood(uint256 tokenId)` | Toggles the mood between `HAPPY` and `SAD`. |
| `tokenURI(uint256 tokenId)` | Returns the Base64-encoded JSON metadata.   |
| `getMood(uint256 tokenId)`  | Returns the current mood of a given token.  |
| `getTokenCounter()`         | Returns total number of NFTs minted.        |

---

###  Contract Verification

The contract is verified and viewable on **Etherscan Sepolia**:
👉 [View Verified Contract on Etherscan](https://sepolia.etherscan.io/address/0x645B18451D1f4C419688AF2522FE1411261CF114)

---

###  Best Practices Used

* **Error Customization:** `error MoodNft__CantFlipMoodIfNotOwnerOrApproved()` for gas efficiency
* **Security Checks:** Ownership and approval validation before mood flipping
* **Gas Optimization:** Minimal state updates and optimized revert conditions
* **Code Readability:** Clear separation between on-chain logic and test code

---

###  Project Structure

```
foundry-nft-f23/
├── src/
│   └── MoodNft.sol
├── script/
│   └── DeployMoodNft.s.sol
├── test/
│   └── MoodNftTest.t.sol
├── foundry.toml
└── README.md
```

---

###  Requirements

* Node.js (optional, for scripts)
* Foundry
* Rust & Cargo (for zkSync support)
* Etherscan API key (for contract verification)
* .env file configured with:

  ```
  PRIVATE_KEY=
  SEPOLIA_RPC_URL=
  ETHERSCAN_API_KEY=
  ```

---

### 🌐 Project Vision

The **MoodNft** project explores how digital identity and emotion can coexist securely on the blockchain.
Future updates may include:

* Expanding from binary emotions (happy/sad) to a **multi-emotion spectrum** represented on-chain
* Integrating **user sentiment feeds or oracles** for real-time dynamic NFTs
* Enabling **cross-layer NFT state syncing** between Ethereum and zkSync
* Introducing **metadata evolution mechanics** that reflect user activity, time, or network conditions

The broader goal is to demonstrate how NFTs can evolve beyond static collectibles —
into **living, expressive digital assets** that mirror real-world states and data in a verifiable, decentralized way.

---

###  Author

**Developer:** [Kiptoo Dennis]


**Email :** [(denniskiptoo034@gmail.com)]

---

###  License

This project is released under the **MIT License**.

---


