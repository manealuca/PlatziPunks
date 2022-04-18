//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Base64.sol";
import "./PlatziPunksDNA.sol";
contract PlatziPunks is ERC721, ERC721Enumerable, PlatziPunksDNA{
    using Counters for Counters.Counter;
    using Strings for uint256;
    Counters.Counter private _idCounter;

    uint256 public maxSupply;
    mapping(uint256=>uint256) public tokenDNA;
    constructor(uint256 _maxSupply) ERC721("PlatziPunks","PLPPKS"){
        maxSupply = _maxSupply;
    }


    function mint()public{
        uint256 current  = _idCounter.current();
        require(current <= maxSupply,"No PlatziPunks left :(");
        tokenDNA[current] = deterministicPseudoRandomDna(current, msg.sender);
        _safeMint(msg.sender, current);
        _idCounter.increment();
    }

    function _baseURI() internal pure override returns(string memory) {
        return"https://avataars.io/";
    }
    //Generaremos los parametros para modificar la apiURL
    function _paramsURI( uint256 _dna)internal view returns(string memory){
        string memory params;
        {
        params = string (abi.encodePacked(
            "accesoriesType=", getAccesoriType(uint8(_dna)),
            "&clotheColor=",getClothColor(uint8(_dna)),
            "&clotheType=",getClothType(uint8(_dna)),
            "&eyeType=",getEyeType(uint8(_dna)),
            "&eyeBrowType=",getEyeBrowType(uint8(_dna)),
            "&facialHairColor=",getFacialHairColor(uint8(_dna)),
            "&facialHairType=",getFacialHairType(uint8(_dna)),
            "&hairColor=",getHairColor(uint8(_dna)),
            "&hatColor=",getHatColor(uint8(_dna)),
            "&graphicType=",getGraphicType(uint8(_dna)),
            "&mouthType=",getMouthType(uint8(_dna)),
            "&skinColor=",getSkinColor(uint8(_dna))
            )
        );

        }
        //concatenamos el ultimo parametro de esta manera ya que al compilar se exedia el limite de memoria por bloque que permite solidity
        //Cuando nos encontremos en situaciones similares una buena solucion es dividir los parametros en varios bloques y luego concatenarlos
        return string(abi.encodePacked(params,"&topType=",getTopType(uint8(_dna))));
    }

    function imageByDna(uint256 _dna)public view returns(string memory){
        string memory baseURI = _baseURI();
        string memory paramsURI = _paramsURI(_dna);
        return string(abi.encodePacked(baseURI,"?",paramsURI));
    }


    function tokenURI(uint256 tokenId)public view  override returns(string memory){
        require(_exists(tokenId),"ERC721 Metada URI query for nonexisten token");
        uint256 dna = tokenDNA[tokenId];
        string memory image = imageByDna(dna);
        string memory jsonURI = Base64.encode(
            string (abi.encodePacked(
                    '{ "name": "PlatziPunks #"}',
                    tokenId.toString(),
                    '"", "description": "Platzi Punks are randomized Avataars stored on chain to each DApp development on platzi", "image": "',
                    "",
                    '"attributtes": [{"Accesories Type": "Blank", "Clothe Color": "Red","Cloth Type":"Hoodie","Eye Type":"Close","Eye Brow Type":"Angry","Facial Hair Color":"Blonde","Facial Hair Type":"MoustacheMagnum","Hair Color":"SilverGray","Hat Color":"White","Graphic Type":"Skull","Mouth Type":"Smile","Skin Color":"light","Top Type";"LongHairMiaWallace",}]',
                    image,               
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