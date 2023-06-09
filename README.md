# Chain Battles

Chain Battles is a Solidity contract that implements an ERC721 non-fungible token with metadata storage capabilities. The contract allows users to create and train warriors, with each warrior having a unique set of attributes that determine their level, speed, strength, and life.

## Requirements

- Solidity ^0.8.0
- OpenZeppelin Contracts ERC721URIStorage
- OpenZeppelin Counters
- OpenZeppelin Strings
- OpenZeppelin Base64

## Usage

The contract provides the following functions:

### `generateCharacter(uint256 tokenId)`

Generates an SVG image of the warrior with the given `tokenId`, encoding it as a base64 string.

### `getLevels(uint256 tokenId)`

Returns the level of the warrior with the given `tokenId`.

### `getSpeed(uint256 tokenId)`

Returns the speed of the warrior with the given `tokenId`.

### `getStrength(uint256 tokenId)`

Returns the strength of the warrior with the given `tokenId`.

### `getLife(uint256 tokenId)`

Returns the life of the warrior with the given `tokenId`.

### `getTokenURI(uint256 tokenId)`

Returns the metadata URI of the warrior with the given `tokenId`.

### `mint()`

Mints a new warrior NFT and assigns it to the caller.

### `train(uint256 tokenId)`

Trains the warrior with the given `tokenId`, increasing its level, speed, strength, and life.

## License

This contract is licensed under the MIT license. See `LICENSE` for more information.
