//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";
import "./PlatziPunksDNA.sol";
contract PlatziPunks is ERC721, ERC721Enumerable, PlatziPunksDNA{
    using Counters for Counters.Counter;
    Counters.Counter private _idCounter;

    uint256 public maxSupply;
    constructor(uint256 _maxSupply) ERC721("PlatziPunks","PLPPKS"){
        maxSupply = _maxSupply;
    }
    function mint()public{
        uint256 current  = _idCounter.current();
        require(current < maxSupply,"No PlatziPunks left :(");
        _safeMint(msg.sender, current);
        _idCounter.increment();
    }
    function tokenURI(uint256 tokenId)public view  override returns(string memory){
        require(_exists(tokenId),"ERC721 Metada URI query for nonexisten token");
        string memory jsonURI = Base64.encode(
            string (abi.encodePacked(
                    '{ "name": "PlatziPunks #"}',
                    tokenId,
                    '"", "description": "Platzi Punks are randomized Avataars stored on chain to each DApp development on platzi", "image": "',
                    "//TODO: Calculate image URL",
                    '"attributtes": [{"Accesories Type": "Blank", "Clothe Color": "Red","Cloth Type":"Hoodie","Eye Type":"Close","Eye Brow Type":"Angry","Facial Hair Color":"Blonde","Facial Hair Type":"MoustacheMagnum","Hair Color":"SilverGray","Hat Color":"White","Graphic Type":"Skull","Mouth Type":"Smile","Skin Color":"light","Top Type";"LongHairMiaWallace",}]',
                '"}'   
            )
        ));
        return string(abi.encodePacked("data: application/json;base64,",jsonURI));
    }
       // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}