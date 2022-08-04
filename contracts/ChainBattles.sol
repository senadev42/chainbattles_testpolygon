// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainBattles is ERC721URIStorage {
    //Variables
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct warrior {
        uint256 Level;
        uint256 Speed;
        uint256 Strength;
        uint256 Life;
    }

    //Mapping old
    // mapping(uint256 => uint256) public tokenIdToLevels;

    mapping(uint256 => warrior) public tokenIdToData;

    //Contructor
    constructor() ERC721("Chain Battles", "CBTLS") {}

    function generateCharacter(uint256 tokenId) public returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            "<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>",
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Warrior",
            "</text>",
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Level: ",
            getLevels(tokenId),
            "</text>",
            '<text x="50%" y="60%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Speed: ",
            getSpeed(tokenId),
            "</text>",
            '<text x="50%" y="70%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Strength: ",
            getStrength(tokenId),
            "</text>",
            '<text x="50%" y="80%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Life: ",
            getLife(tokenId),
            "</text>",
            "</svg>"
        );

        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    function getLevels(uint256 tokenId) public view returns (string memory) {
        uint256 levels = tokenIdToData[tokenId].Level;
        return levels.toString();
    }

    function getSpeed(uint256 tokenId) public view returns (string memory) {
        uint256 Speed = tokenIdToData[tokenId].Speed;
        return Speed.toString();
    }

    function getStrength(uint256 tokenId) public view returns (string memory) {
        uint256 Strength = tokenIdToData[tokenId].Strength;
        return Strength.toString();
    }

    function getLife(uint256 tokenId) public view returns (string memory) {
        uint256 Life = tokenIdToData[tokenId].Life;
        return Life.toString();
    }

    function getTokenURI(uint256 tokenId) public returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Chain Battles Fighter #',
            tokenId.toString(),
            '",',
            '"description": "Battles on chain",',
            '"image": "',
            generateCharacter(tokenId),
            '"',
            "}"
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function mint() public {
        //starts out as zero
        _tokenIds.increment();

        //create new nft with tokenid value
        uint256 newItemId = _tokenIds.current();

        //send it
        _safeMint(msg.sender, newItemId);

        // tokenIdToLevels[newItemId] = 0;

        //generate map data
        tokenIdToData[newItemId].Level = 0;
        tokenIdToData[newItemId].Speed = 0;
        tokenIdToData[newItemId].Strength = 0;
        tokenIdToData[newItemId].Life = 0;

        //inherited from erc-721 standard
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
        require(_exists(tokenId), "Please use an existing token");
        require(
            ownerOf(tokenId) == msg.sender,
            "You must own this token to train it"
        );
        uint256 currentLevel = tokenIdToData[tokenId].Level;
        tokenIdToData[tokenId].Level = currentLevel + 1;
        tokenIdToData[tokenId].Speed = currentLevel + 1;
        tokenIdToData[tokenId].Strength = currentLevel + 1;
        tokenIdToData[tokenId].Life = currentLevel + 1;

        tokenIdToData[tokenId].Speed =
            tokenIdToData[tokenId].Speed *
            tokenIdToData[tokenId].Level;
        tokenIdToData[tokenId].Strength =
            tokenIdToData[tokenId].Strength *
            tokenIdToData[tokenId].Level;
        tokenIdToData[tokenId].Life =
            tokenIdToData[tokenId].Strength *
            tokenIdToData[tokenId].Level;

        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}
