//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PlatziPunksDNA{
     string[] private _accessoriesType = [
        "Blank",
        "Kurt",
        "Prescription01",
        "Prescription02",
        "Round",
        "Sunglasses",
        "Wayfarers"
    ];

    string[] private _clotheColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private _clotheType = [
        "BlazerShirt",
        "BlazerSweater",
        "CollarSweater",
        "GraphicShirt",
        "Hoodie",
        "Overall",
        "ShirtCrewNeck",
        "ShirtScoopNeck",
        "ShirtVNeck"
    ];

    string[] private _eyeType = [
        "Close",
        "Cry",
        "Default",
        "Dizzy",
        "EyeRoll",
        "Happy",
        "Hearts",
        "Side",
        "Squint",
        "Surprised",
        "Wink",
        "WinkWacky"
    ];

    string[] private _eyebrowType = [
        "Angry",
        "AngryNatural",
        "Default",
        "DefaultNatural",
        "FlatNatural",
        "RaisedExcited",
        "RaisedExcitedNatural",
        "SadConcerned",
        "SadConcernedNatural",
        "UnibrowNatural",
        "UpDown",
        "UpDownNatural"
    ];

    string[] private _facialHairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "Platinum",
        "Red"
    ];

    string[] private _facialHairType = [
        "Blank",
        "BeardMedium",
        "BeardLight",
        "BeardMagestic",
        "MoustacheFancy",
        "MoustacheMagnum"
    ];

    string[] private _hairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "PastelPink",
        "Platinum",
        "Red",
        "SilverGray"
    ];

    string[] private _hatColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private _graphicType = [
        "Bat",
        "Cumbia",
        "Deer",
        "Diamond",
        "Hola",
        "Pizza",
        "Resist",
        "Selena",
        "Bear",
        "SkullOutline",
        "Skull"
    ];

    string[] private _mouthType = [
        "Concerned",
        "Default",
        "Disbelief",
        "Eating",
        "Grimace",
        "Sad",
        "ScreamOpen",
        "Serious",
        "Smile",
        "Tongue",
        "Twinkle",
        "Vomit"
    ];

    string[] private _skinColor = [
        "Tanned",
        "Yellow",
        "Pale",
        "Light",
        "Brown",
        "DarkBrown",
        "Black"
    ];

    string[] private _topType = [
        "NoHair",
        "Eyepatch",
        "Hat",
        "Hijab",
        "Turban",
        "WinterHat1",
        "WinterHat2",
        "WinterHat3",
        "WinterHat4",
        "LongHairBigHair",
        "LongHairBob",
        "LongHairBun",
        "LongHairCurly",
        "LongHairCurvy",
        "LongHairDreads",
        "LongHairFrida",
        "LongHairFro",
        "LongHairFroBand",
        "LongHairNotTooLong",
        "LongHairShavedSides",
        "LongHairMiaWallace",
        "LongHairStraight",
        "LongHairStraight2",
        "LongHairStraightStrand",
        "ShortHairDreads01",
        "ShortHairDreads02",
        "ShortHairFrizzle",
        "ShortHairShaggyMullet",
        "ShortHairShortCurly",
        "ShortHairShortFlat",
        "ShortHairShortRound",
        "ShortHairShortWaved",
        "ShortHairSides",
        "ShortHairTheCaesar",
        "ShortHairTheCaesarSidePart"
    ];
 //Funcion determinista y no debe ser usada en produciion
 function deterministicPseudoRandomDna(uint256 _tokenId, address _minter) public pure returns(uint256){
     //Un addres puede convertirse en un numero parseandolo de esta manera ya que al final de cuentas es codigo hexadecimal
     uint256 combineParams = _tokenId + uint160(_minter);
     //Convertimos nuestro entero en un dato represantado en bytes para generar un hash
     bytes memory encodeParams = abi.encodePacked(combineParams);
     //El keccak256 es una funcion hash  deterministica(facil de derivar el resultado pero dificil para derivar el origen)
     bytes32 hashedParams = keccak256(encodeParams);
     return uint256(hashedParams);
 }
 
    uint8 constant ADN_SECTION_SIZE =2;

    function _getDNASection (uint256 _dna, uint256 _rightDiscard) internal pure returns(uint8) {
        return uint8((_dna % (1*10 **(_rightDiscard+ADN_SECTION_SIZE)))/(1*10 **_rightDiscard));
    }

    function getAccesoriType(uint8 _dna) public view returns(string memory){
        uint8  dnaSection = _getDNASection(_dna, 0);
        return(_accessoriesType[dnaSection % _accessoriesType.length]) ;
    }
        function getClothColor(uint8 _dna) public view returns(string memory){
        uint8  dnaSection = _getDNASection(_dna, 2);
        return(_clotheColor[dnaSection % _clotheColor.length]) ;
    }

    function getClothType(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 4);
        return(_clotheType[dnaSection % _clotheType.length]);
    }
        function getEyeType(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 6);
        return(_eyeType[dnaSection %_eyeType.length]);
    }
        function getEyeBrowType(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 8);
        return(_eyebrowType[dnaSection % _eyebrowType.length]);
    }
        function getFacialHairType(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 10);
        return(_facialHairType[dnaSection % _facialHairType.length]);
    }
        function getFacialHairColor(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 12);
        return(_facialHairColor[dnaSection % _clotheColor.length]);
    }

        function getHairColor(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 14);
        return(_hairColor[dnaSection % _hairColor.length]);
    }

        function getHatColor(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 16);
        return(_hatColor[dnaSection % _hatColor.length]);
    }
        function getGraphicType(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 18);
        return(_graphicType[dnaSection % _graphicType.length]);
    }

        function getMouthType(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 20);
        return(_mouthType[dnaSection % _mouthType.length]);
    }

        function getSkinColor(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 22);
        return(_skinColor[dnaSection % _skinColor.length]);
    }
        function getTopType(uint8 _dna) public view returns(string memory){
        uint8 dnaSection = _getDNASection(_dna, 24);
        return(_topType[dnaSection % _topType.length]);
    }

    //TODO: Calculate  DNA
}