# Reposit-rio-de-Smart-Contracts-Solidity-Hardhat-
# Web3 NFT Platform - Smart Contracts

This repository contains the core smart contracts for a decentralized NFT marketplace where users can mint NFTs using a custom ERC-20 utility token.

## Technical Stack
* **Language:** Solidity ^0.8.20
* **Framework:** Hardhat
* **Standards:** ERC-20, ERC-721 (OpenZeppelin)

## Logic Flow
1. **Utility Token:** A standard ERC-20 token used for all platform transactions.
2. **NFT Minting:** Users must call `approve` on the ERC-20 contract before calling `mintNFT`.
3. **Security:** Implements `Ownable` for administrative functions and follows best practices for interaction between contracts.

## How to Deploy
1. Clone the repo.
2. Run `npm install`.
3. Configure your `.env` with a private key and RPC provider.
4. Run `npx hardhat run scripts/deploy.js --network <your-network>`.
